"""Checkpoint-backed separate prefill and one-token cached decode timings."""

import argparse
import hashlib
import json
import math
import statistics
import time
from datetime import datetime, timezone
from pathlib import Path

import torch

from bench_hf_mlp_variants import full_mlp_reference, provider


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", default="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
    parser.add_argument("--revision", default="main")
    parser.add_argument("--prompt-tokens", type=int, default=128)
    parser.add_argument("--repeats", type=int, default=5)
    parser.add_argument("--output", type=Path,
                        default=Path("results/t4_tinyllama_prefill_decode_fp16.json"))
    args = parser.parse_args()
    if min(args.prompt_tokens, args.repeats) <= 0:
        parser.error("prompt-tokens and repeats must be positive")
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
    decode_mask = torch.ones((1, args.prompt_tokens + 1), device="cuda", dtype=torch.long)
    compiled_mlp = torch.compile(full_mlp_reference, backend="inductor", fullgraph=True)
    names = ("native", "reordered_eager", "triton", "compiled_mlp")

    def prefill():
        return model(input_ids=input_ids, attention_mask=attention_mask,
                     use_cache=True, return_dict=True)

    def decode(next_id, cache):
        return model(input_ids=next_id, attention_mask=decode_mask,
                     past_key_values=cache, use_cache=True, return_dict=True)

    with torch.inference_mode():
        with provider(model, "native", compiled_mlp=compiled_mlp):
            native_prefill = prefill()
            next_id = native_prefill.logits[:, -1:, :].argmax(-1)
            native_decode = decode(next_id, native_prefill.past_key_values)
        references = (native_prefill.logits, native_decode.logits)
        diagnostics = {}
        for name in names:
            with provider(model, name, compiled_mlp=compiled_mlp):
                initial = prefill()
                step = decode(next_id, initial.past_key_values)
            diagnostics[name] = {}
            for phase, actual, reference in zip(
                ("prefill", "decode"), (initial.logits, step.logits), references
            ):
                diagnostics[name][phase] = {
                    "strict_mismatch_count": int((~torch.isclose(
                        actual, reference, rtol=1e-2, atol=1e-2)).sum().item()),
                    "logit_count": reference.numel(),
                    "max_abs_error": (actual.float() - reference.float()).abs().max().item(),
                    "top1_mismatch_positions": int((actual.argmax(-1) !=
                                                    reference.argmax(-1)).sum().item()),
                }
        if any(item[phase]["top1_mismatch_positions"] for item in diagnostics.values()
               for phase in ("prefill", "decode")):
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(json.dumps({"status": "top1_mismatch_no_timing",
                                               "diagnostics": diagnostics}, indent=2) + "\n",
                                   encoding="utf-8")
            raise AssertionError(f"top-1 mismatch; diagnostic saved in {args.output}")

        def measure(name, phase):
            with provider(model, name, compiled_mlp=compiled_mlp):
                if phase == "prefill":
                    torch.cuda.synchronize()
                    start = time.perf_counter()
                    output = prefill()
                    torch.cuda.synchronize()
                else:
                    # Fresh cache for each call; prefill and its sync are excluded.
                    cache = prefill().past_key_values
                    torch.cuda.synchronize()
                    start = time.perf_counter()
                    output = decode(next_id, cache)
                    torch.cuda.synchronize()
                elapsed = (time.perf_counter() - start) * 1000
                del output
                return elapsed

        for _ in range(2):
            for name in names:
                for phase in ("prefill", "decode"):
                    measure(name, phase)
        times = {phase: {name: [] for name in names} for phase in ("prefill", "decode")}
        for i in range(args.repeats):
            offset = i % len(names)
            ordered = names[offset:] + names[:offset]
            for phase in ("prefill", "decode"):
                for name in ordered:
                    times[phase][name].append(measure(name, phase))

    result = {
        "method": "same FP16 checkpoint and fixed prompt; four MLP paths;"
                  " two warmups per path/phase; rotating provider order; synchronized"
                  " single-forward wall time; no profiler; compilation excluded",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "model": args.model, "revision": args.revision,
        "resolved_revision": getattr(model.config, "_commit_hash", None),
        "prompt_tokens": args.prompt_tokens,
        "prompt_ids_sha256": hashlib.sha256(bytes(str(ids), "utf-8")).hexdigest(),
        "decode_input": "native prefill argmax token shared by all providers",
        "phase_scope": {
            "prefill": "one full-prompt forward with full logits and KV cache creation",
            "decode": "one forward with exactly one new token and a fresh prior KV cache;"
                      " cache-building prefill excluded from timed interval",
        },
        "accuracy": diagnostics,
        "strict_check_rtol_atol": 0.01,
        "accuracy_note": "top-1 agreement on this prompt and one step only;"
                         " strict mismatches remain exploratory",
        "times_ms": times,
        "medians_ms": {phase: {name: statistics.median(values)
                              for name, values in group.items()}
                       for phase, group in times.items()},
        "gpu": torch.cuda.get_device_name(0), "torch": torch.__version__,
        "seed": 42, "repeats": args.repeats,
        "timing_note": "standalone forwards; do not sum prefill and one decode"
                       " to estimate 16-token model.generate latency",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
