"""Compare eager, torch.compile/Inductor and hand-written Triton on CUDA."""

import argparse
import json
import platform
from datetime import datetime, timezone
from pathlib import Path

import torch
import triton

from swiglu_triton import swiglu_torch, swiglu_triton

from bench_swiglu import bench, positive_ints


def main() -> None:
    parser = argparse.ArgumentParser(description="Compiled PyTorch SwiGLU comparison")
    parser.add_argument("--tokens", type=positive_ints, default=[1, 128, 1024])
    parser.add_argument("--features", type=int, default=11008)
    parser.add_argument("--repeats", type=int, default=3)
    parser.add_argument("--output", type=Path, default=Path("results/t4_compiled_swiglu_fp16.json"))
    args = parser.parse_args()
    if min(args.features, args.repeats) <= 0:
        parser.error("features and repeats must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required")

    torch.manual_seed(42)
    compiled = torch.compile(swiglu_torch, backend="inductor", fullgraph=True)
    rows = []
    with torch.inference_mode():
        for tokens in args.tokens:
            gate = torch.randn((tokens, args.features), device="cuda", dtype=torch.float16)
            up = torch.randn_like(gate)
            eager = lambda: swiglu_torch(gate, up)
            triton_fn = lambda: swiglu_triton(gate, up)
            compiled_fn = lambda: compiled(gate, up)

            # The first call is allowed to compile; none of its time enters do_bench.
            reference = eager()
            candidates = {"triton": triton_fn(), "compiled": compiled_fn()}
            row = {"tokens": tokens, "features": args.features, "dtype": "fp16"}
            for name, actual in candidates.items():
                # Inductor may fuse operations and change FP16 intermediate rounding.
                torch.testing.assert_close(actual, reference, rtol=1e-2, atol=1e-2)
                row[f"{name}_max_abs_error"] = (actual.float() - reference.float()).abs().max().item()
            for name, fn in (("eager", eager), ("triton", triton_fn), ("compiled", compiled_fn)):
                row[f"{name}_ms"] = bench(fn, args.repeats)
            row["triton_over_eager"] = row["eager_ms"] / row["triton_ms"]
            row["compiled_over_eager"] = row["eager_ms"] / row["compiled_ms"]
            row["triton_over_compiled"] = row["compiled_ms"] / row["triton_ms"]
            rows.append(row)
            print(row, flush=True)

    result = {
        "method": "forward-only post-projection; output allocation included; compile and first call excluded; median of do_bench medians",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "gpu": torch.cuda.get_device_name(0),
        "compute_capability": list(torch.cuda.get_device_capability(0)),
        "python": platform.python_version(), "torch": torch.__version__,
        "cuda": torch.version.cuda, "triton": triton.__version__,
        "compile_backend": "inductor", "fullgraph": True,
        "rtol": 1e-2, "atol": 1e-2, "seed": 42,
        "repeats": args.repeats, "rows": rows,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
