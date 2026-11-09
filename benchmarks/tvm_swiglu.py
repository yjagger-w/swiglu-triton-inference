"""CPU evidence and isolated T4 trace/benchmark entry point (no model loading)."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import statistics
import subprocess
import sys
import time
import traceback

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "src"))
PROVIDERS = ("eager", "compiled", "triton", "tvm_off", "tvm_on")


def save(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, indent=2, allow_nan=False) + "\n", encoding="utf-8")


def sources(lib, directory):
    """Save actual compiler output, with failures explicit in the manifest."""
    directory.mkdir(parents=True, exist_ok=True)
    records = []
    def walk(m):
        idx = len(records)
        row = {"index": idx, "kind": m.kind, "sources": {}, "errors": {}}
        records.append(row)
        formats = (("cuda", "cu"), ("ptx", "ptx")) if m.kind == "cuda" else (
            (("ll", "ll"),) if m.kind == "llvm" else ()
        )
        for fmt, suffix in formats:
            try:
                code = m.inspect_source(fmt)
                if not code:
                    raise ValueError(f"No {fmt} source returned by TVM")
                name = f"module_{idx}.{suffix}"
                (directory / name).write_text(code, encoding="utf-8")
                row["sources"][suffix] = name
            except Exception as exc:
                row["errors"][suffix] = str(exc)
        for child in m.imports:
            walk(child)
    walk(lib)
    save(directory / "modules.json", records)
    return records


def vm_evidence(exe):
    text = exe.as_text()
    calls = [line.strip() for line in text.splitlines() if line.strip().startswith("call ")]
    return {"tensor_calls": [line for line in calls if "vm.builtin." not in line],
            "tensor_allocations": sum("vm.builtin.alloc_tensor" in line for line in calls)}


def profile_kernels(torch, fn, calls, path):
    """Collect device kernel durations in the trace process, outside benchmark timing."""
    torch.cuda.synchronize()
    try:
        with torch.profiler.profile(activities=[torch.profiler.ProfilerActivity.CUDA]) as prof:
            for _ in range(calls):
                output = fn()
            torch.cuda.synchronize()
        del output
        prof.export_chrome_trace(str(path))
    except RuntimeError as exc:
        return {"status": "unavailable", "reason": str(exc)}
    events = json.loads(path.read_text(encoding="utf-8"))["traceEvents"]
    kernels = [event for event in events if event.get("cat") == "kernel"]
    if not kernels or len(kernels) % calls:
        return {"status": "incomplete", "calls": calls, "kernel_count": len(kernels)}
    return {"status": "passed", "calls": calls, "kernel_count": len(kernels),
            "kernels_per_call": len(kernels) // calls,
            "kernel_ms_per_call": sum(event["dur"] for event in kernels) / (calls * 1000),
            "kernel_names": sorted({event["name"] for event in kernels})}


def environment():
    import tvm
    from importlib.metadata import version
    return {"python": sys.version, "platform": platform.platform(),
            "tvm": tvm.__version__, "ffi": version("apache-tvm-ffi"),
            "tvm_build": tvm.support.libinfo(),
            "git_head": subprocess.run(["git", "rev-parse", "HEAD"], cwd=ROOT,
                                       capture_output=True, text=True).stdout.strip(),
            "git_status": subprocess.run(["git", "status", "--short"], cwd=ROOT,
                                         capture_output=True, text=True).stdout}


def cpu(args):
    import tvm
    from swiglu_tvm.operator import build_operator, primfunc, schedule
    from swiglu_tvm.cuda import export_cuda_source
    from swiglu_tvm.fusion import example, build_relax
    save(args.output / "environment.json", environment())
    for dtype in ("float32", "float16"):
        path = args.output / dtype
        path.mkdir(parents=True, exist_ok=True)
        original = example((1025,), dtype)
        (path / "before.py").write_text(original.script(), encoding="utf-8")
        for enabled in (False, True):
            exe, mod, lowered = build_relax(original, enabled=enabled, fp16=True)
            label = "on" if enabled else "off"
            (path / f"after_{label}.py").write_text(mod.script(), encoding="utf-8")
            (path / f"legalized_{label}.py").write_text(lowered.script(), encoding="utf-8")
            (path / f"vm_{label}.txt").write_text(exe.as_text(), encoding="utf-8")
            save(path / f"vm_evidence_{label}.json", vm_evidence(exe))
            sources(exe.mod, path / f"code_{label}")
            _, _, cuda_low = build_relax(original, {"kind": "cuda", "arch": "sm_75"},
                                        enabled=enabled, fp16=True,
                                        source_only=path / f"relax_{label}_source_only.cu")
            (path / f"legalized_cuda_{label}.py").write_text(cuda_low.script(), encoding="utf-8")
            code = (path / f"relax_{label}_source_only.cu").read_text(encoding="utf-8")
            names = re.findall(r'extern "C" __global__ [^\n;{]*? (\w+)\([^()\n]*\) \{', code)
            save(path / f"cuda_codegen_{label}.json", {"kernel_definitions": names,
                 "count": len(names), "compiled": False, "executed": False})
        lib, mod = build_operator((1025,), dtype)
        (path / "tensor_cpu.py").write_text(mod.script(), encoding="utf-8")
        # Scheduling IR can be produced without a CUDA device. Not GPU execution.
        gpu = schedule(primfunc((1025,), dtype, cuda=True), cuda=True)
        (path / "tensor_cuda_scheduled.py").write_text(gpu.script(), encoding="utf-8")
        export_cuda_source(gpu, path / "kernel_source_only.cu")
        aligned = schedule(primfunc((1, 5632), dtype, cuda=True), cuda=True)
        (path / "tensor_cuda_aligned.py").write_text(aligned.script(), encoding="utf-8")
        export_cuda_source(aligned, path / "kernel_aligned_source_only.cu")
        sources(lib, path / "tensor_code")
    save(args.output / "status.json", {"cpu_ir": "passed", "cuda_execution": "not_run",
         "t4_performance": "not_run", "reason": "CPU evidence phase; separate T4 command required"})


def gpu(args, trace=False):
    import numpy as np
    import torch
    import tvm
    import triton
    from tvm import relax
    from swiglu_tvm.fusion import example, build_relax
    from swiglu_triton import swiglu_torch, swiglu_triton
    from trace_compile_swiglu import measure_block
    if not torch.cuda.is_available():
        raise RuntimeError("CUDA unavailable; GPU acceptance not_run")
    props = torch.cuda.get_device_properties(0)
    if "T4" not in props.name or (props.major, props.minor) != (7, 5):
        raise RuntimeError(f"T4 required; found {props.name}")
    env = environment()
    env.update(torch=torch.__version__, triton=triton.__version__, cuda=torch.version.cuda,
               gpu=props.name, capability=[props.major, props.minor],
               driver=subprocess.run(["nvidia-smi"], capture_output=True, text=True).stdout)
    save(args.output / "environment.json", env)
    rows = []
    torch._dynamo.config.suppress_errors = False
    for dtype in ("float32", "float16"):
        gen = torch.Generator(device="cuda").manual_seed(42)
        for shape in ((1, 5632), (128, 5632), (1024, 5632), (1025,)):
            path = args.output / (dtype + "_" + "x".join(map(str, shape)))
            path.mkdir(parents=True, exist_ok=True)
            g, u = (torch.randn(shape, dtype=getattr(torch, dtype), device="cuda", generator=gen)
                    for _ in range(2))
            ga, ua = (tvm.runtime.from_dlpack(x) for x in (g, u))
            # Share Torch's current stream; no implicit cross-stream race/timing omission.
            tvm.cuda().set_raw_stream(torch.cuda.current_stream().cuda_stream)
            functions = {"eager": lambda: swiglu_torch(g, u), "triton": lambda: swiglu_triton(g, u)}
            compile_times = {}
            start = time.perf_counter()
            functions["triton"]()
            torch.cuda.synchronize()
            compile_times["triton_first_call_seconds"] = time.perf_counter() - start
            start = time.perf_counter()
            compiled = torch.compile(swiglu_torch, fullgraph=True, dynamic=False,
                                     options={"triton.cudagraphs": False})
            compiled(g, u)
            torch.cuda.synchronize()
            compile_times["compiled_first_call_seconds"] = time.perf_counter() - start
            functions["compiled"] = lambda: compiled(g, u)
            original = example(shape, dtype)
            (path / "before.py").write_text(original.script(), encoding="utf-8")
            for enabled in (False, True):
                label = "tvm_on" if enabled else "tvm_off"
                start = time.perf_counter()
                exe, mod, low = build_relax(original, {"kind": "cuda", "arch": "sm_75"}, enabled, fp16=True)
                vm = relax.VirtualMachine(exe, tvm.cuda())
                vm["main"](ga, ua)
                torch.cuda.synchronize()
                compile_times[label + "_build_first_call_seconds"] = time.perf_counter() - start
                functions[label] = lambda vm=vm: vm["main"](ga, ua)
                if trace:
                    (path / f"after_{label}.py").write_text(mod.script(), encoding="utf-8")
                    (path / f"legalized_{label}.py").write_text(low.script(), encoding="utf-8")
                    (path / f"vm_{label}.txt").write_text(exe.as_text(), encoding="utf-8")
                    save(path / f"vm_evidence_{label}.json", vm_evidence(exe))
                    sources(exe.mod, path / label)
            expected = functions["eager"]()
            accuracy = {}
            tol = 3e-5 if dtype == "float32" else 3e-3
            for name, fn in functions.items():
                actual = fn()
                if name.startswith("tvm"):
                    actual = torch.from_dlpack(actual)
                torch.cuda.synchronize()
                error = (actual.float() - expected.float()).abs()
                bits = torch.int16 if dtype == "float16" else torch.int32
                accuracy[name] = {"bitwise_mismatches": int((actual.view(bits) != expected.view(bits)).sum()),
                                  "max_abs_error": float(error.max()),
                                  "tolerance_passed": bool(torch.isclose(actual, expected, rtol=tol, atol=tol).all())}
            row = {"dtype": dtype, "shape": shape, "compile": compile_times,
                   "accuracy": accuracy, "rtol": tol, "atol": tol, "samples": []}
            row["input_sha256"] = [hashlib.sha256(x.cpu().numpy().tobytes()).hexdigest() for x in (g, u)]
            rows.append(row)
            save(args.output / "raw.json", rows)
            if not all(a["tolerance_passed"] for a in accuracy.values()):
                raise RuntimeError("existing operator tolerance failed; see raw.json; no timing")
            if dtype == "float16" and any(accuracy[n]["bitwise_mismatches"] for n in ("tvm_on", "tvm_off")):
                raise RuntimeError("TVM FP16 bitwise contract failed; see raw.json; no timing")
            if trace:
                row["profile"] = {
                    name: profile_kernels(torch, functions[name], args.warmup, path / f"profile_{name}.json")
                    for name in PROVIDERS
                }
                save(args.output / "raw.json", rows)
                continue
            for fn in functions.values():
                for _ in range(args.warmup):
                    fn()
            torch.cuda.synchronize()
            # 10 rounds: each of five providers occupies each order position twice.
            for r in range(args.rounds):
                order = PROVIDERS[r % 5:] + PROVIDERS[:r % 5]
                for name in order:
                    sample = measure_block(torch, functions[name], args.calls)
                    row["samples"].append(dict(round=r, provider=name, order=list(order), **sample))
            save(args.output / "raw.json", rows)
    if not trace:
        lines = ["| dtype | shape | provider | wall ms/call | event interval ms/call |",
                 "|---|---|---|---:|---:|"]
        for row in rows:
            for name in PROVIDERS:
                samples = [x for x in row["samples"] if x["provider"] == name]
                wall = statistics.median(x["wall_ms_per_call"] for x in samples)
                event = statistics.median(x["event_interval_ms_per_call"] for x in samples)
                lines.append(f"|{row['dtype']}|{row['shape']}|{name}|{wall:.6f}|{event:.6f}|")
        (args.output / "summary.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    save(args.output / "status.json", {"status": "passed", "phase": "trace" if trace else "benchmark",
         "event_note": "stream interval includes submission gaps; not pure kernel time",
         "wall_note": "host dispatch, output allocation, final synchronization included"})


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("phase", choices=["cpu", "t4", "trace", "benchmark"])
    p.add_argument("--output", type=Path, default=ROOT / "results/tvm_swiglu")
    p.add_argument("--warmup", type=int, default=25)
    p.add_argument("--calls", type=int, default=100)
    p.add_argument("--rounds", type=int, default=10)
    args = p.parse_args()
    if min(args.warmup, args.calls, args.rounds) < 1 or args.rounds % 5:
        p.error("positive warmup/calls and rounds divisible by five required")
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=True)
    try:
        if args.phase == "cpu":
            cpu(args)
        elif args.phase == "t4":
            with (args.output / "pytest.log").open("w", encoding="utf-8") as log:
                env = dict(os.environ, PYTHONPATH=str(ROOT / "src"))
                subprocess.run([sys.executable, "-m", "pytest", "-q"], cwd=ROOT,
                               env=env, stdout=log, stderr=subprocess.STDOUT, check=True)
            # Fresh processes and separate caches; debug capture cannot contaminate timing.
            from trace_compile_swiglu import worker_env
            for phase in ("trace", "benchmark"):
                output = args.output / phase
                output.mkdir(parents=True, exist_ok=True)
                env = worker_env("benchmark", output)  # strip inherited debug flags for both
                cmd = [sys.executable, __file__, phase, "--output", str(output),
                       "--warmup", str(args.warmup), "--calls", str(args.calls), "--rounds", str(args.rounds)]
                with (output / "run.log").open("w", encoding="utf-8") as log:
                    subprocess.run(cmd, env=env, stdout=log, stderr=subprocess.STDOUT, check=True)
        else:
            gpu(args, trace=args.phase == "trace")
    except Exception:
        save(args.output / "status.json", {"status": "failed", "phase": args.phase,
             "traceback": traceback.format_exc(), "performance_claim": False})
        raise


if __name__ == "__main__":
    main()
