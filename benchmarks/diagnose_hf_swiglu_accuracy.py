"""Locate SwiGLU numerical differences on native layer inputs; no timing."""

import argparse
import hashlib
import json
import math
from datetime import datetime, timezone
from pathlib import Path

import torch
import torch.nn.functional as F

from swiglu_triton.hf_llama import use_triton_llama_mlps
from swiglu_triton.ops import swiglu_triton


def differences(actual, reference):
    if actual.shape != reference.shape or actual.dtype != reference.dtype:
        raise AssertionError("comparison shape/dtype mismatch")
    reference = reference.to(actual.device)
    finite = torch.isfinite(actual) & torch.isfinite(reference)
    diff = (actual.float() - reference.float()).abs()
    all_finite = bool(finite.all().item())
    return {
        "shape": list(actual.shape),
        "count": actual.numel(),
        "nonfinite_pairs": int((~finite).sum().item()),
        "unequal_count": int((actual != reference).sum().item()),
        "strict_mismatch_count": int((~torch.isclose(
            actual, reference, rtol=0.01, atol=0.01)).sum().item()),
        "max_abs_error": diff.max().item() if all_finite else None,
        "mean_abs_error": diff.mean().item() if all_finite else None,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--model", default="TinyLlama/TinyLlama-1.1B-Chat-v1.0")
    parser.add_argument("--revision", default="main")
    parser.add_argument("--prompt-tokens", type=int, default=128)
    parser.add_argument("--output", type=Path,
                        default=Path("results/t4_tinyllama_accuracy_layers_fp16.json"))
    args = parser.parse_args()
    if args.prompt_tokens <= 0 or not torch.cuda.is_available():
        parser.error("positive prompt length and CUDA GPU required")
    from transformers import AutoModelForCausalLM, AutoTokenizer

    torch.manual_seed(42)
    tokenizer = AutoTokenizer.from_pretrained(args.model, revision=args.revision)
    model = AutoModelForCausalLM.from_pretrained(
        args.model, revision=args.revision, torch_dtype=torch.float16
    ).to("cuda").eval()
    if model.config.model_type != "llama" or model.config.hidden_act != "silu":
        parser.error("LLaMA SiLU MLP required")
    if getattr(model.config, "pretraining_tp", 1) != 1:
        parser.error("this diagnostic requires pretraining_tp=1")
    unit = tokenizer.encode("Explain why fused GPU operations can reduce memory traffic. ",
                            add_special_tokens=False)
    if not unit:
        parser.error("empty tokenized prompt")
    bos = [tokenizer.bos_token_id] if tokenizer.bos_token_id is not None else []
    ids = (bos + unit * math.ceil(args.prompt_tokens / len(unit)))[:args.prompt_tokens]
    input_ids = torch.tensor([ids], device="cuda", dtype=torch.long)
    mask = torch.ones_like(input_ids)
    mlps = [layer.mlp for layer in model.model.layers]
    references, isolated, cumulative = {}, {}, {}

    def forward():
        return model(input_ids=input_ids, attention_mask=mask,
                     use_cache=False, return_dict=True).logits

    def native_hook(index):
        def hook(mlp, inputs, output):
            x = inputs[0]
            references[index] = (x.detach().cpu().clone(), output.detach().cpu().clone())
            # Shadow computations share native inputs; actual model output is untouched.
            gate, up = mlp.gate_proj(x), mlp.up_proj(x)
            activation = F.silu(gate)
            eager = activation * up
            fused = swiglu_triton(gate, up)
            eager_down = mlp.down_proj(eager)
            fused_down = mlp.down_proj(fused)
            row = {
                "layer": index,
                "silu_via_unit_up": differences(swiglu_triton(gate, torch.ones_like(up)),
                                                activation),
                "swiglu_same_gate_up": differences(fused, eager),
                "down_proj_same_input": differences(fused_down, eager_down),
                "eager_reconstruction_vs_native": differences(eager_down, output),
            }
            if bool((torch.isfinite(fused) & torch.isfinite(eager)).all().item()):
                worst = int((fused.float() - eager.float()).abs().flatten().argmax().item())
                row["largest_swiglu_difference_example"] = {
                    "flat_index": worst,
                    "gate": gate.flatten()[worst].item(), "up": up.flatten()[worst].item(),
                    "eager": eager.flatten()[worst].item(), "triton": fused.flatten()[worst].item(),
                }
            isolated[index] = row
        return hook

    def fused_hook(index):
        def hook(_mlp, inputs, output):
            x_ref, y_ref = references[index]
            cumulative[index] = {
                "layer": index,
                "mlp_input_vs_native": differences(inputs[0], x_ref),
                "mlp_output_vs_native": differences(output, y_ref),
            }
        return hook

    def capture(factory):
        handles = []
        try:
            for index, mlp in enumerate(mlps):
                handles.append(mlp.register_forward_hook(factory(index)))
            return forward()
        finally:
            for handle in handles:
                handle.remove()

    with torch.inference_mode():
        forward()  # Untimed warmup of the native model.
        native_logits = capture(native_hook)
        repeat_logits = forward()
        repeat_check = differences(repeat_logits, native_logits)
        with use_triton_llama_mlps(model):
            fused_logits = capture(fused_hook)
        logit_check = differences(fused_logits, native_logits)
        logit_check["top1_mismatch_positions"] = int((fused_logits.argmax(-1) !=
                                                      native_logits.argmax(-1)).sum().item())
    if set(isolated) != set(range(len(mlps))) or set(cumulative) != set(isolated):
        raise AssertionError("missing layer records")

    result = {
        "method": "native-input shadow activation/MLP comparisons, followed by all-layer"
                  " Triton replacement; full-prompt forwards, no KV cache, no timing",
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "model": args.model, "revision": args.revision,
        "resolved_revision": getattr(model.config, "_commit_hash", None),
        "prompt_tokens": args.prompt_tokens,
        "prompt_ids_sha256": hashlib.sha256(str(ids).encode()).hexdigest(),
        "dtype": "fp16", "gpu": torch.cuda.get_device_name(0),
        "torch": torch.__version__, "seed": 42,
        "strict_check_rtol_atol": 0.01,
        "native_repeat_logits": repeat_check,
        "fused_logits_vs_native": logit_check,
        "isolated_native_inputs": [isolated[i] for i in range(len(mlps))],
        "cumulative_fused_path": [cumulative[i] for i in range(len(mlps))],
        "notes": ["Layer indices start at zero; hook shadow outputs do not replace native outputs.",
                  "Unit up isolates the rounded SiLU value through the existing fused kernel.",
                  "Cumulative input differences include effects propagated through attention and residuals.",
                  "If native repeat or eager reconstruction differs, attribution needs further controls.",
                  "One prompt diagnoses differences; it does not establish model quality."],
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, allow_nan=False) + "\n", encoding="utf-8")
    print("native_repeat_logits:", repeat_check)
    print("fused_logits_vs_native:", logit_check)
    print("layer | SwiGLU unequal/max | isolated down max | cumulative input/output max")
    for index in range(len(mlps)):
        local, path = isolated[index], cumulative[index]
        s = local["swiglu_same_gate_up"]
        print(index, s["unequal_count"], s["max_abs_error"],
              local["down_proj_same_input"]["max_abs_error"],
              path["mlp_input_vs_native"]["max_abs_error"],
              path["mlp_output_vs_native"]["max_abs_error"])
    print(f"Saved {args.output}")


if __name__ == "__main__":
    main()
