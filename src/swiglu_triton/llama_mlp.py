"""Small LLaMA-style MLP harness with locally initialized weights.

This is one feed-forward layer, not an LLM checkpoint or generation server.
"""

import torch
from torch import nn

from .ops import swiglu_torch, swiglu_triton


class LlamaStyleMLP(nn.Module):
    def __init__(self, hidden_size: int, intermediate_size: int):
        super().__init__()
        if hidden_size <= 0 or intermediate_size <= 0:
            raise ValueError("hidden_size and intermediate_size must be positive")
        self.gate_proj = nn.Linear(hidden_size, intermediate_size, bias=False)
        self.up_proj = nn.Linear(hidden_size, intermediate_size, bias=False)
        self.down_proj = nn.Linear(intermediate_size, hidden_size, bias=False)

    def forward(self, x: torch.Tensor, *, provider: str = "eager") -> torch.Tensor:
        gate = self.gate_proj(x)
        up = self.up_proj(x)
        if provider == "eager":
            hidden = swiglu_torch(gate, up)
        elif provider == "triton":
            hidden = swiglu_triton(gate, up)
        else:
            raise ValueError("provider must be 'eager' or 'triton'")
        return self.down_proj(hidden)
