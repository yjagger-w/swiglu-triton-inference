import pytest

torch = pytest.importorskip("torch")
pytest.importorskip("triton")

from swiglu_triton import swiglu_torch, swiglu_triton


def test_reference_known_values():
    gate = torch.tensor([0.0, 1.0, -1.0])
    up = torch.tensor([7.0, 2.0, 2.0])
    actual = swiglu_torch(gate, up)
    expected = torch.tensor([0.0, 2.0 / (1.0 + 1.0 / 2.718281828459045),
                             -2.0 / (1.0 + 2.718281828459045)])
    torch.testing.assert_close(actual, expected, rtol=1e-6, atol=1e-6)


@pytest.mark.skipif(not torch.cuda.is_available(), reason="CUDA required")
@pytest.mark.parametrize("shape", [(1,), (127,), (1025,), (128, 4096), (17, 11008)])
@pytest.mark.parametrize("dtype", [torch.float32, torch.float16, torch.bfloat16])
def test_triton_matches_eager(shape, dtype):
    if dtype == torch.bfloat16 and torch.cuda.get_device_capability()[0] < 8:
        pytest.skip("Triton BF16 kernel requires compute capability 8.0 or newer")
    generator = torch.Generator(device="cuda").manual_seed(42)
    gate = torch.randn(shape, device="cuda", dtype=dtype, generator=generator) * 5
    up = torch.randn(shape, device="cuda", dtype=dtype, generator=generator)
    reference = swiglu_torch(gate, up)
    actual = swiglu_triton(gate, up)
    tolerance = {torch.float32: (3e-5, 3e-5), torch.float16: (3e-3, 3e-3),
                 torch.bfloat16: (2e-2, 2e-2)}[dtype]
    torch.testing.assert_close(actual, reference, rtol=tolerance[0], atol=tolerance[1])
    out = torch.empty_like(gate)
    assert swiglu_triton(gate, up, out=out) is out
    torch.testing.assert_close(out, reference, rtol=tolerance[0], atol=tolerance[1])


def test_validation():
    with pytest.raises(ValueError, match="same nonempty shape"):
        swiglu_torch(torch.ones(2), torch.ones(3))
    with pytest.raises(ValueError, match="requires CUDA"):
        swiglu_triton(torch.ones(2), torch.ones(2))


@pytest.mark.skipif(not torch.cuda.is_available(), reason="CUDA required")
def test_bf16_rejected_before_compilation_on_t4():
    if torch.cuda.get_device_capability()[0] >= 8:
        pytest.skip("native BF16 GPU")
    gate = torch.ones(2, device="cuda", dtype=torch.bfloat16)
    with pytest.raises(ValueError, match="compute capability 8.0"):
        swiglu_triton(gate, gate)
