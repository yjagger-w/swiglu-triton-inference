"""Four-way fixed-shape forward comparison; no KV cache or generation."""

import argparse
import hashlib
import json
import math
import statistics
import time
from contextlib import nullcontext
from datetime import datetime, timezone
from pathlib import Path

import torch

from swiglu_triton.hf_llama import use_triton_llama_mlps


def validation(actual, reference):
    diff = (actual.float() - reference.float()).abs()
    finite = bool((torch.isfinite(actual) & torch.isfinite(reference)).all().item())
    return {
        "logit_count": reference.numel(), "all_finite": finite,
        "unequal_count": int((actual != reference).sum().item()),
        "strict_mismatch_count": int((~torch.isclose(
            actual, reference, rtol=0.01, atol=0.01)).sum().item()),
        "max_abs_error": diff.max().item() if finite else None,
        "top1_mismatch_positions": int((actual.argmax(-1) != reference.argmax(-1)).sum().item()),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", default="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
    parser.add_argument("--revision", default="fe8a4ea1ffedaf415f4da2f062534de366a451e6")
    parser.add_argument("--prompt-tokens", type=int, default=128)
    parser.add_argument("--repeats", type=int, default=8)
    parser.add_argument("--calls", type=int, default=10)
    parser.add_argument("--output", type=Path,
                        default=Path("results/t4_tinyllama_cudagraph_control_fp16.json"))
    args = parser.parse_args()
    if min(args.prompt_tokens, args.calls, args.repeats) <= 0 or args.repeats % 4:
        parser.error("positive sizes required; repeats must be a multiple of 4 for balanced order")
    if not torch.cuda.is_available():
        parser.error("CUDA GPU required")
    from transformers import AutoModelForCausalLM, AutoTokenizer
    import transformers

    def save(result):
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2, allow_nan=False) + "\n",
                               encoding="utf-8")

    torch.manual_seed(42)
    tokenizer = AutoTokenizer.from_pretrained(args.model, revision=args.revision)
    model = AutoModelForCausalLM.from_pretrained(
        args.model, revision=args.revision, torch_dtype=torch.float16,
        attn_implementation="sdpa",
    ).to("cuda").eval()
    if model.config.model_type != "llama" or model.config.hidden_act != "silu":
        parser.error("LLaMA SiLU MLP required")
    unit = tokenizer.encode("Explain why fused GPU operations can reduce memory traffic. ",
                            add_special_tokens=False)
    if not unit:
        parser.error("empty tokenized prompt")
    bos = [tokenizer.bos_token_id] if tokenizer.bos_token_id is not None else []
    ids = (bos + unit * math.ceil(args.prompt_tokens / len(unit)))[:args.prompt_tokens]
    input_ids = torch.tensor([ids], device="cuda", dtype=torch.long)
    original_ids = input_ids.clone()
    position = torch.arange(args.prompt_tokens, device="cuda", dtype=torch.long)
    position_ids = position.unsqueeze(0)
    # All four paths use the same precomputed additive causal mask. A 4D mask
    # avoids data-dependent mask decisions that may synchronize during capture.
    mask = torch.triu(torch.full((args.prompt_tokens, args.prompt_tokens),
                                torch.finfo(torch.float16).min,
                                device="cuda", dtype=torch.float16), diagonal=1)[None, None]

    def forward():
        return model(input_ids=input_ids, attention_mask=mask,
                     position_ids=position_ids, cache_position=position,
                     use_cache=False, return_dict=True).logits

    def provider(name):
        return use_triton_llama_mlps(model) if name == "triton" else nullcontext()

    names = ("native_eager", "triton_eager", "native_graph", "triton_graph")
    graphs, static_outputs = {}, {}
    metadata = {
        "model": args.model, "revision": args.revision,
        "resolved_revision": getattr(model.config, "_commit_hash", None),
        "prompt_tokens": args.prompt_tokens,
        "prompt_ids_sha256": hashlib.sha256(str(ids).encode()).hexdigest(),
        "gpu": torch.cuda.get_device_name(0), "torch": torch.__version__,
        "transformers": transformers.__version__, "cuda": torch.version.cuda,
        "scope": "full-prompt model forward, full logits, SDPA, fixed 4D causal mask;"
                 " no KV cache, no generation, no torch.compile",
        "repeats": args.repeats, "calls_per_block": args.calls, "seed": 42,
        "strict_check_rtol_atol": 0.01,
    }

    with torch.inference_mode():
        for name in ("native", "triton"):
            print(f"Warming and capturing {name}...", flush=True)
            try:
                with provider(name):
                    stream = torch.cuda.Stream()
                    stream.wait_stream(torch.cuda.current_stream())
                    with torch.cuda.stream(stream):
                        for _ in range(3):
                            temporary = forward()
                    torch.cuda.current_stream().wait_stream(stream)
                    torch.cuda.synchronize()
                    del temporary
                    graph = torch.cuda.CUDAGraph()
                    with torch.cuda.graph(graph, stream=stream):
                        output = forward()
                    torch.cuda.synchronize()
                    graphs[name], static_outputs[name] = graph, output
            except RuntimeError as error:
                save({**metadata, "status": "capture_failed_no_timing", "provider": name,
                      "error": str(error)})
                raise

        def replay(name):
            graphs[name].replay()
            return static_outputs[name]

        checks = {}
        # Also verify that replay consumes new token IDs at the same addresses.
        for label, tokens in (("original", original_ids),
                              ("rolled_input", original_ids.roll(1, dims=1))):
            input_ids.copy_(tokens)
            reference = forward().clone()
            with provider("triton"):
                eager_output = forward()
            checks[label] = {"triton_eager": validation(eager_output, reference)}
            for name in ("native", "triton"):
                checks[label][name + "_graph"] = validation(replay(name), reference)
        input_ids.copy_(original_ids)
        if any(not row["all_finite"] or row["strict_mismatch_count"] or
               row["top1_mismatch_positions"] for group in checks.values() for row in group.values()):
            save({**metadata, "status": "accuracy_failed_no_timing", "validation": checks})
            raise SystemExit(f"Validation failed; diagnostic saved in {args.output}")

        def measure(name, calls):
            is_graph = name.endswith("_graph")
            base = name.split("_")[0]
            context = nullcontext() if is_graph else provider(base)
            with context:
                call = (lambda: replay(base)) if is_graph else forward
                torch.cuda.synchronize()
                start = time.perf_counter()
                for _ in range(calls):
                    out = call()
                submitted = time.perf_counter()
                torch.cuda.synchronize()
                finished = time.perf_counter()
                del out
                return {"wall_ms_per_forward": (finished - start) * 1000 / calls,
                        "submit_ms_per_forward": (submitted - start) * 1000 / calls}

        for name in names:
            measure(name, 3)
        times = {name: [] for name in names}
        orders = []
        for i in range(args.repeats):
            offset = i % len(names)
            order = names[offset:] + names[:offset]
            orders.append(list(order))
            for name in order:
                times[name].append(measure(name, args.calls))
    medians = {name: statistics.median(row["wall_ms_per_forward"] for row in rows)
               for name, rows in times.items()}
    paired = [a["wall_ms_per_forward"] / b["wall_ms_per_forward"]
              for a, b in zip(times["native_graph"], times["triton_graph"])]
    result = {
        **metadata, "status": "strict_validation_passed",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(), "validation": checks,
        "method": "synchronized wall timing of repeated same-input forwards; each"
                  " block divided by call count; compilation/capture/warmup excluded;"
                  " provider order rotated evenly",
        "orders": orders, "measurements": times, "median_wall_ms_per_forward": medians,
        "ratios": {
            "triton_over_native_eager_speedup": medians["native_eager"] / medians["triton_eager"],
            "triton_over_native_graph_speedup": medians["native_graph"] / medians["triton_graph"],
            "native_graph_over_native_eager_speedup": medians["native_eager"] / medians["native_graph"],
            "triton_graph_over_triton_eager_speedup": medians["triton_eager"] / medians["triton_graph"],
        },
        "paired_graph_speedups": paired,
        "notes": ["Speedup > 1 means the named optimized path is faster.",
                  "Repeated-forward averages are not single-request or generate latency.",
                  "Inputs and masks are already on GPU; graph outputs reuse fixed buffers.",
                  "Submission time can include internal blocking; it is not pure CPU compute.",
                  "Graph replay changes launch and allocation behavior; differences do not isolate Python alone.",
                  "Compare native_graph with triton_graph to assess incremental fusion benefit."],
    }
    save(result)
    print(json.dumps(result, indent=2))
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
