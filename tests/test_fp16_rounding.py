"""Regression for rare SiLU rounding differences amplified by TinyLlama."""

import pytest

torch = pytest.importorskip("torch")
pytest.importorskip("triton")

from swiglu_triton.ops import swiglu_torch, swiglu_triton

pytestmark = pytest.mark.skipif(not torch.cuda.is_available(), reason="CUDA required")


def test_observed_fp16_boundary_with_explicit_output():
    up = torch.tensor([-1.3330078125, -1.603515625, -0.67333984375,
                       -0.8798828125, -1.5517578125], dtype=torch.float16, device="cuda")
    gate = torch.full_like(up, -2.724609375)
    out = torch.empty_like(gate)
    result = swiglu_triton(gate, up, out=out)
    assert result is out
    assert torch.equal(result.view(torch.int16), swiglu_torch(gate, up).view(torch.int16))


def test_all_finite_fp16_gates_against_eager():
    patterns = torch.arange(65536, dtype=torch.int32, device="cuda").to(torch.int16)
    values = patterns.view(torch.float16)
    gate = values[torch.isfinite(values)].contiguous()
    assert gate.numel() == 63488
    generator = torch.Generator(device="cuda").manual_seed(42)
    shuffled_up = gate[torch.randperm(gate.numel(), device="cuda", generator=generator)]
    for up in (torch.ones_like(gate), shuffled_up):
        expected = swiglu_torch(gate, up)
        actual = swiglu_triton(gate, up)
        # Includes signed zeros and equal overflow infinities. Inputs are finite;
        # this sweep does not enumerate every possible gate/up pair.
        assert torch.equal(actual.view(torch.int16), expected.view(torch.int16))
