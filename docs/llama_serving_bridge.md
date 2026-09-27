# From LLaMA study to a SwiGLU experiment

The [shared LLaMA/LLM serving conversation](https://chatgpt.com/share/6ab88a60-7728-83ec-a536-5140347fc9a5)
summarizes two course sections: Llama 3.1/3.2 applications (including
tokenization, prompts, multimodal inputs, tools, and Llama Stack), and efficient
serving (generation, KV cache, batching, quantization, and LoRA). The separate
Word attachment mentioned there was not available from the shared page. This
note uses the visible course outline and official LLaMA-style MLP code, rather
than claiming to reproduce the attachment or the original notebooks.

## Where the kernel is in the model

The MLP computes `down_proj(SiLU(gate_proj(x)) * up_proj(x))`. This repository
fuses only the middle `SiLU(gate) * up` expression; the layer harness adds
three independent linear projections and uses the same randomly initialized
weights for both providers. Meta's Llama FeedForward and Hugging Face's
LlamaMLP use this structure. This is a structural example, not a downloaded
Llama 3.1/3.2 checkpoint or an exact model configuration.

| Course concept | What it changes for this experiment |
| --- | --- |
| Autoregressive generation | Decode calls the layer for newly generated token positions; test small flattened token counts such as 1 and 8. |
| Prompt prefill | A prompt feeds many positions through the MLP; test larger flattened token counts such as 128 and 1024. |
| Continuous batching | The number of active token positions varies; evaluate a shape matrix rather than one fixed tensor. |
| KV cache | It avoids recomputing attention history; this MLP has no KV cache, but changing attention cost can change how much MLP optimization matters to whole-model latency. |
| INT8 quantization | Future work needs a separately defined numerical contract and actual low-precision execution, not just a fake quantization label. |
| LoRA / Multi-LoRA | Adapted projection weights can change GEMM execution and layer-level economics; the current MLP has no adapters. |
| Tokenization, prompts, multimodal input, tools | They change the workload and application behavior, but this numeric kernel sees only the projected tensors. |

`tokens` is the total number of positions presented to one MLP call, such as
batch size multiplied by prompt length for a simple prefill. The harness does
not simulate a scheduler or a generation loop. Timing this layer cannot prove
end-to-end token/s gains.

## Evidence ladder

1. Operator correctness and latency: `bench_swiglu.py`.
2. Same-weights MLP correctness and latency: `bench_llama_mlp.py`.
3. Actual framework integration with a real model, compiled baseline and
   generation workload. This is a future milestone, subject to GPU and model
   availability.

The second benchmark is critical: projection GEMMs can dominate a layer, so
an operator speedup might be invisible after adding them. Report both results,
including shapes where the fused path loses.

## References

- [Meta Llama FeedForward implementation](https://github.com/meta-llama/llama3/blob/main/llama/model.py)
- [Hugging Face LlamaMLP implementation](https://github.com/huggingface/transformers/blob/main/src/transformers/models/llama/modeling_llama.py)
