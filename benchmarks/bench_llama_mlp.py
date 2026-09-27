"""Synthetic decode/prefill MLP benchmark; no model checkpoint required."""

import argparse
import csv
import json
import platform
from datetime import datetime, timezone
from pathlib import Path

import torch
import triton

from swiglu_triton.llama_mlp import LlamaStyleMLP

from bench_swiglu import bench, positive_ints


def main() -> None:
    parser = argparse.ArgumentParser(description="One LLaMA-style MLP layer on CUDA")
    parser.add_argument("--tokens", type=positive_ints, default=[1, 8, 128, 1024])
    parser.add_argument("--hidden", type=int, default=4096)
    parser.add_argument("--intermediate", type=int, default=11008)
    parser.add_argument("--dtype", choices=["fp16", "bf16", "fp32"], default="fp16")
    parser.add_argument("--repeats", type=int, default=3)
    parser.add_argument("--output", type=Path, default=Path("results/llama_mlp.json"))
    args = parser.parse_args()
    if min(args.hidden, args.intermediate, args.repeats) <= 0:
        parser.error("dimensions and repeats must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required; no benchmark result was produced")
    dtype = {"fp16": torch.float16, "bf16": torch.bfloat16, "fp32": torch.float32}[args.dtype]
    if dtype == torch.bfloat16 and not torch.cuda.is_bf16_supported():
        parser.error("this GPU does not support bfloat16")

    torch.manual_seed(42)
    model = LlamaStyleMLP(args.hidden, args.intermediate).to(device="cuda", dtype=dtype).eval()
    rows = []
    with torch.inference_mode():
        for tokens in args.tokens:
            x = torch.randn((tokens, args.hidden), device="cuda", dtype=dtype)
            eager = lambda: model(x, provider="eager")
            fused = lambda: model(x, provider="triton")
            expected, actual = eager(), fused()
            rtol, atol = {"fp16": (5e-3, 5e-3), "bf16": (3e-2, 3e-2),
                          "fp32": (5e-5, 5e-5)}[args.dtype]
            torch.testing.assert_close(actual, expected, rtol=rtol, atol=atol)
            error = (actual.float() - expected.float()).abs().max().item()
            eager_ms = bench(eager, args.repeats)
            fused_ms = bench(fused, args.repeats)
            row = {
                "tokens": tokens, "hidden": args.hidden,
                "intermediate": args.intermediate, "dtype": args.dtype,
                "eager_ms": eager_ms, "triton_ms": fused_ms,
                "speedup": eager_ms / fused_ms, "max_abs_error": error,
            }
            rows.append(row)
            print(row)

    result = {
        "method": "one random-weight MLP layer; gate/up/down projections included; no attention or generation",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "gpu": torch.cuda.get_device_name(0),
        "compute_capability": list(torch.cuda.get_device_capability(0)),
        "python": platform.python_version(), "torch": torch.__version__,
        "cuda": torch.version.cuda, "triton": triton.__version__,
        "seed": 42, "repeats": args.repeats, "rows": rows,
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
