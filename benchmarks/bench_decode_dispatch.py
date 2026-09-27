"""Measure host submission and synchronized time for actual decode SwiGLU shape."""

import argparse
import json
import statistics
import time
from pathlib import Path

import torch

from swiglu_triton.ops import swiglu_torch, swiglu_triton


def main() -> None:
    parser = argparse.ArgumentParser(description="SwiGLU dispatch cost on a CUDA GPU")
    parser.add_argument("--features", type=int, default=5632)
    parser.add_argument("--calls", type=int, default=352)
    parser.add_argument("--repeats", type=int, default=5)
    parser.add_argument("--output", type=Path, default=Path("results/t4_decode_dispatch_fp16.json"))
    args = parser.parse_args()
    if min(args.features, args.calls, args.repeats) <= 0:
        parser.error("features, calls, and repeats must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required")

    torch.manual_seed(42)
    gate = torch.randn((1, args.features), device="cuda", dtype=torch.float16)
    up = torch.randn_like(gate)
    torch.testing.assert_close(swiglu_torch(gate, up), swiglu_triton(gate, up),
                               rtol=1e-2, atol=1e-2)
    providers = {
        "eager": lambda: swiglu_torch(gate, up),
        "triton": lambda: swiglu_triton(gate, up),
    }
    with torch.inference_mode():
        for fn in providers.values():
            for _ in range(32):
                fn()
        torch.cuda.synchronize()

        measurements = {name: [] for name in providers}
        for i in range(args.repeats):
            names = ("eager", "triton") if i % 2 == 0 else ("triton", "eager")
            for name in names:
                fn = providers[name]
                torch.cuda.synchronize()
                start = time.perf_counter()
                for _ in range(args.calls):
                    fn()
                submitted = time.perf_counter()
                torch.cuda.synchronize()
                finished = time.perf_counter()
                measurements[name].append({
                    "submit_ms": (submitted - start) * 1000,
                    "total_ms": (finished - start) * 1000,
                })

    result = {
        "method": "contiguous FP16 post-projection operator, output allocation included;"
                  " 352 sequential decode-shape calls by default; paired alternating order;"
                  " CPU submission timer and synchronized wall timer, no profiler",
        "shape": list(gate.shape), "calls": args.calls, "repeats": args.repeats,
        "gpu": torch.cuda.get_device_name(0), "torch": torch.__version__,
        "measurements": measurements,
        "median_submit_ms": {name: statistics.median(row["submit_ms"] for row in values)
                             for name, values in measurements.items()},
        "median_total_ms": {name: statistics.median(row["total_ms"] for row in values)
                            for name, values in measurements.items()},
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
