"""Capture CUDA kernel launch tables and traces for the two operator paths."""

import argparse
import platform
from pathlib import Path

import torch
import triton
from torch.profiler import ProfilerActivity, profile

from swiglu_triton import swiglu_torch, swiglu_triton

from bench_swiglu import positive_ints


def main() -> None:
    parser = argparse.ArgumentParser(description="SwiGLU CUDA kernel trace")
    parser.add_argument("--tokens", type=positive_ints, default=[1, 1024])
    parser.add_argument("--features", type=int, default=11008)
    parser.add_argument("--iterations", type=int, default=5)
    parser.add_argument("--output-dir", type=Path, default=Path("results/t4_profile_swiglu"))
    args = parser.parse_args()
    if min(args.features, args.iterations) <= 0:
        parser.error("features and iterations must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required")

    args.output_dir.mkdir(parents=True, exist_ok=True)
    torch.manual_seed(42)
    lines = [f"GPU: {torch.cuda.get_device_name(0)}; Python: {platform.python_version()}; "
             f"Torch: {torch.__version__}; CUDA: {torch.version.cuda}; "
             f"Triton: {triton.__version__}; profiled iterations: {args.iterations}",
             "Profiler runs are diagnostic; use bench_swiglu.py for latency."]
    with torch.inference_mode():
        for tokens in args.tokens:
            gate = torch.randn((tokens, args.features), device="cuda", dtype=torch.float16)
            up = torch.randn_like(gate)
            for name, fn in (("eager", lambda: swiglu_torch(gate, up)),
                             ("triton", lambda: swiglu_triton(gate, up))):
                for _ in range(5):
                    fn()
                torch.cuda.synchronize()
                with profile(activities=[ProfilerActivity.CPU, ProfilerActivity.CUDA]) as prof:
                    for _ in range(args.iterations):
                        fn()
                    torch.cuda.synchronize()
                trace = args.output_dir / f"{name}_t{tokens}_f{args.features}.json"
                prof.export_chrome_trace(str(trace))
                table = prof.key_averages().table(sort_by="self_cuda_time_total", row_limit=20)
                section = f"\n{name}, tokens={tokens}, features={args.features}\n{table}"
                lines.append(section)
                print(section, flush=True)
    report = args.output_dir / "kernel_tables.txt"
    report.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Saved {report} and per-provider Chrome traces")


if __name__ == "__main__":
    main()
