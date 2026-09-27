"""Temporary forward-only MLP substitution for Hugging Face LLaMA models."""

from contextlib import contextmanager
from types import MethodType
from typing import Iterator

import torch

from .ops import swiglu_triton


def _triton_mlp_forward(mlp: torch.nn.Module, x: torch.Tensor) -> torch.Tensor:
    gate = mlp.gate_proj(x)
    up = mlp.up_proj(x)
    return mlp.down_proj(swiglu_triton(gate, up))


@contextmanager
def use_triton_llama_mlps(model: torch.nn.Module) -> Iterator[int]:
    """Patch every LLaMA MLP for inference and restore its forward on exit.

    The projections and weights remain on the original model. No changes are
    made to attention, KV cache, tokenization, or the state dict.
    """
    config = getattr(model, "config", None)
    if getattr(config, "model_type", None) != "llama":
        raise ValueError("expected a Hugging Face LLaMA model")
    if getattr(config, "hidden_act", None) != "silu":
        raise ValueError("only LLaMA models with SiLU/SwiGLU MLP are supported")
    backbone = getattr(model, "model", None)
    layers = getattr(backbone, "layers", None)
    if layers is None or not len(layers):
        raise ValueError("model.model.layers is required")

    mlps = [layer.mlp for layer in layers]
    if any(not all(hasattr(mlp, name) for name in ("gate_proj", "up_proj", "down_proj"))
           for mlp in mlps):
        raise ValueError("each MLP must expose gate_proj, up_proj and down_proj")
    saved = [(mlp, mlp.forward) for mlp in mlps]
    try:
        for mlp, _ in saved:
            mlp.forward = MethodType(_triton_mlp_forward, mlp)
        yield len(saved)
    finally:
        for mlp, forward in saved:
            mlp.forward = forward
