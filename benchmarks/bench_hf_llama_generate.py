"""Checkpoint-backed LLaMA greedy generation: original versus Triton MLP."""

import argparse
import hashlib
import json
import math
import platform
import statistics
import time
from datetime import datetime, timezone
from pathlib import Path

import torch
import triton

from swiglu_triton.hf_llama import use_triton_llama_mlps


def main() -> None:
    parser = argparse.ArgumentParser(description="Real LLaMA checkpoint generation benchmark")
    parser.add_argument("--model", default="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
    parser.add_argument("--revision", default="main")
    parser.add_argument("--prompt-tokens", type=int, default=128)
    parser.add_argument("--new-tokens", type=int, default=16)
    parser.add_argument("--repeats", type=int, default=5)
    parser.add_argument("--output", type=Path, default=Path("results/t4_tinyllama_generate_fp16.json"))
    args = parser.parse_args()
    if min(args.prompt_tokens, args.new_tokens, args.repeats) <= 0:
        parser.error("token lengths and repeats must be positive")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required")

    try:
        from transformers import AutoModelForCausalLM, AutoTokenizer
        import transformers
    except ImportError as exc:
        parser.error(f"install optional Transformers dependencies first: {exc}")

    torch.manual_seed(42)
    tokenizer = AutoTokenizer.from_pretrained(args.model, revision=args.revision)
    model = AutoModelForCausalLM.from_pretrained(
        args.model, revision=args.revision, torch_dtype=torch.float16
    ).to("cuda").eval()
    if model.config.model_type != "llama" or model.config.hidden_act != "silu":
        parser.error("checkpoint must use a LLaMA SiLU MLP")

    # A deterministic, valid-token prompt. The same IDs are used in both paths.
    phrase = "Explain why fused GPU operations can reduce memory traffic. "
    token_unit = tokenizer.encode(phrase, add_special_tokens=False)
    if not token_unit:
        parser.error("tokenizer returned an empty prompt")
    bos = [tokenizer.bos_token_id] if tokenizer.bos_token_id is not None else []
    ids = (bos + token_unit * math.ceil(args.prompt_tokens / len(token_unit)))[:args.prompt_tokens]
    input_ids = torch.tensor([ids], device="cuda", dtype=torch.long)
    kwargs = dict(max_new_tokens=args.new_tokens, min_new_tokens=args.new_tokens,
                  do_sample=False, num_beams=1, use_cache=True,
                  pad_token_id=tokenizer.pad_token_id or tokenizer.eos_token_id)

    def generate() -> torch.Tensor:
        return model.generate(input_ids=input_ids, **kwargs)

    def elapsed_ms() -> float:
        torch.cuda.synchronize()
        start = time.perf_counter()
        generate()
        torch.cuda.synchronize()
        return (time.perf_counter() - start) * 1000

    with torch.inference_mode():
        original_logits = model(input_ids=input_ids, use_cache=False).logits
        original_ids = generate()
        with use_triton_llama_mlps(model) as patched_layers:
            fused_logits = model(input_ids=input_ids, use_cache=False).logits
            fused_ids = generate()
        max_abs_logit_error = (original_logits.float() - fused_logits.float()).abs().max().item()
        torch.testing.assert_close(fused_logits, original_logits, rtol=1e-2, atol=1e-2)
        outputs_identical = torch.equal(original_ids, fused_ids)
        if not outputs_identical:
            raise AssertionError("greedy output token IDs differed; no timing result was saved")
        expected_length = args.prompt_tokens + args.new_tokens
        if original_ids.shape[-1] != expected_length:
            raise AssertionError("generation length differed from the requested fixed length")

        # Warm both paths, then alternate them to reduce ordering bias.
        for _ in range(2):
            elapsed_ms()
            with use_triton_llama_mlps(model):
                elapsed_ms()
        original_times, fused_times = [], []
        for i in range(args.repeats):
            if i % 2:
                with use_triton_llama_mlps(model):
                    fused_times.append(elapsed_ms())
                original_times.append(elapsed_ms())
            else:
                original_times.append(elapsed_ms())
                with use_triton_llama_mlps(model):
                    fused_times.append(elapsed_ms())

    result = {
        "method": "checkpoint-backed greedy generation; fixed prompt and token count; paired alternating wall timings with CUDA synchronization; no compilation",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "model": args.model, "requested_revision": args.revision,
        "resolved_revision": getattr(model.config, "_commit_hash", None),
        "model_type": model.config.model_type, "layers_patched": patched_layers,
        "hidden_size": model.config.hidden_size,
        "intermediate_size": model.config.intermediate_size,
        "prompt_tokens": args.prompt_tokens, "new_tokens": args.new_tokens,
        "prompt_ids_sha256": hashlib.sha256(bytes(str(ids), "utf-8")).hexdigest(),
        "outputs_identical": outputs_identical,
        "max_abs_logit_error": max_abs_logit_error,
        "eager_ms_each": original_times, "triton_ms_each": fused_times,
        "eager_median_ms": statistics.median(original_times),
        "triton_median_ms": statistics.median(fused_times),
        "speedup": statistics.median(original_times) / statistics.median(fused_times),
        "gpu": torch.cuda.get_device_name(0),
        "compute_capability": list(torch.cuda.get_device_capability(0)),
        "python": platform.python_version(), "torch": torch.__version__,
        "cuda": torch.version.cuda, "triton": triton.__version__,
        "transformers": transformers.__version__, "seed": 42,
        "repeats": args.repeats,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
