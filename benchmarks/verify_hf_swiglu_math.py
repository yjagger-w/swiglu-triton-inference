"""Exhaustive finite FP16 gate checks, then optional candidate layer diagnosis.

The production operator is unchanged. This script patches references only in
this process, after a candidate passes the stated operator checks.
"""

import argparse
import json
import sys
from pathlib import Path

import torch
import torch.nn.functional as F
import triton
import triton.language as tl
from triton.language.extra.cuda import libdevice

from swiglu_triton.ops import swiglu_triton


@triton.jit
def candidate_kernel(G, U, Y, N: tl.constexpr, MODE: tl.constexpr, BLOCK: tl.constexpr):
    offsets = tl.program_id(0) * BLOCK + tl.arange(0, BLOCK)
    gate = tl.load(G + offsets, offsets < N, other=0)
    up = tl.load(U + offsets, offsets < N, other=0).to(tl.float32)
    x = gate.to(tl.float32)
    denominator = 1.0 + libdevice.exp(-x)
    if MODE == 0:
        activation = tl.div_rn(x, denominator)
    else:
        activation = x * tl.div_rn(1.0, denominator)
    rounded = activation.to(gate.dtype).to(tl.float32)
    tl.store(Y + offsets, rounded * up, offsets < N)


def candidate(gate, up, mode):
    if (gate.dtype != torch.float16 or up.dtype != gate.dtype or
        gate.device.type != "cuda" or gate.device != up.device or
        gate.shape != up.shape or gate.numel() == 0 or
        not gate.is_contiguous() or not up.is_contiguous()):
        raise ValueError("candidate requires matching contiguous nonempty FP16 CUDA tensors")
    output = torch.empty_like(gate)
    candidate_kernel[(triton.cdiv(gate.numel(), 1024),)](
        gate, up, output, gate.numel(), mode, 1024, enable_fp_fusion=False)
    return output


def compare(actual, expected, gate, up):
    bad = actual.view(torch.int16) != expected.view(torch.int16)
    where = bad.nonzero().flatten()[:8]
    finite = torch.isfinite(actual) & torch.isfinite(expected)
    delta = (actual.float()[finite] - expected.float()[finite]).abs()
    return {
        "bitwise_mismatch_count": int(bad.sum().item()),
        "max_abs_error_finite_pairs": delta.max().item() if delta.numel() else None,
        "examples": [{"gate": gate[i].item(), "up": up[i].item(),
                      "expected_bits": int(expected.view(torch.int16)[i].item()),
                      "actual_bits": int(actual.view(torch.int16)[i].item())}
                     for i in where.tolist()],
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", default="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
    parser.add_argument("--revision", default="fe8a4ea1ffedaf415f4da2f062534de366a451e6")
    parser.add_argument("--prompt-tokens", type=int, default=128)
    parser.add_argument("--operator-only", action="store_true")
    parser.add_argument("--output-dir", type=Path, default=Path("results/t4_swiglu_math"))
    args = parser.parse_args()
    if not torch.cuda.is_available() or args.prompt_tokens <= 0:
        parser.error("CUDA GPU and positive prompt length required")
    args.output_dir.mkdir(parents=True, exist_ok=True)
    torch.manual_seed(42)
    with torch.inference_mode():
        codes = torch.arange(65536, dtype=torch.int32, device="cuda").to(torch.int16)
        all_values = codes.view(torch.float16)
        gate = all_values[torch.isfinite(all_values)].contiguous()
        if gate.numel() != 63488:
            raise AssertionError("finite FP16 enumeration count is wrong")
        variants = {"current": swiglu_triton,
                    "libdevice_div": lambda g, u: candidate(g, u, 0),
                    "libdevice_recip_mul": lambda g, u: candidate(g, u, 1)}
        cases = {"unit_up": torch.ones_like(gate)}
        for value in (-1.3330078125, -1.603515625, -0.67333984375,
                      -0.8798828125, -1.5517578125):
            cases[f"up_{value}"] = torch.full_like(gate, value)
        cases["permuted_finite_up"] = gate[torch.randperm(gate.numel(), device="cuda")]
        checks = {name: {} for name in variants}
        for case, up in cases.items():
            expected = F.silu(gate) * up
            for name, function in variants.items():
                checks[name][case] = compare(function(gate, up), expected, gate, up)
        qualified = [name for name in ("libdevice_div", "libdevice_recip_mul")
                     if all(row["bitwise_mismatch_count"] == 0 for row in checks[name].values())]
        result = {
            "method": "all 63,488 finite FP16 bit patterns as gates; six constant up"
                      " cases and one finite-value permutation; bitwise comparison including signed zero",
            "gpu": torch.cuda.get_device_name(0), "torch": torch.__version__,
            "triton": triton.__version__, "cuda": torch.version.cuda, "seed": 42,
            "gate_count": gate.numel(), "checks": checks,
            "qualified_candidates": qualified,
            "selected_candidate": qualified[0] if qualified else None,
            "limitations": "does not enumerate all gate/up pairs; excludes NaN/Inf inputs;"
                           " does not establish other dtype, device or version behavior; no timing",
        }
    sweep_path = args.output_dir / "fp16_operator_checks.json"
    sweep_path.write_text(json.dumps(result, indent=2, allow_nan=False) + "\n", encoding="utf-8")
    print("Bitwise mismatch counts:")
    for name, rows in checks.items():
        print(name, {case: row["bitwise_mismatch_count"] for case, row in rows.items()})
    print(f"Saved {sweep_path}")
    if not qualified:
        raise SystemExit("No candidate passed every operator check; model diagnosis skipped.")
    if args.operator_only:
        return

    import diagnose_hf_swiglu_accuracy as diagnosis
    import swiglu_triton.hf_llama as adapter
    selected = qualified[0]
    original_diag, original_adapter, original_argv = (
        diagnosis.swiglu_triton, adapter.swiglu_triton, sys.argv)
    output = args.output_dir / f"{selected}_layer_accuracy.json"
    try:
        diagnosis.swiglu_triton = variants[selected]
        adapter.swiglu_triton = variants[selected]
        sys.argv = ["diagnose_hf_swiglu_accuracy.py", "--model", args.model,
                    "--revision", args.revision, "--prompt-tokens", str(args.prompt_tokens),
                    "--output", str(output)]
        print(f"Running layer diagnosis with candidate: {selected}")
        diagnosis.main()
    finally:
        diagnosis.swiglu_triton, adapter.swiglu_triton, sys.argv = (
            original_diag, original_adapter, original_argv)


if __name__ == "__main__":
    main()
