"""Isolated MLP stage timing on CUDA; stage times are not additive."""

import argparse
import json
import platform
from datetime import datetime, timezone
from pathlib import Path

import torch
import triton

from swiglu_triton import swiglu_torch, swiglu_triton
from swiglu_triton.llama_mlp import LlamaStyleMLP

from bench_swiglu import bench, positive_ints


def main() -> None:
    parser = argparse.ArgumentParser(description="Isolated LLaMA-style MLP stage benchmark")
    parser.add_argument("--tokens", type=positive_ints, default=[1, 128, 1024])
    parser.add_argument("--hidden", type=int, default=4096)
    parser.add_argument("--intermediate", type=int, default=11008)
    parser.add_argument("--repeats", type=int, default=3)
    parser.add_argument("--output", type=Path, default=Path("results/t4_mlp_stages_fp16.json"))
    args = parser.parse_args()
    if min(args.hidden, args.intermediate, args.repeats) <= 0:
        parser.error("dimensions and repeats must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required")

    torch.manual_seed(42)
    model = LlamaStyleMLP(args.hidden, args.intermediate).to(device="cuda", dtype=torch.float16).eval()
    rows = []
    with torch.inference_mode():
        for tokens in args.tokens:
            x = torch.randn((tokens, args.hidden), device="cuda", dtype=torch.float16)
            gate = model.gate_proj(x)
            up = model.up_proj(x)
            hidden = swiglu_torch(gate, up)
            actual = model(x, provider="triton")
            expected = model(x, provider="eager")
            torch.testing.assert_close(actual, expected, rtol=5e-3, atol=5e-3)

            row = {"tokens": tokens, "hidden": args.hidden,
                   "intermediate": args.intermediate, "dtype": "fp16"}
            for name, fn in (
                ("gate_proj", lambda: model.gate_proj(x)),
                ("up_proj", lambda: model.up_proj(x)),
                ("swiglu_eager", lambda: swiglu_torch(gate, up)),
                ("swiglu_triton", lambda: swiglu_triton(gate, up)),
                ("down_proj", lambda: model.down_proj(hidden)),
                ("full_eager", lambda: model(x, provider="eager")),
                ("full_triton", lambda: model(x, provider="triton")),
            ):
                row[f"{name}_ms"] = bench(fn, args.repeats)
            rows.append(row)
            print(row, flush=True)

    result = {
        "method": "isolated stage do_bench medians; stage times are not additive and may differ from full-layer timings",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "gpu": torch.cuda.get_device_name(0),
        "compute_capability": list(torch.cuda.get_device_capability(0)),
        "python": platform.python_version(), "torch": torch.__version__,
        "cuda": torch.version.cuda, "triton": triton.__version__,
        "seed": 42, "repeats": args.repeats, "rows": rows,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
