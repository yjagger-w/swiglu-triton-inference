"""Optional TVM tests: CPU execution, rewrite safety, CUDA tails and FP16 bits."""
import platform
import re

import pytest

tvm = pytest.importorskip("tvm")
np = pytest.importorskip("numpy")
from tvm import relax
from swiglu_tvm.operator import build_operator, primfunc, schedule
from swiglu_tvm.cpu import LLVM_NO_AUTO_VECTOR, compile_cpu, strip_mine_fp32
from swiglu_tvm.fusion import FuseSwiGLU, example, build_relax, legalize_swiglu


def reference(g, u):
    with np.errstate(over="ignore", invalid="ignore", divide="ignore"):
        x = g.astype("float32")
        a = (x / (np.float32(1) + np.exp(-x))).astype(g.dtype)
        return (a.astype("float32") * u.astype("float32")).astype(g.dtype)


def fused(mod, **kw):
    return FuseSwiGLU(dense_inputs=True, **kw)(mod)


def count_custom(mod):
    return sum(g.name_hint.startswith("custom_swiglu") for g in mod.functions)


@pytest.mark.parametrize("dtype", ["float32", "float16"])
@pytest.mark.parametrize("shape", [(1,), (127,), (1025,), (1, 5632), (128, 5632), (17, 11008)])
def test_cpu_operator(shape, dtype):
    rng = np.random.default_rng(42)
    g = (rng.standard_normal(shape) * 5).astype(dtype)
    u = rng.standard_normal(shape).astype(dtype)
    g.flat[:min(7, g.size)] = np.array([0, -1, 1, -90, 90, -2.724609375, -0.0])[:min(7, g.size)]
    lib, _ = build_operator(shape, dtype)
    out = tvm.runtime.empty(shape, dtype)
    lib["main"](tvm.runtime.tensor(g), tvm.runtime.tensor(u), out)
    tol = 3e-5 if dtype == "float32" else 3e-3  # existing tests/test_ops.py
    np.testing.assert_allclose(out.numpy(), reference(g, u), rtol=tol, atol=tol)


def test_pass_positive_idempotent_and_disabled():
    mod = example()
    after = fused(mod)
    assert count_custom(after) == 1
    assert "R.call_tir" in after.script()
    assert "R.nn.silu" not in after.script()
    tvm.ir.assert_structural_equal(after, fused(after))
    tvm.ir.assert_structural_equal(mod, FuseSwiGLU(enabled=False)(mod))
    tvm.ir.assert_structural_equal(mod, FuseSwiGLU()(mod))  # no dense-layout attestation


@pytest.mark.parametrize("kind", ["multi", "broadcast", "other"])
def test_unsafe_or_other_pattern_unchanged(kind):
    mod = example(kind=kind)
    tvm.ir.assert_structural_equal(mod, fused(mod))


@pytest.mark.parametrize("dtype", ["float16", "float64", "bfloat16"])
def test_dtype_default_rejection(dtype):
    mod = example(dtype=dtype)
    tvm.ir.assert_structural_equal(mod, fused(mod))


def test_fp16_separate_opt_in():
    assert count_custom(fused(example(dtype="float16"), enable_fp16=True)) == 1


def test_symbolic_shape_rejected():
    mod = example(shape=(tvm.tirx.Var("n", "int64"),))
    tvm.ir.assert_structural_equal(mod, fused(mod))


@pytest.mark.parametrize("enabled", [False, True])
@pytest.mark.parametrize("dtype", ["float32", "float16"])
def test_cpu_relax_numeric(enabled, dtype):
    exe, _, _ = build_relax(example(dtype=dtype), enabled=enabled, fp16=True)
    vm = relax.VirtualMachine(exe, tvm.cpu())
    rng = np.random.default_rng(42)
    g, u = (rng.standard_normal(127).astype(dtype) for _ in range(2))
    actual = vm["main"](tvm.runtime.tensor(g), tvm.runtime.tensor(u)).numpy()
    tol = 3e-5 if dtype == "float32" else 3e-3
    np.testing.assert_allclose(actual, reference(g, u), rtol=tol, atol=tol)


@pytest.mark.parametrize("shape", [(7,), (8,), (9,), (3, 11)])
@pytest.mark.parametrize("enabled", [False, True])
def test_cpu_strip_mine_numeric_and_tail(shape, enabled):
    mod = strip_mine_fp32(legalize_swiglu(fused(example(shape), enabled=enabled)))
    rng = np.random.default_rng(42)
    g, u = (rng.standard_normal(shape).astype("float32") for _ in range(2))
    g.flat[:4] = [np.nan, np.inf, -np.inf, -90]
    g.flat[-1] = -1.25
    u.flat[-1] = 2.0
    inputs = [tvm.runtime.tensor(x) for x in (g, u)]
    for vectorize in (False, True):
        exe = compile_cpu(mod, "llvm", vectorize=vectorize)
        vm = relax.VirtualMachine(exe, tvm.cpu())
        np.testing.assert_allclose(vm["main"](*inputs).numpy(), reference(g, u),
                                   rtol=3e-5, atol=3e-5, equal_nan=True)


@pytest.mark.skipif(platform.machine().lower() not in ("amd64", "x86_64"), reason="x86 assembly check")
@pytest.mark.parametrize("enabled", [False, True])
def test_cpu_x86_vector_switch_codegen(enabled):
    mod = strip_mine_fp32(legalize_swiglu(fused(example((129,)), enabled=enabled)))
    target = {"kind": "llvm", "mcpu": "x86-64", "mattr": ["+avx2"],
              "cl-opt": list(LLVM_NO_AUTO_VECTOR), "opt-level": 3, "fast-math": False}
    for vectorize in (False, True):
        exe = compile_cpu(mod, target, vectorize=vectorize)
        library, = (m for m in exe.mod.imports if m.kind == "llvm")
        ll = library.inspect_source("ll")
        asm = library.inspect_source("asm")
        assert "@llvm.exp.f32(" in ll  # scalar tail in both
        assert ("@llvm.exp.v8f32(" in ll) is vectorize
        assert bool(re.search(r"\bvdivps\b[^\n]*%ymm", asm)) is vectorize
        assert re.search(r"\bvdivss\b", asm)


def test_nonfinite_policy_cpu():
    # IEEE classification supported; NaN payload/sign and zero sign are not contractual.
    g = np.array([np.nan, np.inf, -np.inf, 0, 1, -1], dtype="float32")
    u = np.array([1, 1, 1, np.inf, np.nan, -np.inf], dtype="float32")
    lib, _ = build_operator(g.shape)
    out = tvm.runtime.empty(g.shape)
    lib["main"](tvm.runtime.tensor(g), tvm.runtime.tensor(u), out)
    np.testing.assert_allclose(out.numpy(), reference(g, u), equal_nan=True)


@pytest.mark.parametrize("shape", [(1,), (127,), (1025,), (1, 5632), (128, 5632), (1024, 5632)])
@pytest.mark.parametrize("dtype", ["float32", "float16"])
def test_cuda_against_existing_eager(shape, dtype):
    torch = pytest.importorskip("torch")
    if not torch.cuda.is_available():
        pytest.skip("CUDA required")
    td = getattr(torch, dtype)
    generator = torch.Generator(device="cuda").manual_seed(42)
    g = torch.randn(shape, device="cuda", dtype=td, generator=generator) * 5
    u = torch.randn(shape, device="cuda", dtype=td, generator=generator)
    expected = torch.nn.functional.silu(g) * u
    lib, _ = build_operator(shape, dtype, {"kind": "cuda", "arch": "sm_75"})
    ga, ua = (tvm.runtime.from_dlpack(x) for x in (g, u))
    out = tvm.runtime.empty(shape, dtype, tvm.cuda())
    torch.cuda.synchronize()
    lib["main"](ga, ua, out)
    tvm.cuda().sync()
    actual = torch.from_dlpack(out)
    tol = 3e-5 if dtype == "float32" else 3e-3
    torch.testing.assert_close(actual, expected, rtol=tol, atol=tol)


def test_cuda_fp16_all_finite_bits_and_boundary():
    torch = pytest.importorskip("torch")
    if not torch.cuda.is_available():
        pytest.skip("CUDA required")
    vals = torch.arange(65536, device="cuda", dtype=torch.int32).to(torch.int16).view(torch.float16)
    gate = vals[torch.isfinite(vals)].contiguous()
    gen = torch.Generator(device="cuda").manual_seed(42)
    ups = [torch.ones_like(gate), gate[torch.randperm(gate.numel(), device="cuda", generator=gen)]]
    lib, _ = build_operator(tuple(gate.shape), "float16", {"kind": "cuda", "arch": "sm_75"})
    for up in ups:
        expected = torch.nn.functional.silu(gate) * up
        out = tvm.runtime.empty(tuple(gate.shape), "float16", tvm.cuda())
        torch.cuda.synchronize()
        lib["main"](tvm.runtime.from_dlpack(gate), tvm.runtime.from_dlpack(up), out)
        tvm.cuda().sync()
        assert torch.equal(torch.from_dlpack(out).view(torch.int16), expected.view(torch.int16))
    # The production regression's exact observed gate/up pair is included explicitly.
    gate = torch.full((5,), -2.724609375, dtype=torch.float16, device="cuda")
    up = torch.tensor([-1.3330078125, -1.603515625, -0.67333984375, -0.8798828125, -1.5517578125],
                      dtype=torch.float16, device="cuda")
    lib, _ = build_operator((5,), "float16", {"kind": "cuda", "arch": "sm_75"})
    out = tvm.runtime.empty((5,), "float16", tvm.cuda())
    torch.cuda.synchronize()
    lib["main"](tvm.runtime.from_dlpack(gate), tvm.runtime.from_dlpack(up), out)
    tvm.cuda().sync()
    assert torch.equal(torch.from_dlpack(out).view(torch.int16),
                       (torch.nn.functional.silu(gate) * up).view(torch.int16))


def test_schedule_tail_predicate():
    text = schedule(primfunc((1025,), cuda=True), cuda=True).script()
    assert "threadIdx.x" in text and "blockIdx.x" in text
    assert "T.where" in text and "vectorized" in text


@pytest.mark.parametrize("kind", ["view", "shape", "unknown"])
def test_layout_shape_and_unknown_rejections(kind):
    g = relax.Var("g", relax.TensorStructInfo((3, 1), "float32"))
    u = relax.Var("u", relax.TensorStructInfo((1, 3), "float32"))
    if kind == "unknown":
        g = relax.Var("g", relax.TensorStructInfo(dtype="float32", ndim=2))
        u = relax.Var("u", relax.TensorStructInfo(dtype="float32", ndim=2))
    bb = relax.BlockBuilder()
    with bb.function("main", [g, u]):
        with bb.dataflow():
            x = bb.emit(relax.op.permute_dims(g)) if kind == "view" else g
            a = bb.emit(relax.op.nn.silu(x))
            y = bb.emit_output(relax.op.multiply(a, u))
        bb.emit_func_output(y)
    mod = bb.get()
    tvm.ir.assert_structural_equal(mod, fused(mod))


def test_cpu_fp16_rounding_not_eliminated():
    g = np.full(127, 0.5, dtype="float16")
    u = np.linspace(-5, 5, 127).astype("float16")
    expected = reference(g, u)
    x = g.astype("float32")
    unrounded = (x / (1 + np.exp(-x)) * u.astype("float32")).astype("float16")
    assert np.any(expected != unrounded)
    lib, _ = build_operator(g.shape, "float16")
    out = tvm.runtime.empty(g.shape, "float16")
    lib["main"](tvm.runtime.tensor(g), tvm.runtime.tensor(u), out)
    np.testing.assert_array_equal(out.numpy().view("uint16"), expected.view("uint16"))


def test_decomposed_or_legalized_input_unchanged():
    mod = relax.transform.LegalizeOps()(example())
    tvm.ir.assert_structural_equal(mod, fused(mod))
    g = relax.Var("g", relax.TensorStructInfo((127,), "float32"))
    u = relax.Var("u", relax.TensorStructInfo((127,), "float32"))
    bb = relax.BlockBuilder()
    with bb.function("main", [g, u]):
        with bb.dataflow():
            sigmoid = bb.emit(relax.op.sigmoid(g))
            a = bb.emit(relax.op.multiply(g, sigmoid))
            out = bb.emit_output(relax.op.multiply(a, u))
        bb.emit_func_output(out)
    mod = bb.get()
    tvm.ir.assert_structural_equal(mod, fused(mod))


def test_precise_callback_restored_and_real_cuda_source():
    import tempfile
    from pathlib import Path
    from swiglu_tvm.cuda import export_cuda_source, precise_cuda
    old = tvm.get_global_func("tvm_callback_cuda_compile")
    with pytest.raises(RuntimeError, match="sentinel"):
        with precise_cuda():
            raise RuntimeError("sentinel")
    # Compare FFI function identity via same_as.
    assert old.same_as(tvm.get_global_func("tvm_callback_cuda_compile"))
    with tempfile.TemporaryDirectory() as tmp:
        path = Path(tmp) / "actual.cu"
        export_cuda_source(schedule(primfunc((1025,), "float16", True), True), path)
        code = path.read_text()
    assert "__global__" in code and "__fdiv_rn" in code and "expf" in code
    assert "< 1025" in code
    assert old.same_as(tvm.get_global_func("tvm_callback_cuda_compile"))


@pytest.mark.parametrize("dtype", ["float32", "float16"])
def test_gpu_relax_codegen_on_off_without_execution(dtype):
    import tempfile
    from pathlib import Path
    import re
    with tempfile.TemporaryDirectory() as tmp:
        for enabled, count in [(False, 2), (True, 1)]:
            path = Path(tmp) / f"{enabled}.cu"
            exe, _, _ = build_relax(example((1025,), dtype),
                                    {"kind": "cuda", "arch": "sm_75"}, enabled,
                                    fp16=True, source_only=path)
            assert exe is None  # source-only export must never masquerade as an executable
            names = re.findall(r'extern "C" __global__ [^\n;{]*? (\w+)\([^()\n]*\) \{', path.read_text())
            assert len(names) == count


@pytest.mark.parametrize("dtype", ["float32", "float16"])
@pytest.mark.parametrize("enabled", [False, True])
def test_cuda_relax_nonfinite_and_values(dtype, enabled):
    torch = pytest.importorskip("torch")
    if not torch.cuda.is_available():
        pytest.skip("CUDA required")
    g = torch.tensor([0, -0.0, -1, 1, -90, 90, float("nan"), float("inf"), -float("inf")],
                     dtype=getattr(torch, dtype), device="cuda")
    u = torch.ones_like(g)
    exe, _, _ = build_relax(example((9,), dtype), {"kind": "cuda", "arch": "sm_75"}, enabled, fp16=True)
    vm = relax.VirtualMachine(exe, tvm.cuda())
    torch.cuda.synchronize()
    out = vm["main"](tvm.runtime.from_dlpack(g), tvm.runtime.from_dlpack(u))
    tvm.cuda().sync()
    expected = torch.nn.functional.silu(g) * u
    tol = 3e-5 if dtype == "float32" else 3e-3
    torch.testing.assert_close(torch.from_dlpack(out), expected, rtol=tol, atol=tol, equal_nan=True)
