"""Three-way control for the native, reordered eager and Triton LLaMA MLP."""

import argparse
import hashlib
import json
import math
import statistics
import time
from contextlib import contextmanager
from datetime import datetime, timezone
from pathlib import Path
from types import MethodType

import torch
import torch.nn.functional as F

from swiglu_triton.hf_llama import use_triton_llama_mlps


def reordered_eager_forward(mlp: torch.nn.Module, x: torch.Tensor) -> torch.Tensor:
    gate = mlp.gate_proj(x)
    up = mlp.up_proj(x)
    return mlp.down_proj(F.silu(gate) * up)


@contextmanager
def provider(model: torch.nn.Module, name: str):
    if name == "native":
        yield
    elif name == "triton":
        with use_triton_llama_mlps(model):
            yield
    elif name == "reordered_eager":
        mlps = [layer.mlp for layer in model.model.layers]
        originals = [mlp.forward for mlp in mlps]
        try:
            for mlp in mlps:
                mlp.forward = MethodType(reordered_eager_forward, mlp)
            yield
        finally:
            for mlp, original in zip(mlps, originals):
                mlp.forward = original
    else:
        raise ValueError(f"unknown provider: {name}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Full-model MLP schedule control")
    parser.add_argument("--model", default="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
    parser.add_argument("--revision", default="main")
    parser.add_argument("--prompt-tokens", type=int, default=128)
    parser.add_argument("--new-tokens", type=int, default=16)
    parser.add_argument("--repeats", type=int, default=5)
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

    names = ("native", "reordered_eager", "triton")
    with torch.inference_mode():
        outputs = {}
        for name in names:
            with provider(model, name):
                outputs[name] = generate()
        agree = {name: torch.equal(outputs["native"], outputs[name]) for name in names}
        if not all(agree.values()):
            raise AssertionError(f"greedy token mismatch; no timing: {agree}")
        if outputs["native"].shape[-1] != args.prompt_tokens + args.new_tokens:
            raise AssertionError("generation did not produce requested number of tokens")

        def measure(name: str) -> float:
            with provider(model, name):
                torch.cuda.synchronize()
                start = time.perf_counter()
                generate()
                torch.cuda.synchronize()
                return (time.perf_counter() - start) * 1000

        for _ in range(2):
            for name in names:
                measure(name)
        rotations = (names, ("triton", "native", "reordered_eager"),
                     ("reordered_eager", "triton", "native"))
        times = {name: [] for name in names}
        for i in range(args.repeats):
            for name in rotations[i % len(rotations)]:
                times[name].append(measure(name))

    result = {
        "method": "same checkpoint and prompt; three MLP paths; two warmups each;"
                  " rotating execution order; synchronized generation wall timing;"
                  " no profiler, no compilation",
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
        },
        "times_ms": times,
        "medians_ms": {name: statistics.median(values) for name, values in times.items()},
        "gpu": torch.cuda.get_device_name(0), "torch": torch.__version__,
        "seed": 42, "repeats": args.repeats,
        "accuracy_note": "identical greedy IDs on this prompt only; prior Triton full-logit strict check failed",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
