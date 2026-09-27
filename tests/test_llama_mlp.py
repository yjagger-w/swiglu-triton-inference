import pytest

torch = pytest.importorskip("torch")
pytest.importorskip("triton")

from swiglu_triton.llama_mlp import LlamaStyleMLP


def test_cpu_layer_matches_explicit_graph():
    torch.manual_seed(7)
    model = LlamaStyleMLP(8, 16).eval()
    x = torch.randn(3, 8)
    result = model(x)
    expected = model.down_proj(
        torch.nn.functional.silu(model.gate_proj(x)) * model.up_proj(x)
    )
    torch.testing.assert_close(result, expected)
    with pytest.raises(ValueError, match="provider"):
        model(x, provider="invalid")


@pytest.mark.skipif(not torch.cuda.is_available(), reason="CUDA required")
@pytest.mark.parametrize("tokens", [1, 8, 128])
def test_same_weights_full_mlp(tokens):
    torch.manual_seed(7)
    model = LlamaStyleMLP(128, 320).to(device="cuda", dtype=torch.float16).eval()
    x = torch.randn(tokens, 128, device="cuda", dtype=torch.float16)
    with torch.inference_mode():
        eager = model(x, provider="eager")
        fused = model(x, provider="triton")
    torch.testing.assert_close(fused, eager, rtol=5e-3, atol=5e-3)
