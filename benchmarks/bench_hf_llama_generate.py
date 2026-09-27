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
    parser.add_argument("--profile-output-dir", type=Path,
                        help="optional CPU/CUDA profiler tables from one extra generation per path")
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
    attention_mask = torch.ones_like(input_ids)
    kwargs = dict(max_new_tokens=args.new_tokens, min_new_tokens=args.new_tokens,
                  do_sample=False, num_beams=1, use_cache=True,
                  pad_token_id=(tokenizer.pad_token_id if tokenizer.pad_token_id is not None
                                else tokenizer.eos_token_id))

    def generate() -> torch.Tensor:
        return model.generate(input_ids=input_ids, attention_mask=attention_mask, **kwargs)

    def elapsed_ms() -> float:
        torch.cuda.synchronize()
        start = time.perf_counter()
        generate()
        torch.cuda.synchronize()
        return (time.perf_counter() - start) * 1000

    with torch.inference_mode():
        original_logits = model(input_ids=input_ids, attention_mask=attention_mask,
                                use_cache=False).logits
        original_ids = generate()
        with use_triton_llama_mlps(model) as patched_layers:
            fused_logits = model(input_ids=input_ids, attention_mask=attention_mask,
                                 use_cache=False).logits
            fused_ids = generate()
        abs_error = (original_logits.float() - fused_logits.float()).abs()
        max_abs_logit_error = abs_error.max().item()
        mean_abs_logit_error = abs_error.mean().item()
        strict_mismatch_count = (~torch.isclose(fused_logits, original_logits,
                                                rtol=1e-2, atol=1e-2)).sum().item()
        top1_mismatch_positions = (fused_logits.argmax(dim=-1) !=
                                   original_logits.argmax(dim=-1)).sum().item()
        outputs_identical = torch.equal(original_ids, fused_ids)
        validation = {
            "outputs_identical": outputs_identical,
            "strict_logit_check_rtol_atol": 1e-2,
            "strict_logit_mismatch_count": int(strict_mismatch_count),
            "logit_count": original_logits.numel(),
            "max_abs_logit_error": max_abs_logit_error,
            "mean_abs_logit_error": mean_abs_logit_error,
            "top1_mismatch_positions": int(top1_mismatch_positions),
        }
        print("Validation:", validation, flush=True)
        if not outputs_identical:
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(json.dumps({"status": "token_mismatch_no_timing",
                                               "validation": validation}, indent=2) + "\n",
                                   encoding="utf-8")
            raise AssertionError("greedy output token IDs differed; diagnostic result saved, no timing")
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
        "validation": validation,
        "status": ("strict_logits_passed" if strict_mismatch_count == 0
                   else "exploratory_timing_strict_logits_failed"),
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

    if args.profile_output_dir is not None:
        from torch.profiler import ProfilerActivity, profile

        args.profile_output_dir.mkdir(parents=True, exist_ok=True)
        for provider in ("eager", "triton"):
            with torch.inference_mode():
                if provider == "eager":
                    with profile(activities=[ProfilerActivity.CPU, ProfilerActivity.CUDA]) as prof:
                        generate()
                        torch.cuda.synchronize()
                else:
                    with use_triton_llama_mlps(model):
                        with profile(activities=[ProfilerActivity.CPU, ProfilerActivity.CUDA]) as prof:
                            generate()
                            torch.cuda.synchronize()
            # Profiling changes execution costs; these tables are diagnostic,
            # never substituted for the synchronized wall timings above.
            table = prof.key_averages().table(sort_by="self_cuda_time_total", row_limit=40)
            (args.profile_output_dir / f"{provider}_cuda_table.txt").write_text(
                table + "\n", encoding="utf-8"
            )
            rows = [
                {"name": event.key, "count": event.count,
                 "self_cpu_us": event.self_cpu_time_total,
                 "self_cuda_us": event.self_cuda_time_total}
                for event in prof.key_averages()
            ]
            (args.profile_output_dir / f"{provider}_events.json").write_text(
                json.dumps(rows, indent=2) + "\n", encoding="utf-8"
            )
        print(f"Saved profiler tables and events in {args.profile_output_dir}")


if __name__ == "__main__":
    main()
