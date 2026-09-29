# FP16 SiLU arithmetic diagnosis and integration

Evidence below is from user-pasted T4 output on 2026-09-29, with PyTorch
2.6.0+cu124, Triton 3.2.0 and the fixed 128-token TinyLlama prompt used by the
earlier benchmarks. The checkpoint revision is
`fe8a4ea1ffedaf415f4da2f062534de366a451e6`.

The native model repeated exactly. With original native layer inputs, only
14 of 15,859,712 SwiGLU outputs differed across 22 layers. Layer 7 (zero
based) was the first divergence. Each affected layer's printed maximum-error
sample had gate value -2.724609375; these examples alone do not prove that
every differing element had the same input. Eager MLP reconstruction matched
native outputs exactly. The original fused model had 315 full-prompt logits
outside rtol=atol=0.01, maximum absolute difference 0.0234375.

`verify_hf_swiglu_math.py` then compared all 63,488 finite FP16 gate bit
patterns, including signed zero, against eager `F.silu(gate) * up`. It used
six constant up choices and one permutation of finite FP16 up values.

| Arithmetic | Bitwise mismatches per up case |
| --- | ---: |
| Original multiply by sigmoid | 2 |
| libdevice exp, precise division | 0 |
| libdevice exp, precise reciprocal then multiply | 1 |

The selected division candidate matched all 22 layers and all 4,096,000
full-prompt logits exactly in the subsequent model diagnostic. It also had
zero top-1 mismatches. This validates these inputs and environment; it does
not establish behavior on every model prompt, dtype, device or software
version, nor does it measure speed. Non-finite inputs and every possible
gate/up pair were not exhaustively tested.

The integration adds a dedicated FP16 kernel with
`tl.div_rn(x, 1.0 + libdevice.exp(-x))`, then rounds activation to FP16 before
the final product. It uses `enable_fp_fusion=False`, matching the tested
candidate. The existing FP32/BF16 path retains its previous arithmetic.
Regression tests cover the observed boundary, caller-provided output storage,
and all finite FP16 gate values with unit and permuted up inputs.

Integration was subsequently validated on T4: 21 tests passed and five BF16
tests skipped. Six standalone FP16 shapes reported zero maximum absolute
error. The corrected checkpoint generation result is in
`results/t4_tinyllama_generate_fp16_div.json`: all compared logits and generated
IDs matched; native median 349.475 ms versus Triton 402.405 ms. Numerical
agreement did not establish an end-to-end speedup. The final Graph control
and experiment boundaries are summarized in the root README.

Source checked:
https://github.com/pytorch/pytorch/blob/v2.6.0/aten/src/ATen/native/cuda/ActivationSiluKernel.cu
