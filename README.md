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
- No autograd, strided tensors, in-place output, quantization, linear GEMM
  fusion, `torch.compile` baseline, real model checkpoint or generation
  integration in this version. The separate MLP harness tests one full layer.
- A fast post-projection operator alone does **not** establish faster LLM
  inference. Later end-to-end work must measure the share of MLP time, account
  for projection GEMMs, and compare against compiled/framework baselines.
- Never report numbers from a CPU-only machine as T4 performance. Keep GPU
  benchmark files and profiler evidence alongside any performance claim.

## Next milestones

1. Run the test and benchmark matrix on the actual T4; preserve outputs and
   describe shapes where fusion helps or hurts.
2. Add an appropriate compiled PyTorch baseline and profile kernel launches,
   memory traffic and occupancy before tuning block size.
3. Integrate at one real model MLP call site and compare generation latency
   with identical inputs and numerical criteria.
4. Decide whether a TVM lowering experiment or a quantized gate is justified
   by measured bottlenecks. ST-Mamba remains a separate thesis project; its
   SiLU gating path would require its own profiling and integration work.

## Background

- [GLU Variants Improve Transformer](https://arxiv.org/abs/2002.05202)
- [Triton vector addition tutorial](https://triton-lang.org/main/getting-started/tutorials/01-vector-add.html)
- [Triton benchmarking API](https://triton-lang.org/main/python-api/generated/triton.testing.do_bench.html)
