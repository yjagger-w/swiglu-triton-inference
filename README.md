# SwiGLU Triton inference operator

An independent, forward-only GPU operator project. Version 0.1 fuses the
**post-projection** SwiGLU calculation:

```text
gate = gate_proj(x)       # existing linear projection, outside this kernel
up   = up_proj(x)         # existing linear projection, outside this kernel
y    = SiLU(gate) * up    # this project
out  = down_proj(y)       # outside this kernel
```

The goal is to establish an honest, reproducible performance and correctness
baseline before attempting compiler integration or full-model claims. SwiGLU
itself is an existing activation, not a proposed new algorithm.

## Environment

- Linux with an NVIDIA CUDA GPU. A T4 supports the FP16 and FP32 runs; the
  Triton BF16 kernel requires compute capability 8.0 or newer. PyTorch can
  report emulated BF16 on a T4, which is insufficient for Triton PTX assembly.
- Python 3.10 or newer, a CUDA-enabled PyTorch build and a compatible Triton
  installation. Install the CUDA PyTorch build appropriate for the machine
  first using the [official PyTorch selector](https://pytorch.org/get-started/locally/).
- From this directory: `python -m pip install -e '.[test]'`

Dependencies intentionally specify minimum versions rather than an unverified
CUDA/PyTorch/Triton combination. Record the installed versions with each run.

## Run

```bash
python -m pytest -q
python benchmarks/bench_swiglu.py --dtype fp16 --output results/t4_fp16.json
python benchmarks/bench_swiglu.py --dtype fp32 --output results/t4_fp32.json
python benchmarks/bench_llama_mlp.py --dtype fp16 --output results/t4_mlp_fp16.json
python benchmarks/bench_mlp_stages.py --output results/t4_mlp_stages_fp16.json
python benchmarks/bench_compiled_swiglu.py --output results/t4_compiled_swiglu_fp16.json
python benchmarks/profile_swiglu.py --output-dir results/t4_profile_swiglu
```

## Real checkpoint experiment (optional)

`bench_hf_llama_generate.py` loads a Hugging Face LLaMA checkpoint (default:
TinyLlama 1.1B Chat) in FP16 and temporarily replaces the SwiGLU part of
each MLP's forward call. It records strict logit mismatches and requires
identical greedy token IDs before paired generation timings with identical
prompt, weights, cache setting and token count. Timings with a failed strict
logit check are explicitly marked exploratory. Checkpoint download and Transformers are separate
from the operator-only environment; the `model` extra lists the optional
dependencies. On T4 use FP16 because native BF16 is unavailable.

```bash
python benchmarks/bench_hf_llama_generate.py \
  --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
  --prompt-tokens 128 --new-tokens 16 \
  --output results/t4_tinyllama_generate_fp16.json
```

The reviewed T4 TinyLlama result is saved in
[`results/t4_tinyllama_generate_fp16.json`](results/t4_tinyllama_generate_fp16.json).
All greedy output token IDs matched, but 315 of 4,096,000 logits failed the
strict `rtol=atol=0.01` check. The 128-prompt/16-new-token generation took
351.085 ms for the original model and 398.582 ms with the Triton replacement
(medians of five); this is exploratory and **slower** with Triton. A
checkpoint-backed speed claim requires wider numerical validation and
profiling. The adapter works
with the LLaMA `model.model.layers[*].mlp` layout and SiLU activation; it
does not attempt to patch other model families or compiled full models.

To collect operator-level evidence for the full-model slowdown, rerun with
`--profile-output-dir results/t4_tinyllama_profile`. Profiling adds one extra
generation per path **after** the regular timing result has been saved. The
profiler tables and event JSON are diagnostics, not latency measurements.
If the wall-timing result has already been saved, add `--profile-only` to
collect just the two traces without repeating validation and timed runs.
For an order check, add `--profile-sequence eager,triton,eager` and choose a
new profile output directory. The first and last eager profiles can reveal
whether the profiler session itself drifted; use synchronized wall timings
for performance claims.
`bench_decode_dispatch.py` measures host submission and synchronized wall
time for repeated 1 × 5632 FP16 SwiGLU calls without a profiler. It uses the
real model's intermediate width, but synthetic tensors and no projections.
This isolates Python dispatch costs and cannot substitute for model latency.
For a checkpoint-backed compiler control, run `bench_hf_mlp_variants.py` with
`--include-compiled` and a new output path. Only the post-projection SwiGLU
operation is compiled. The script warms all four paths, checks greedy IDs,
records full-prompt compiled logit differences, and excludes compilation from
the rotating generation timings. A failed strict logit check marks compiled
timing exploratory.
For the first v0.2 baseline, use `--include-compiled-mlp` with a separate
output file. The compiled function accepts the original gate/up/down weights
as tensor arguments, so layers with the same shapes can share its graph. It
includes all three projections and records greedy-token and strict-logit
comparisons before timing generation. This does not compile the full model.
The [four-way checkpoint control](results/t4_tinyllama_compiled_control_fp16.json)
found that both hand-written Triton and Inductor-compiled post-projection
SwiGLU were slower than the native model on this T4 prompt. The strict
full-logit check failed for the compiled path; see the
[T4 report](docs/t4_baseline_20260927.md) before citing this result.
The later [full-MLP compiler control](results/t4_tinyllama_full_mlp_compile_fp16.json)
also showed a slowdown on this T4 prompt: native 354.356 ms versus compiled
full MLP 402.761 ms. Its strict full-logit check failed, despite identical
greedy token IDs. Use `bench_hf_prefill_decode.py` to separate a full-prompt
forward from one cached decode forward; its prefill is excluded from the
decode timer. These phase measurements need a T4 run and are not a substitute
for 16-token generation timing.

```bash
OMP_NUM_THREADS=1 HF_HUB_OFFLINE=1 \
HF_HOME=/root/autodl-tmp/hf-cache PYTHONPATH=src \
/root/autodl-tmp/st-mamba/environment/st-mamba-py312/bin/python \
  benchmarks/bench_hf_prefill_decode.py \
  --model TinyLlama/TinyLlama-1.1B-Chat-v1.0 \
  --revision fe8a4ea1ffedaf415f4da2f062534de366a451e6 \
  --prompt-tokens 128 --repeats 5 \
  --output results/t4_tinyllama_prefill_decode_fp16.json
```

For a short smoke test:

```bash
python benchmarks/bench_swiglu.py --tokens 1,128 --features 4096 --repeats 1 --output results/smoke.json
```

The default shape matrix measures 1, 128 and 1024 token rows, with 4096 and
11008 intermediate channels. These are synthetic operator inputs, not a
claim that a particular model layer uses those exact dimensions.

The MLP harness separately measures one LLaMA-style layer with synthetic,
locally initialized weights at 1, 8, 128 and 1024 token positions. It includes
the gate, up and down projections for **both** providers. The dimensions
`4096/11008` are an explicit experiment setting, not a verified Llama 3.1/3.2
checkpoint shape. See [the LLaMA serving bridge](docs/llama_serving_bridge.md)
for the link to the earlier course topics and for interpreting decode/prefill.

The tool compares PyTorch eager `F.silu(gate) * up` against the Triton wrapper;
both allocate their output. Timing uses repeated `triton.testing.do_bench`
measurements and records milliseconds, speedup, maximum absolute error, GPU,
software versions and seed in JSON and CSV. The two implementations may have
small floating-point differences. Correctness must pass before timing is
saved. Benchmark outputs are ignored by Git until reviewed; the reviewed T4
JSON baselines and profiling traces are explicitly tracked.

The measured T4 baseline and its limitations are in
[docs/t4_baseline_20260927.md](docs/t4_baseline_20260927.md).
For a follow-up timing breakdown, `bench_mlp_stages.py` measures each linear
projection and activation independently, plus both full-layer paths. Its
isolated stage times should not be summed to predict full-layer latency.
`bench_compiled_swiglu.py` compares the same post-projection operation against
the PyTorch Inductor compiled public reference (after compilation). Its
numerical tolerance allows compiler fusion to change FP16 intermediate
rounding and reports maximum absolute error for both alternatives.
`profile_swiglu.py` saves kernel tables and Chrome traces separately for eager
and Triton; profiler timings are diagnostic, not benchmark latencies.

## Scope and interpretation

- Supported: matching, nonempty, contiguous CUDA tensors; FP16/FP32, and BF16
  on GPUs with compute capability 8.0 or newer. The PyTorch reference can also
  run on CPU.
- No autograd, strided tensors, in-place output, quantization or linear GEMM
  fusion. The separate MLP harness tests one synthetic full layer; the
  checkpoint generation experiments are described in the T4 report.
- A fast post-projection operator alone does **not** establish faster LLM
  inference. Later end-to-end work must measure the share of MLP time, account
  for projection GEMMs, and compare against compiled/framework baselines.
- Never report numbers from a CPU-only machine as T4 performance. Keep GPU
  benchmark files and profiler evidence alongside any performance claim.

## Next milestones

1. Treat v0.1 as a bounded negative result for post-projection-only T4 decode
   acceleration; keep standalone kernel and model-level findings distinct.
2. If continuing to v0.2, first compare a broader MLP optimization boundary
   with a compiled full-MLP baseline and separate prefill/decode timings.
3. Validate logits and greedy tokens on multiple prompts before any deployment
   or speed claim. ST-Mamba remains an independent thesis project.

## Background

- [GLU Variants Improve Transformer](https://arxiv.org/abs/2002.05202)
- [Triton vector addition tutorial](https://triton-lang.org/main/getting-started/tutorials/01-vector-add.html)
- [Triton benchmarking API](https://triton-lang.org/main/python-api/generated/triton.testing.do_bench.html)
