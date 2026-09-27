"""Fused SwiGLU activation after the gate and up linear projections.

This module implements y = silu(gate) * up. It does not compute either linear
projection or the subsequent down projection. Forward/inference only.
"""

import torch
import torch.nn.functional as F
import triton
import triton.language as tl


@triton.jit
def _swiglu_kernel(gate_ptr, up_ptr, out_ptr, n: tl.constexpr, block: tl.constexpr):
    offsets = tl.program_id(0) * block + tl.arange(0, block)
    mask = offsets < n
    gate = tl.load(gate_ptr + offsets, mask=mask, other=0)
    up = tl.load(up_ptr + offsets, mask=mask, other=0)
    gate_f32 = gate.to(tl.float32)
    # Match the reference's activation rounding before the subsequent product.
    activated = (gate_f32 * tl.sigmoid(gate_f32)).to(gate.dtype).to(tl.float32)
    result = activated * up.to(tl.float32)
    tl.store(out_ptr + offsets, result, mask=mask)


def _validate(gate: torch.Tensor, up: torch.Tensor) -> None:
    if not isinstance(gate, torch.Tensor) or not isinstance(up, torch.Tensor):
        raise TypeError("gate and up must be torch tensors")
    if gate.shape != up.shape or gate.numel() == 0:
        raise ValueError("gate and up must have the same nonempty shape")
    if gate.device != up.device or gate.dtype != up.dtype:
        raise ValueError("gate and up must have the same device and dtype")
    if gate.dtype not in (torch.float16, torch.bfloat16, torch.float32):
        raise TypeError("supported dtypes: float16, bfloat16, float32")


def swiglu_torch(gate: torch.Tensor, up: torch.Tensor) -> torch.Tensor:
    """PyTorch eager reference, available on CPU or CUDA."""
    _validate(gate, up)
    return F.silu(gate) * up


def swiglu_triton(
    gate: torch.Tensor, up: torch.Tensor, *, out: torch.Tensor | None = None
) -> torch.Tensor:
    """Forward-only fused operator on contiguous CUDA tensors.

Pass ``out`` only for a kernel-only benchmark or when the caller owns output
storage. The default allocates an output just like the PyTorch reference.
"""
    _validate(gate, up)
    if gate.device.type != "cuda":
        raise ValueError("Triton implementation requires CUDA tensors")
    if not gate.is_contiguous() or not up.is_contiguous():
        raise ValueError("Triton implementation requires contiguous inputs")
    if out is None:
        out = torch.empty_like(gate)
    elif (
        out.shape != gate.shape
        or out.dtype != gate.dtype
        or out.device != gate.device
        or not out.is_contiguous()
    ):
        raise ValueError("out must be contiguous with matching shape, dtype, and device")
    if out.data_ptr() in (gate.data_ptr(), up.data_ptr()):
        raise ValueError("in-place output is not supported")
    block = 1024
    _swiglu_kernel[(triton.cdiv(gate.numel(), block),)](
        gate, up, out, gate.numel(), block
    )
    return out
