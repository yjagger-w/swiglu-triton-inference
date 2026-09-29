"""Native, reordered eager, Triton and optional compiled SwiGLU MLP control."""

import argparse
import hashlib
import json
import math
import statistics
import time
from contextlib import contextmanager, nullcontext
from datetime import datetime, timezone
from pathlib import Path
from types import MethodType

import torch
import torch.nn.functional as F

from swiglu_triton.hf_llama import use_triton_llama_mlps
from swiglu_triton.ops import swiglu_torch


def reordered_eager_forward(mlp: torch.nn.Module, x: torch.Tensor) -> torch.Tensor:
    gate = mlp.gate_proj(x)
    up = mlp.up_proj(x)
    return mlp.down_proj(F.silu(gate) * up)


def full_mlp_reference(x, gate_weight, gate_bias, up_weight, up_bias,
                       down_weight, down_bias):
    """One weight-parameterized graph shared by same-shape MLP layers."""
    gate = F.silu(F.linear(x, gate_weight, gate_bias))
    up = F.linear(x, up_weight, up_bias)
    return F.linear(gate * up, down_weight, down_bias)


@contextmanager
def provider(model: torch.nn.Module, name: str, compiled_activation=None,
             compiled_mlp=None):
    if name == "native":
        yield
    elif name == "triton":
        with use_triton_llama_mlps(model):
            yield
    elif name in ("reordered_eager", "compiled", "compiled_mlp"):
        if name == "compiled" and compiled_activation is None:
            raise ValueError("compiled activation is required")
        if name == "compiled_mlp" and compiled_mlp is None:
            raise ValueError("compiled MLP is required")

        def compiled_forward(mlp: torch.nn.Module, x: torch.Tensor) -> torch.Tensor:
            gate = mlp.gate_proj(x)
            up = mlp.up_proj(x)
            return mlp.down_proj(compiled_activation(gate, up))

        def full_compiled_forward(mlp: torch.nn.Module, x: torch.Tensor) -> torch.Tensor:
            return compiled_mlp(
                x, mlp.gate_proj.weight, mlp.gate_proj.bias,
                mlp.up_proj.weight, mlp.up_proj.bias,
                mlp.down_proj.weight, mlp.down_proj.bias,
            )

        mlps = [layer.mlp for layer in model.model.layers]
        originals = [mlp.forward for mlp in mlps]
        try:
            for mlp in mlps:
                forward = {"reordered_eager": reordered_eager_forward,
                           "compiled": compiled_forward,
                           "compiled_mlp": full_compiled_forward}[name]
                mlp.forward = MethodType(forward, mlp)
            yield
        finally:
            for mlp, original in zip(mlps, originals):
                mlp.forward = original
    else:
        raise ValueError(f"unknown provider: {name}")


@contextmanager
def measure_mlp_host_calls(model: torch.nn.Module):
    """Count unsynchronized host time spent invoking each MLP forward."""
    mlps = [layer.mlp for layer in model.model.layers]
    originals = [mlp.forward for mlp in mlps]
    stats = {"calls": 0, "host_ms": 0.0}

    def instrument(original):
        def timed(_mlp, x):
            start = time.perf_counter()
            out = original(x)
            stats["host_ms"] += (time.perf_counter() - start) * 1000
            stats["calls"] += 1
            return out
        return timed

    try:
        for mlp, original in zip(mlps, originals):
            mlp.forward = MethodType(instrument(original), mlp)
        yield stats
    finally:
        for mlp, original in zip(mlps, originals):
            mlp.forward = original


def main() -> None:
    parser = argparse.ArgumentParser(description="Full-model MLP schedule control")
    parser.add_argument("--model", default="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
    parser.add_argument("--revision", default="main")
    parser.add_argument("--prompt-tokens", type=int, default=128)
    parser.add_argument("--new-tokens", type=int, default=16)
    parser.add_argument("--repeats", type=int, default=5)
    parser.add_argument("--mlp-host-timing", action="store_true",
                        help="time and count MLP forwards without synchronizing inside them")
    parser.add_argument("--include-compiled", action="store_true",
                        help="add torch.compile/Inductor on post-projection SwiGLU only")
    parser.add_argument("--include-compiled-mlp", action="store_true",
                        help="add torch.compile/Inductor on the full weight-parameterized MLP")
    parser.add_argument("--output", type=Path, default=Path("results/t4_tinyllama_mlp_variants_fp16.json"))
    args = parser.parse_args()
    if min(args.prompt_tokens, args.new_tokens, args.repeats) <= 0:
        parser.error("token lengths and repeats must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required")

    from transformers import AutoModelForCausalLM, AutoTokenizer

    torch.manual_seed(42)
    tokenizer = AutoTokenizer.from_pretrained(args.model, revision=args.revision)
    model = AutoModelForCausalLM.from_pretrained(
        args.model, revision=args.revision, torch_dtype=torch.float16
    ).to("cuda").eval()
    if model.config.model_type != "llama" or model.config.hidden_act != "silu":
        parser.error("checkpoint must use a LLaMA SiLU MLP")
    phrase = "Explain why fused GPU operations can reduce memory traffic. "
    unit = tokenizer.encode(phrase, add_special_tokens=False)
    if not unit:
        parser.error("tokenizer returned an empty prompt")
    bos = [tokenizer.bos_token_id] if tokenizer.bos_token_id is not None else []
    ids = (bos + unit * math.ceil(args.prompt_tokens / len(unit)))[:args.prompt_tokens]
    input_ids = torch.tensor([ids], device="cuda", dtype=torch.long)
    attention_mask = torch.ones_like(input_ids)
    kwargs = dict(max_new_tokens=args.new_tokens, min_new_tokens=args.new_tokens,
                  do_sample=False, num_beams=1, use_cache=True,
                  pad_token_id=(tokenizer.pad_token_id if tokenizer.pad_token_id is not None
                                else tokenizer.eos_token_id))

    def generate() -> torch.Tensor:
        return model.generate(input_ids=input_ids, attention_mask=attention_mask, **kwargs)

    compiled_activation = (torch.compile(swiglu_torch, backend="inductor", fullgraph=True)
                           if args.include_compiled else None)
    compiled_mlp = (torch.compile(full_mlp_reference, backend="inductor", fullgraph=True)
                    if args.include_compiled_mlp else None)
    names = ("native", "reordered_eager", "triton")
    if args.include_compiled:
        names += ("compiled",)
    if args.include_compiled_mlp:
        names += ("compiled_mlp",)
    with torch.inference_mode():
        outputs = {}
        for name in names:
            with provider(model, name, compiled_activation, compiled_mlp):
                outputs[name] = generate()
        agree = {name: torch.equal(outputs["native"], outputs[name]) for name in names}
        if not all(agree.values()):
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(json.dumps({"status": "token_mismatch_no_timing",
                                               "greedy_ids_identical": agree}, indent=2) + "\n",
                                   encoding="utf-8")
            raise AssertionError(f"greedy token mismatch; diagnostic saved, no timing: {agree}")
        if outputs["native"].shape[-1] != args.prompt_tokens + args.new_tokens:
            raise AssertionError("generation did not produce requested number of tokens")

        compiled_logit_diagnostics = {}
        if args.include_compiled or args.include_compiled_mlp:
            original_logits = model(input_ids=input_ids, attention_mask=attention_mask,
                                    use_cache=False).logits
            for compiled_name in ("compiled", "compiled_mlp"):
                if compiled_name not in names:
                    continue
                with provider(model, compiled_name, compiled_activation, compiled_mlp):
                    actual_logits = model(input_ids=input_ids, attention_mask=attention_mask,
                                          use_cache=False).logits
                difference = (original_logits.float() - actual_logits.float()).abs()
                compiled_logit_diagnostics[compiled_name] = {
                    "strict_check_rtol_atol": 1e-2,
                    "strict_mismatch_count": int((~torch.isclose(
                        actual_logits, original_logits, rtol=1e-2, atol=1e-2)).sum().item()),
                    "logit_count": original_logits.numel(),
                    "max_abs_error": difference.max().item(),
                    "top1_mismatch_positions": int((actual_logits.argmax(dim=-1) !=
                                                    original_logits.argmax(dim=-1)).sum().item()),
                }

        def measure(name: str) -> tuple[float, dict | None]:
            with provider(model, name, compiled_activation, compiled_mlp):
                instrument = (measure_mlp_host_calls(model) if args.mlp_host_timing
                              else nullcontext(None))
                with instrument as stats:
                    torch.cuda.synchronize()
                    start = time.perf_counter()
                    generate()
                    torch.cuda.synchronize()
                    return (time.perf_counter() - start) * 1000, stats

        for _ in range(2):
            for name in names:
                measure(name)
        rotations = [names[-i:] + names[:-i] for i in range(len(names))]
        times = {name: [] for name in names}
        host_times = {name: [] for name in names}
        for i in range(args.repeats):
            for name in rotations[i % len(rotations)]:
                elapsed, stats = measure(name)
                times[name].append(elapsed)
                if stats is not None:
                    if stats["calls"] != len(model.model.layers) * args.new_tokens:
                        raise AssertionError(f"unexpected MLP call count: {stats['calls']}")
                    host_times[name].append(stats["host_ms"])

    result = {
        "method": "same checkpoint and prompt; two warmups each;"
                  " rotating execution order; synchronized generation wall timing;"
                  " no profiler; compilation and first use excluded for compiled paths",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "model": args.model, "revision": args.revision,
        "resolved_revision": getattr(model.config, "_commit_hash", None),
        "prompt_tokens": args.prompt_tokens, "new_tokens": args.new_tokens,
        "prompt_ids_sha256": hashlib.sha256(bytes(str(ids), "utf-8")).hexdigest(),
        "greedy_ids_identical": agree,
        "path_descriptions": {
            "native": "original Hugging Face LLaMA MLP forward",
            "reordered_eager": "patched forward computes gate and up, then F.silu(gate) * up",
            "triton": "patched forward computes gate and up, then Triton SwiGLU",
            **({"compiled": "patched forward computes gate and up, then"
                          " torch.compile/Inductor post-projection SwiGLU"}
               if args.include_compiled else {}),
            **({"compiled_mlp": "patched forward calls a weight-parameterized"
                              " torch.compile/Inductor full MLP"}
               if args.include_compiled_mlp else {}),
        },
        "times_ms": times,
        "medians_ms": {name: statistics.median(values) for name, values in times.items()},
        "gpu": torch.cuda.get_device_name(0), "torch": torch.__version__,
        "seed": 42, "repeats": args.repeats,
        "accuracy_note": "identical greedy IDs on this prompt only; prior Triton full-logit strict check failed",
    }
    if args.include_compiled:
        result["compiled_backend"] = "inductor"
        result["compiled_scope"] = "SwiGLU activation after both projections, not the full MLP"
        result["compiled_logit_diagnostics"] = compiled_logit_diagnostics["compiled"]
        result["compiled_status"] = ("strict_logits_passed" if compiled_logit_diagnostics["compiled"][
            "strict_mismatch_count"] == 0 else "exploratory_timing_strict_logits_failed")
    if args.include_compiled_mlp:
        result["compiled_mlp_backend"] = "inductor"
        result["compiled_mlp_scope"] = "gate/up projections, SwiGLU and down projection"
        result["compiled_mlp_logit_diagnostics"] = compiled_logit_diagnostics["compiled_mlp"]
        result["compiled_mlp_status"] = ("strict_logits_passed" if compiled_logit_diagnostics[
            "compiled_mlp"]["strict_mismatch_count"] == 0
            else "exploratory_timing_strict_logits_failed")
    if args.mlp_host_timing:
        result["mlp_calls_per_generation"] = len(model.model.layers) * args.new_tokens
        result["mlp_host_ms_each"] = host_times
        result["mlp_host_medians_ms"] = {
            name: statistics.median(values) for name, values in host_times.items()
        }
        result["mlp_host_note"] = ("Unsynchronized elapsed host time inside MLP calls;"
                                   " includes any internal blocking and timing overhead."
                                   " It is not an additive fraction of generation wall latency.")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
