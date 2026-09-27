"""GPU microbenchmark; run after installing the project on a CUDA machine."""

import argparse
import csv
import json
import platform
import statistics
from datetime import datetime, timezone
from pathlib import Path

import torch
import triton
import triton.testing

from swiglu_triton import swiglu_torch, swiglu_triton


def positive_ints(raw: str) -> list[int]:
    values = [int(item.strip()) for item in raw.split(",")]
    if not values or any(value <= 0 for value in values):
        raise argparse.ArgumentTypeError("expected comma-separated positive integers")
    return values


def bench(fn, repeats: int) -> float:
    return statistics.median(
        triton.testing.do_bench(fn, warmup=50, rep=200, return_mode="median")
        for _ in range(repeats)
    )


def main() -> None:
    parser = argparse.ArgumentParser(description="SwiGLU post-projection GPU benchmark")
    parser.add_argument("--tokens", type=positive_ints, default=[1, 128, 1024])
    parser.add_argument("--features", type=positive_ints, default=[4096, 11008])
    parser.add_argument("--dtype", choices=["fp16", "bf16", "fp32"], default="fp16")
    parser.add_argument("--repeats", type=int, default=3)
    parser.add_argument("--output", type=Path, default=Path("results/benchmark.json"))
    args = parser.parse_args()
    if args.repeats < 1:
        parser.error("--repeats must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required; no benchmark result was produced")
    dtype = {"fp16": torch.float16, "bf16": torch.bfloat16, "fp32": torch.float32}[args.dtype]
    if dtype == torch.bfloat16 and torch.cuda.get_device_capability(0)[0] < 8:
        parser.error("BF16 Triton kernel requires compute capability 8.0 or newer")

    torch.manual_seed(42)
    rows = []
    for tokens in args.tokens:
        for features in args.features:
            shape = (tokens, features)
            gate = torch.randn(shape, device="cuda", dtype=dtype)
            up = torch.randn(shape, device="cuda", dtype=dtype)
            expected = swiglu_torch(gate, up)
            actual = swiglu_triton(gate, up)
            tolerances = {"fp16": (3e-3, 3e-3), "bf16": (2e-2, 2e-2), "fp32": (3e-5, 3e-5)}
            rtol, atol = tolerances[args.dtype]
            torch.testing.assert_close(actual, expected, rtol=rtol, atol=atol)
            error = (actual.float() - expected.float()).abs()
            # Each call allocates its output; eager also materializes the SiLU result.
            eager_ms = bench(lambda: swiglu_torch(gate, up), args.repeats)
            fused_ms = bench(lambda: swiglu_triton(gate, up), args.repeats)
            rows.append({
                "tokens": tokens, "features": features, "dtype": args.dtype,
                "eager_ms": eager_ms, "triton_ms": fused_ms,
                "speedup": eager_ms / fused_ms,
                "max_abs_error": error.max().item(),
            })
            print(rows[-1])

    result = {
        "method": "forward-only post-projection; output allocation included; median of do_bench medians",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "gpu": torch.cuda.get_device_name(0),
        "compute_capability": list(torch.cuda.get_device_capability(0)),
        "python": platform.python_version(),
        "torch": torch.__version__, "cuda": torch.version.cuda,
        "triton": triton.__version__, "seed": 42,
        "repeats": args.repeats, "rows": rows,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    with args.output.with_suffix(".csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    print(f"Saved {args.output} and {args.output.with_suffix('.csv')}")


if __name__ == "__main__":
    main()
