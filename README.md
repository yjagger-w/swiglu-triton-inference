# SwiGLU Triton inference: correctness and performance study

A reproducible, forward-only GPU engineering project. It implements
post-projection SwiGLU fusion, integrates it into Hugging Face LLaMA MLPs,
and measures operator, layer and model performance on a Tesla T4.

**v0.1 conclusion:** the corrected FP16 operator accelerates the tested
standalone workloads versus PyTorch eager. It does not establish an
end-to-end generation speedup. A fixed-shape CUDA Graph control found no
stable incremental model-forward benefit from this fusion.

[中文项目总结](docs/PROJECT_SUMMARY_CN.md) ·
[本地解压与推送](docs/LOCAL_PUSH_CN.md) ·
[Result provenance](results/PROVENANCE.md)

## What is fused?

```python
gate = gate_proj(x)
up = up_proj(x)
y = silu(gate) * up       # fused into one Triton kernel
out = down_proj(y)
```

The projections remain PyTorch operations. SwiGLU is an existing activation;
this project studies its implementation, numerical behavior and integration.
The final FP16 kernel uses CUDA libdevice exp and precise division, then
rounds the SiLU intermediate to FP16 before multiplication. FP32/BF16 use
the earlier sigmoid path; native BF16 requires compute capability >= 8.0.

## Final measured results — 2026-09-29

Environment: Tesla T4 (CC 7.5), Python 3.12.14, PyTorch 2.6.0+cu124,
Triton 3.2.0, Transformers 4.51.3. The user ran **21 tests passed, 5 BF16
cases skipped** on T4 after integrating the FP16 arithmetic fix.

### Corrected FP16 standalone operator

Both paths allocate output; the reference is eager `F.silu(gate) * up`.
Times are milliseconds. All six reported maximum absolute errors were zero.

| Tokens × features | Eager | Triton | Speedup |
| --- | ---: | ---: | ---: |
| 1 × 4096 | 0.008640 | 0.004576 | 1.888× |
| 1 × 11008 | 0.006688 | 0.005312 | 1.259× |
| 128 × 4096 | 0.020480 | 0.016160 | 1.267× |
| 128 × 11008 | 0.055520 | 0.035680 | 1.556× |
| 1024 × 4096 | 0.153760 | 0.092256 | 1.667× |
| 1024 × 11008 | 0.397696 | 0.238272 | 1.669× |

These are one run's results, not a universal speed range. Small microsecond
cases need particular care when interpreting variance. The historical
compiled-activation comparison did not demonstrate a clear hand-written
kernel advantage; it preceded the FP16 arithmetic fix.

### TinyLlama checkpoint generation

Checkpoint: `TinyLlama/TinyLlama-1.1B-Chat-v1.0`, revision
`fe8a4ea1ffedaf415f4da2f062534de366a451e6`; batch 1, 128 input tokens,
16 generated tokens, FP16, five paired alternating timings.

| Path | Median generation latency |
| --- | ---: |
| Original model | 349.475 ms |
| Corrected Triton SwiGLU | 402.405 ms |

The Triton path was **15.1% slower** (0.868× speedup). Generated token IDs
and all 4,096,000 logits in the separate full-prompt validation matched.
This validation covers the stated prompt and environment, not general model
quality or every decoding workload.

### Four-way CUDA Graph control

Scope: repeated fixed-shape 128-token forwards with full logits, SDPA and the
same precomputed 4D causal mask. **No KV cache and no generation.** Eight
balanced rotations, ten calls per block, reporting per-forward averages.

| MLP path | Ordinary execution | CUDA Graph |
| --- | ---: | ---: |
| Native | 22.116 ms | 17.736 ms |
| Triton | 24.950 ms | 17.768 ms |

All checked outputs matched on the original and rolled input. Native Graph
improved over native ordinary execution by 1.247×. Triton Graph versus native
Graph was 0.998×, with paired ratios above and below one: no stable extra
fusion benefit was observed. Graph replay changes launch and allocation
behavior; this does not attribute all earlier loss to Python alone.

## Reproduce on a CUDA Linux environment

Windows can store, inspect and push this repository. GPU experiments were
run on Linux. Activate an environment with the tested CUDA stack, then:

```bash
python -m pip install -e '.[test,model]'
export OMP_NUM_THREADS=1
python -m pytest -q
python benchmarks/bench_swiglu.py --dtype fp16 --output results/recheck_fp16.json
python benchmarks/bench_hf_llama_generate.py \
  --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
  --revision fe8a4ea1ffedaf415f4da2f062534de366a451e6 \
  --prompt-tokens 128 --new-tokens 16 --repeats 5 \
  --output results/recheck_generate.json
python benchmarks/bench_hf_cudagraph_control.py \
  --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
  --revision fe8a4ea1ffedaf415f4da2f062534de366a451e6 \
  --prompt-tokens 128 --repeats 8 --calls 10 \
  --output results/recheck_graph.json
```

For the existing AutoDL environment, the Python executable is
`/root/autodl-tmp/st-mamba/environment/st-mamba-py312/bin/python`. Set
`HF_HOME=/root/autodl-tmp/hf-cache` and `HF_HUB_OFFLINE=1` when using the
already downloaded checkpoint. The package does not contain model weights
or a Python environment. Dependency minimums are not a compatibility guarantee
for every version combination; reproduce with the measured environment first.

## Diagnostic tools

| Script | Purpose |
| --- | --- |
| `bench_swiglu.py` | Standalone operator timing |
| `bench_llama_mlp.py`, `bench_mlp_stages.py` | Synthetic full layer and isolated stages |
| `bench_compiled_swiglu.py` | Compiled activation reference |
| `bench_hf_llama_generate.py` | Checkpoint generation and optional profiler |
| `bench_decode_dispatch.py` | Repeated decode-shaped activation calls |
| `bench_hf_mlp_variants.py` | Native, reordered, Triton and optional compiled controls |
| `bench_hf_prefill_decode.py` | Separate full-prompt and one-token cached forward |
| `diagnose_hf_swiglu_accuracy.py` | Native-input and cumulative layer errors |
| `verify_hf_swiglu_math.py` | All finite FP16 gates and arithmetic candidates |
| `bench_hf_cudagraph_control.py` | Fair four-way fixed-forward Graph control |
| `profile_swiglu.py` | Operator traces, not benchmark latency |

The arithmetic-candidate script's `current` path now uses the corrected
production operator; its old two-mismatch result belongs to the pre-fix
code. Historical results are retained, not overwritten by corrected runs.

## Evidence and scope

- [Final operator rows](results/t4_fp16_div.json)
- [Corrected generation](results/t4_tinyllama_generate_fp16_div.json)
- [CUDA Graph control](results/t4_tinyllama_cudagraph_control_fp16.json)
- [Diagnostic summary](results/t4_diagnostics_summary_20260929.json)
- [FP16 fix analysis](docs/fp16_accuracy_fix_20260929.md)
- [Historical experiment log](docs/t4_baseline_20260927.md)
- [LLaMA learning bridge](docs/llama_serving_bridge.md)

Forward inference only; matching nonempty contiguous CUDA tensors; no
backward implementation, GEMM fusion or production serving integration.
The FP16 sweep covers all finite gate bit patterns for selected up inputs,
not every pair or non-finite input. v0.1 is closed at the measured boundary.
ST-Mamba remains a separate research project.

## Background

- [GLU Variants Improve Transformer](https://arxiv.org/abs/2002.05202)
- [Triton tutorials](https://triton-lang.org/main/getting-started/tutorials/)
- [PyTorch 2.6 CUDA Graphs](https://docs.pytorch.org/docs/2.6/notes/cuda.html#cuda-graphs)
