import pytest

torch = pytest.importorskip("torch")
pytest.importorskip("triton")

from swiglu_triton import hf_llama
from swiglu_triton.llama_mlp import LlamaStyleMLP
from swiglu_triton.ops import swiglu_torch


def test_patch_changes_only_mlp_forward_and_restores_on_cpu(monkeypatch):
    class DummyModel(torch.nn.Module):
        def __init__(self):
            super().__init__()
            self.config = type("Config", (), {"model_type": "llama", "hidden_act": "silu"})()
            self.model = torch.nn.Module()
            self.model.layers = torch.nn.ModuleList([torch.nn.Module() for _ in range(2)])
            for layer in self.model.layers:
                layer.mlp = LlamaStyleMLP(8, 16)

    model = DummyModel().eval()
    x = torch.randn(2, 8)
    originals = [layer.mlp.forward for layer in model.model.layers]
    expected = [layer.mlp(x, provider="eager") for layer in model.model.layers]
    state_keys = set(model.state_dict())
    monkeypatch.setattr(hf_llama, "swiglu_triton", swiglu_torch)
    with hf_llama.use_triton_llama_mlps(model) as count:
        assert count == 2
        for layer, reference in zip(model.model.layers, expected):
            torch.testing.assert_close(layer.mlp(x), reference)
    assert set(model.state_dict()) == state_keys
    assert all(layer.mlp.forward == original for layer, original in zip(model.model.layers, originals))


def test_patch_rejects_wrong_architecture():
    model = torch.nn.Module()
    model.config = type("Config", (), {"model_type": "gpt2", "hidden_act": "gelu"})()
    with pytest.raises(ValueError, match="LLaMA"):
        with hf_llama.use_triton_llama_mlps(model):
            pass
