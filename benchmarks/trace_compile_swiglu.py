"""Capture compiler evidence and time SwiGLU in separate fresh processes.

The launcher and its unit tests need only the standard library. GPU workers need
the project's CUDA PyTorch/Triton environment (originally 2.6.0 / 3.2.0).
"""

import argparse
import hashlib
import json
import os
import platform
import statistics
import subprocess
import sys
import time
import traceback
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROVIDERS = ("eager", "compiled", "triton")
TRACE_NAMES = {
    "fx_graph_runnable.py", "fx_graph_readable.py", "fx_graph_transformed.py",
    "ir_pre_fusion.txt", "ir_post_fusion.txt", "output_code.py",
}
DEBUG_ENV = {
    "TORCH_LOGS", "TORCH_COMPILE_DEBUG", "TORCH_COMPILE_DEBUG_DIR",
    "TORCH_TRACE", "TORCHDYNAMO_VERBOSE", "TORCHINDUCTOR_TRACE",
    "TORCHINDUCTOR_DEBUG", "TORCHINDUCTOR_VERBOSE",
}


def write_json(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + "\n", encoding="utf-8")


def positive_int(raw):
    value = int(raw)
    if value < 1:
        raise argparse.ArgumentTypeError("must be positive")
    return value


def token_list(raw):
    try:
        values = [positive_int(item.strip()) for item in raw.split(",")]
    except (ValueError, argparse.ArgumentTypeError) as exc:
        raise argparse.ArgumentTypeError("expected positive comma-separated tokens") from exc
    if len(values) != len(set(values)):
        raise argparse.ArgumentTypeError("duplicate token counts are not allowed")
    return values


def rotation(index):
    offset = index % len(PROVIDERS)
    return PROVIDERS[offset:] + PROVIDERS[:offset]


def worker_env(phase, output, inherited=None):
    env = dict(os.environ if inherited is None else inherited)
    for name in DEBUG_ENV:
        env.pop(name, None)
    # Fresh caches avoid silently reusing an earlier run's code/debug artifacts.
    env.update({
        "OMP_NUM_THREADS": "1", "PYTHONUNBUFFERED": "1",
        "TORCHINDUCTOR_CACHE_DIR": str(output / phase / "inductor_cache"),
        "TRITON_CACHE_DIR": str(output / phase / "triton_cache"),
        "TORCHINDUCTOR_FX_GRAPH_CACHE": "0",
        "PYTHONPATH": str(ROOT / "src") + (os.pathsep + env["PYTHONPATH"]
                                             if env.get("PYTHONPATH") else ""),
    })
    if phase == "trace":
        env["TORCH_LOGS"] = "graph_code,aot_graphs,output_code,graph_breaks,recompiles"
        env["TORCH_COMPILE_DEBUG"] = "1"
    return env


def source_info():
    def git(*args):
        try:
            result = subprocess.run(["git", *args], cwd=ROOT, capture_output=True,
                                    text=True, check=True, timeout=10)
            return result.stdout.strip()
        except (OSError, subprocess.SubprocessError):
            return None
    paths = ("src/swiglu_triton/ops.py", "benchmarks/trace_compile_swiglu.py")
    return {"git_commit": git("rev-parse", "HEAD"),
            "git_status": git("status", "--porcelain"),
            "sha256": {name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest()
                       for name in paths}}


def gpu_environment(device):
    import torch
    import triton

    if not torch.cuda.is_available():
        raise RuntimeError("CUDA is unavailable; no GPU trace or timing was performed")
    if device >= torch.cuda.device_count():
        raise ValueError(f"CUDA device {device} is unavailable")
    torch.cuda.set_device(device)
    props = torch.cuda.get_device_properties(device)
    return {"python": platform.python_version(), "torch": torch.__version__,
            "triton": triton.__version__, "cuda": torch.version.cuda,
            "device": device, "gpu": props.name,
            "compute_capability": [props.major, props.minor],
            "total_memory_bytes": props.total_memory}


def accuracy(actual, reference):
    import torch

    finite = bool((torch.isfinite(actual) & torch.isfinite(reference)).all().item())
    error = (actual.float() - reference.float()).abs()
    return {
        "all_finite": finite, "count": reference.numel(),
        "strict_mismatch_count": int((~torch.isclose(
            actual.float(), reference.float(), rtol=1e-2, atol=1e-2)).sum().item()),
        "unequal_count": int((actual != reference).sum().item()),
        "bitwise_mismatch_count": int((actual.view(torch.int16) !=
                                       reference.view(torch.int16)).sum().item()),
        "max_abs_error": error.max().item() if finite else None,
        "mean_abs_error": error.mean().item() if finite else None,
    }


def make_inputs(torch, tokens, features, generator):
    shape = (tokens, features)
    return tuple(torch.randn(shape, dtype=torch.float16, device="cuda",
                             generator=generator) for _ in range(2))


def export_handwritten(gate, up, directory):
    """Expose the current FP16 kernel's own compiler stages, outside timing."""
    import torch
    import triton
    from swiglu_triton.ops import _swiglu_fp16_kernel

    output = torch.empty_like(gate)
    block = 1024  # Same launch configuration as the current ops.py wrapper.
    compiled = _swiglu_fp16_kernel[(triton.cdiv(gate.numel(), block),)](
        gate, up, output, gate.numel(), block, enable_fp_fusion=False)
    torch.cuda.synchronize()
    directory.mkdir(parents=True, exist_ok=True)
    exported = []
    for name in ("ttir", "ttgir", "llir", "ptx", "cubin"):
        data = compiled.asm.get(name)
        if isinstance(data, str):
            (directory / ("kernel." + name)).write_text(data, encoding="utf-8")
        elif isinstance(data, bytes):
            (directory / ("kernel." + name)).write_bytes(data)
        else:
            continue
        exported.append(name)
    metadata = {"block": block, "grid": [triton.cdiv(gate.numel(), block)],
                "enable_fp_fusion": False, "exported_stages": exported,
                "missing_stages": sorted(set(("ttir", "ttgir", "llir", "ptx", "cubin"))
                                         - set(exported))}
    for key in ("num_warps", "num_ctas", "shared"):
        value = getattr(compiled.metadata, key, None)
        if isinstance(value, (int, float, str, bool)):
            metadata[key] = value
    write_json(directory / "launch.json", metadata)
    return metadata


def measure_block(torch, fn, calls):
    # Events measure a device-stream interval, which can include submission gaps.
    # Wall timing includes host calls, allocations, and final synchronization.
    start_event, end_event = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
    # CUDA events initialize lazily; keep their first-use cost outside timing.
    start_event.record()
    end_event.record()
    torch.cuda.synchronize()
    start = time.perf_counter()
    start_event.record()
    for _ in range(calls):
        output = fn()
    end_event.record()
    submitted = time.perf_counter()
    torch.cuda.synchronize()
    finished = time.perf_counter()
    del output
    return {"wall_ms_per_call": (finished - start) * 1000 / calls,
            "submit_ms_per_call": (submitted - start) * 1000 / calls,
            "event_interval_ms_per_call": start_event.elapsed_time(end_event) / calls}


def run_gpu_worker(args, phase):
    import torch
    from swiglu_triton import swiglu_torch, swiglu_triton
    import torch._inductor.config as config

    environment = gpu_environment(args.device)
    directory = args.output_dir / phase
    directory.mkdir(parents=True, exist_ok=True)
    config.trace.enabled = phase == "trace"
    if phase == "trace":
        config.trace.debug_dir = str(directory / "inductor_debug")
    torch._dynamo.config.suppress_errors = False
    compiled = torch.compile(swiglu_torch, backend="inductor", fullgraph=True,
                             dynamic=False, options={"triton.cudagraphs": False})
    generator = torch.Generator(device="cuda").manual_seed(args.seed)
    rows = []
    with torch.inference_mode():
        for tokens in args.tokens:
            if phase == "trace":
                config.trace.debug_dir = str(directory / "inductor_debug" /
                                             f"t{tokens}_f{args.features}")
            gate, up = make_inputs(torch, tokens, args.features, generator)
            functions = {"eager": lambda: swiglu_torch(gate, up),
                         "compiled": lambda: compiled(gate, up),
                         "triton": lambda: swiglu_triton(gate, up)}
            reference = functions["eager"]()
            diagnostics = {name: accuracy(functions[name](), reference)
                           for name in ("compiled", "triton")}
            if not all(item["all_finite"] for item in diagnostics.values()):
                write_json(directory / "nonfinite.json", diagnostics)
                raise RuntimeError("nonfinite outputs; timing is not allowed")
            passed = all(item["strict_mismatch_count"] == 0 for item in diagnostics.values())
            row = {"shape": list(gate.shape), "accuracy": diagnostics,
                   "accuracy_status": "strict_tolerance_passed" if passed
                                      else "exploratory_strict_tolerance_failed"}
            if phase == "trace":
                row["inductor_debug_dir"] = Path(config.trace.debug_dir).relative_to(
                    args.output_dir).as_posix()
                row["handwritten_compilation"] = export_handwritten(
                    gate, up, directory / f"handwritten_t{tokens}_f{args.features}")
            else:
                for fn in functions.values():
                    for _ in range(args.warmups):
                        fn()
                torch.cuda.synchronize()
                samples = {name: [] for name in PROVIDERS}
                orders = []
                for index in range(args.repeats):
                    order = rotation(index)
                    orders.append(list(order))
                    for name in order:
                        samples[name].append(measure_block(torch, functions[name], args.calls))
                row.update({"orders": orders, "samples": samples,
                            "median_wall_ms": {name: statistics.median(
                                sample["wall_ms_per_call"] for sample in values)
                                for name, values in samples.items()}})
            rows.append(row)
    result = {
        "status": "completed", "phase": phase, "environment": environment,
        "scope": "FP16 contiguous post-projection SwiGLU; no model or generation",
        "compiler": {"backend": "inductor", "fullgraph": True, "dynamic": False,
                     "triton.cudagraphs": False},
        "seed": args.seed, "rtol": 0.01, "atol": 0.01, "rows": rows,
        "method": ("diagnostics only; no performance claim" if phase == "trace" else
                   "fresh process; debug logging disabled; compile/first use/validation/"
                   "warmup excluded; output allocation included for all providers; "
                   "balanced rotating order; synchronized block wall timing"),
    }
    if phase == "benchmark":
        result.update({"warmups": args.warmups, "repeats": args.repeats,
                       "calls_per_block": args.calls,
                       "notes": ["event interval is not pure kernel compute time",
                                 "block averages are not single-request latency",
                                 "strict tolerance success is not bitwise equality",
                                 "failed strict checks remain exploratory, not validated wins"]})
    write_json(directory / "result.json", result)


def artifact_inventory(output):
    files = []
    for path in sorted((output / "trace").rglob("*")):
        if path.is_file() and (path.name in TRACE_NAMES or "handwritten_t" in str(path)):
            files.append({"path": path.relative_to(output).as_posix(),
                          "bytes": path.stat().st_size,
                          "sha256": hashlib.sha256(path.read_bytes()).hexdigest()})
    return files


def summarize(output, runs):
    artifacts = artifact_inventory(output)
    names = {Path(item["path"]).name for item in artifacts}
    required = {"fx_graph_readable.py", "ir_pre_fusion.txt", "ir_post_fusion.txt", "output_code.py"}
    missing = sorted(required - names) if "trace" in runs else []
    missing_results = []
    exploratory = False
    for phase, code in runs.items():
        if code:
            continue
        result_path = output / ("preflight.json" if phase == "preflight" else phase + "/result.json")
        if not result_path.exists():
            missing_results.append(result_path.relative_to(output).as_posix())
            continue
        data = json.loads(result_path.read_text(encoding="utf-8"))
        for row in data.get("rows", []):
            exploratory |= row.get("accuracy_status") == "exploratory_strict_tolerance_failed"
            if phase == "trace":
                debug_dir = row.get("inductor_debug_dir")
                if debug_dir:
                    found = {p.name for p in (output / debug_dir).rglob("*") if p.is_file()}
                    missing.extend((Path(debug_dir) / name).as_posix()
                                   for name in sorted(required - found))
                missing.extend("handwritten: " + name for name in
                               row.get("handwritten_compilation", {}).get("missing_stages", []))
    status = ("worker_failed" if any(code != 0 for code in runs.values()) else
              "incomplete_result_files" if missing_results else
              "incomplete_compiler_artifacts" if missing else
              "exploratory_strict_tolerance_failed" if exploratory else "completed")
    return {"status": status, "worker_exit_codes": runs,
            "missing_result_files": missing_results,
            "missing_compiler_artifact_names": missing, "artifacts": artifacts}


def write_report(output, summary):
    lines = ["# SwiGLU 编译追踪运行记录", "", f"状态：`{summary['status']}`。", "",
             "以 summary.json、各阶段 result.json 和原始日志为准。", "",
             "## 编译产物", "", "以下仅确认文件存在，不自动证明融合次数或具体数值变换。", ""]
    lines.extend(f"- `{item['path']}`" for item in summary["artifacts"])
    if summary["missing_compiler_artifact_names"]:
        lines.extend(["", "缺失：" + ", ".join(summary["missing_compiler_artifact_names"])])
    if summary["missing_result_files"]:
        lines.extend(["", "阶段结果缺失：" + ", ".join(summary["missing_result_files"])])
    path = output / "benchmark/result.json"
    if path.exists():
        data = json.loads(path.read_text(encoding="utf-8"))
        lines.extend(["", "## 独立计时", "", "单位 ms；每块多次调用均值的中位数。",
                      "", "| shape | eager | compiled | Triton | 精度状态 |",
                      "|---|---:|---:|---:|---|"])
        for row in data["rows"]:
            m = row["median_wall_ms"]
            lines.append(f"| {row['shape']} | {m['eager']:.6f} | {m['compiled']:.6f} | "
                         f"{m['triton']:.6f} | {row['accuracy_status']} |")
    lines.extend(["", "## 待人工核对", "",
                  "1. 在 FX/ATen 图中找到 SiLU 和乘法，核对 shape/dtype。",
                  "2. 对照 ir_pre_fusion、ir_post_fusion 与 output_code 确认实际融合。",
                  "3. 核对生成 kernel 内的 dtype 转换与 FP16 中间舍入。",
                  "4. 结合实际 launch 调用分析 kernel 数；不要只数函数定义。",
                  "5. fullgraph=True 只约束图捕获，不表示只有一个 kernel 或使用 CUDA Graph。",
                  "6. 本次没有模型生成测试，也没有实现新的编译器 Pass。", ""])
    (output / "REPORT.md").write_text("\n".join(lines), encoding="utf-8")


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, required=True,
                        help="new directory; existing directories are never overwritten")
    parser.add_argument("--tokens", type=token_list, default=[1, 128, 1024])
    parser.add_argument("--features", type=positive_int, default=5632)
    parser.add_argument("--repeats", type=positive_int, default=6)
    parser.add_argument("--calls", type=positive_int, default=100)
    parser.add_argument("--warmups", type=positive_int, default=25)
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--device", type=int, default=0)
    parser.add_argument("--only", choices=("all", "trace", "benchmark"), default="all")
    parser.add_argument("--_worker", choices=("preflight", "trace", "benchmark"),
                        help=argparse.SUPPRESS)
    args = parser.parse_args(argv)
    if args.repeats % len(PROVIDERS):
        parser.error("--repeats must be a multiple of 3 for balanced provider order")
    if args.device < 0:
        parser.error("--device must be nonnegative")
    args.output_dir = args.output_dir.resolve()
    if args._worker:
        try:
            if args._worker == "preflight":
                write_json(args.output_dir / "preflight.json",
                           {"status": "passed", "environment": gpu_environment(args.device)})
            else:
                run_gpu_worker(args, args._worker)
            return 0
        except Exception as error:
            write_json(args.output_dir / (args._worker + "_failure.json"),
                       {"status": "failed", "error_type": type(error).__name__,
                        "error": str(error), "traceback": traceback.format_exc()})
            traceback.print_exc()
            return 2
    try:
        args.output_dir.mkdir(parents=True, exist_ok=False)
    except FileExistsError:
        parser.error("output directory exists; choose a new path to preserve evidence")
    metadata = {"created_utc": datetime.now(timezone.utc).isoformat(),
                "source": source_info(), "launcher_python": sys.executable,
                "arguments": {k: str(v) if isinstance(v, Path) else v
                              for k, v in vars(args).items()}}
    write_json(args.output_dir / "run.json", metadata)
    common = [sys.executable, str(Path(__file__).resolve()), "--output-dir", str(args.output_dir),
              "--tokens", ",".join(map(str, args.tokens)), "--features", str(args.features),
              "--repeats", str(args.repeats), "--calls", str(args.calls),
              "--warmups", str(args.warmups), "--seed", str(args.seed), "--device", str(args.device)]
    phases = ["preflight"] + (["trace", "benchmark"] if args.only == "all" else [args.only])
    runs = {}
    for phase in phases:
        print(f"Running {phase}; log: {args.output_dir / (phase + '.log')}", flush=True)
        with (args.output_dir / (phase + ".log")).open("w", encoding="utf-8") as log:
            result = subprocess.run(common + ["--_worker", phase], cwd=ROOT,
                                    env=worker_env(phase, args.output_dir),
                                    stdout=log, stderr=subprocess.STDOUT)
        runs[phase] = result.returncode
        if result.returncode != 0:
            break
    summary = summarize(args.output_dir, runs)
    write_json(args.output_dir / "summary.json", summary)
    write_report(args.output_dir, summary)
    print(f"Status: {summary['status']}; report: {args.output_dir / 'REPORT.md'}")
    return 0 if summary["status"] == "completed" else 2


if __name__ == "__main__":
    raise SystemExit(main())
