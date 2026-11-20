"""Controlled FP32 x86 schedules for the SwiGLU experiment."""

import tvm
from tvm import s_tir, tirx

VECTOR_WIDTH = 8
VECTORIZATION_CONFIG = "tirx.disable_vectorize"
LLVM_NO_AUTO_VECTOR = ("-vectorize-loops:bool=false", "-vectorize-slp:bool=false")


def strip_mine_fp32(mod):
    """Flatten and tile each dense pointwise kernel.

    Both controls compile this exact schedule. Lowering can either vectorize
    the eight adjacent lanes or serialize them. A separate loop covers the
    residual elements, including shapes smaller than one tile.
    """
    result = tvm.IRModule(mod.functions, attrs=mod.attrs)
    for gv, func in mod.functions.items():
        if not isinstance(func, tirx.PrimFunc):
            continue
        if any(buf.dtype != "float32" for buf in func.buffer_map.values()):
            raise ValueError("CPU experiment requires FP32 buffers")
        sch = s_tir.Schedule(func)
        block, = sch.get_child_blocks(sch.get_sblock("root"))
        loops = sch.get_loops(block)
        inner = sch.fuse(*loops) if len(loops) > 1 else loops[0]
        extent = int(sch.get(inner).extent)
        full, tail = divmod(extent, VECTOR_WIDTH)
        if not full:
            continue
        if tail:
            inner, _ = sch.loop_partition(inner, [full * VECTOR_WIDTH, None])
        _, lane = sch.split(inner, [None, VECTOR_WIDTH])
        sch.vectorize(lane)
        result[gv] = sch.mod["main"]
    return result


def compile_cpu(mod, target, *, vectorize=True):
    """Compile legalized Relax/TIR with controlled floating-point options."""
    target = tvm.target.Target(target)
    if target.kind.name != "llvm":
        raise ValueError("CPU experiment requires an LLVM target")
    if VECTORIZATION_CONFIG not in tvm.transform.PassContext.list_configs():
        raise RuntimeError(f"Pinned TVM option is unavailable: {VECTORIZATION_CONFIG}")
    with tvm.transform.PassContext(
        config={VECTORIZATION_CONFIG: not vectorize, "tirx.enable_fast_math": False}
    ):
        return tvm.relax.build(mod, target)
