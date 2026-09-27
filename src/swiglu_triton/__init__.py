"""Forward-only post-projection SwiGLU reference and Triton implementation."""

from .ops import swiglu_torch, swiglu_triton

__all__ = ["swiglu_torch", "swiglu_triton"]
