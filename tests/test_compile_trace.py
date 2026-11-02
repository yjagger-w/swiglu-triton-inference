"""Launcher/evidence regression tests; no torch, Triton or CUDA required."""

import contextlib
import importlib.util
import io
import json
import tempfile
import unittest
from collections import Counter
from pathlib import Path
from unittest.mock import patch


SCRIPT = Path(__file__).resolve().parents[1] / "benchmarks/trace_compile_swiglu.py"
SPEC = importlib.util.spec_from_file_location("compile_trace", SCRIPT)
trace = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(trace)


class CompileTraceTests(unittest.TestCase):
    def test_debug_settings_are_not_inherited_by_benchmark(self):
        parent = {key: "inherited-debug" for key in trace.DEBUG_ENV}
        parent.update({"PYTHONPATH": "existing-path", "OMP_NUM_THREADS": "invalid",
                       "CUDA_VISIBLE_DEVICES": "0"})
        root = Path("/tmp/example-run")
        diagnostic = trace.worker_env("trace", root, parent)
        benchmark = trace.worker_env("benchmark", root, parent)
        self.assertEqual(diagnostic["TORCH_COMPILE_DEBUG"], "1")
        self.assertIn("output_code", diagnostic["TORCH_LOGS"])
        self.assertTrue(trace.DEBUG_ENV.isdisjoint(benchmark))
        self.assertNotEqual(diagnostic["TORCHINDUCTOR_CACHE_DIR"],
                            benchmark["TORCHINDUCTOR_CACHE_DIR"])
        self.assertEqual(benchmark["OMP_NUM_THREADS"], "1")
        self.assertEqual(benchmark["CUDA_VISIBLE_DEVICES"], "0")
        self.assertEqual(parent["OMP_NUM_THREADS"], "invalid")

    def test_six_rounds_balance_every_position(self):
        counts = [Counter() for _ in trace.PROVIDERS]
        for index in range(6):
            order = trace.rotation(index)
            self.assertEqual(set(order), set(trace.PROVIDERS))
            for position, provider in enumerate(order):
                counts[position][provider] += 1
        for position in counts:
            self.assertEqual(set(position.values()), {2})

    def test_invalid_repeats_are_rejected_before_creating_output(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary) / "new"
            with contextlib.redirect_stderr(io.StringIO()), self.assertRaises(SystemExit):
                trace.main(["--output-dir", str(output), "--repeats", "5"])
            self.assertFalse(output.exists())

    def test_existing_evidence_is_never_overwritten(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            original = output / "evidence.txt"
            original.write_text("keep", encoding="utf-8")
            with contextlib.redirect_stderr(io.StringIO()), self.assertRaises(SystemExit):
                trace.main(["--output-dir", str(output)])
            self.assertEqual(original.read_text(), "keep")

    def test_missing_ir_does_not_claim_complete_capture(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            trace_dir = output / "trace/inductor_debug/model.0"
            trace_dir.mkdir(parents=True)
            (trace_dir / "output_code.py").write_text("# test fixture", encoding="utf-8")
            trace.write_json(output / "preflight.json", {"status": "passed"})
            trace.write_json(output / "trace/result.json", {"rows": []})
            result = trace.summarize(output, {"preflight": 0, "trace": 0})
            self.assertEqual(result["status"], "incomplete_compiler_artifacts")
            self.assertIn("ir_post_fusion.txt", result["missing_compiler_artifact_names"])
            self.assertEqual(len(result["artifacts"]), 1)
            self.assertEqual(len(result["artifacts"][0]["sha256"]), 64)

    def test_failed_preflight_stops_before_trace_and_benchmark(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary) / "run"
            calls = []

            def fail(command, **kwargs):
                calls.append(command[-1])
                trace.write_json(output / "preflight_failure.json", {"error": "no GPU"})
                return type("Result", (), {"returncode": 2})()

            with patch.object(trace, "source_info", return_value={}), \
                    patch.object(trace.subprocess, "run", side_effect=fail), \
                    contextlib.redirect_stdout(io.StringIO()):
                code = trace.main(["--output-dir", str(output)])
            self.assertEqual(code, 2)
            self.assertEqual(calls, ["preflight"])
            summary = json.loads((output / "summary.json").read_text())
            self.assertEqual(summary["status"], "worker_failed")
            self.assertFalse((output / "benchmark/result.json").exists())

    def test_child_commands_and_logs_are_separated(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary) / "run"
            invocations = []

            def child(command, **kwargs):
                phase = command[-1]
                invocations.append((phase, kwargs["env"]))
                if phase == "trace":
                    target = output / "trace/inductor_debug/test_fixture"
                    target.mkdir(parents=True)
                    for name in ("fx_graph_readable.py", "ir_pre_fusion.txt",
                                 "ir_post_fusion.txt", "output_code.py"):
                        (target / name).write_text("# test fixture", encoding="utf-8")
                trace.write_json(output / ("preflight.json" if phase == "preflight"
                                          else phase + "/result.json"), {"rows": []})
                return type("Result", (), {"returncode": 0})()

            with patch.object(trace, "source_info", return_value={}), \
                    patch.object(trace.subprocess, "run", side_effect=child), \
                    contextlib.redirect_stdout(io.StringIO()):
                code = trace.main(["--output-dir", str(output)])
            self.assertEqual(code, 0)
            self.assertEqual([phase for phase, _ in invocations],
                             ["preflight", "trace", "benchmark"])
            self.assertIn("TORCH_LOGS", invocations[1][1])
            self.assertNotIn("TORCH_LOGS", invocations[2][1])
            self.assertTrue(all((output / (phase + ".log")).exists()
                                for phase, _ in invocations))

    def test_worker_failure_preserves_completed_stage(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            existing = output / "trace/result.json"
            existing.parent.mkdir()
            existing.write_text('{"status":"completed"}', encoding="utf-8")
            result = trace.summarize(output, {"preflight": 0, "trace": 0, "benchmark": 2})
            self.assertEqual(result["status"], "worker_failed")
            self.assertEqual(json.loads(existing.read_text())["status"], "completed")

    def test_zero_exit_without_results_is_not_completion(self):
        with tempfile.TemporaryDirectory() as temporary:
            result = trace.summarize(Path(temporary), {"preflight": 0, "benchmark": 0})
            self.assertEqual(result["status"], "incomplete_result_files")
            self.assertIn("benchmark/result.json", result["missing_result_files"])

    def test_failed_accuracy_remains_exploratory(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            trace.write_json(output / "preflight.json", {"status": "passed"})
            trace.write_json(output / "benchmark/result.json", {"rows": [
                {"accuracy_status": "exploratory_strict_tolerance_failed"}]})
            result = trace.summarize(output, {"preflight": 0, "benchmark": 0})
            self.assertEqual(result["status"], "exploratory_strict_tolerance_failed")

    def test_artifacts_from_one_shape_do_not_cover_another(self):
        with tempfile.TemporaryDirectory() as temporary:
            output = Path(temporary)
            rows = []
            for tokens in (1, 128):
                relative = f"trace/inductor_debug/t{tokens}_f5632"
                target = output / relative
                target.mkdir(parents=True)
                names = ("fx_graph_readable.py", "ir_pre_fusion.txt",
                         "ir_post_fusion.txt", "output_code.py")
                for name in names if tokens == 1 else names[:1]:
                    (target / name).write_text("# fixture", encoding="utf-8")
                rows.append({"inductor_debug_dir": relative})
            trace.write_json(output / "preflight.json", {"status": "passed"})
            trace.write_json(output / "trace/result.json", {"rows": rows})
            result = trace.summarize(output, {"preflight": 0, "trace": 0})
            self.assertEqual(result["status"], "incomplete_compiler_artifacts")
            self.assertIn("trace/inductor_debug/t128_f5632/output_code.py",
                          result["missing_compiler_artifact_names"])


if __name__ == "__main__":
    unittest.main()
