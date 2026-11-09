"""Static dense post-projection SwiGLU. No projection, broadcasting or strides.

The float16 cast is deliberately between SiLU and multiplication. CUDA uses
libdevice expf and __fdivide_rn rather than fast exp/reciprocal approximations.
"""
import tvm
from tvm import te, tirx as tir, s_tir
from .cuda import precise_cuda


def validate(shape, dtype):
    shape = tuple(shape)
    if not shape or any(type(x) is not int or x <= 0 for x in shape):
        raise ValueError("positive static nonempty shape required")
    if dtype not in ("float32", "float16"):
        raise ValueError("only float32 and float16 supported")
    return shape


def primfunc(shape, dtype="float32", cuda=False):
    shape = validate(shape, dtype)
    gate = te.placeholder(shape, dtype, name="gate")
    up = te.placeholder(shape, dtype, name="up")

    def compute(*i):
        rounded = silu_expr(gate[i], dtype, cuda).astype("float32")
        return (rounded * up[i].astype("float32")).astype(dtype)

    out = te.compute(shape, compute, name="swiglu")
    return te.create_prim_func([gate, up, out]).with_attr("tir.noalias", True)


def silu_expr(value, dtype, cuda=False):
    x = value.astype("float32")
    exp = tir.call_pure_extern("float32", "expf", -x) if cuda else tir.exp(-x)
    den = tir.const(1, "float32") + exp
    activation = tir.call_pure_extern("float32", "__fdiv_rn", x, den) if cuda else x / den
    return activation.astype(dtype)


def schedule(func, cuda=False, threads=128, vector=2):
    """Conservative baseline: 128 threads x 2 adjacent elements, guarded tail.

    Two adjacent lanes permit packed loads/stores when alignment allows it;
    TVM predicates split tails. Parameters are configurable, not T4-tuned.
    """
    sch = s_tir.Schedule(func)
    block = sch.get_sblock("swiglu")
    loops = sch.get_loops(block)
    flat = sch.fuse(*loops) if len(loops) > 1 else loops[0]
    if cuda:
        bx, tx, lane = sch.split(flat, factors=[None, threads, vector])
        sch.bind(bx, "blockIdx.x")
        sch.bind(tx, "threadIdx.x")
        sch.vectorize(lane)
    return sch.mod


def build_operator(shape, dtype="float32", target="llvm", threads=128, vector=2):
    target = tvm.target.Target(target)
    cuda = target.kind.name == "cuda"
    mod = schedule(primfunc(shape, dtype, cuda), cuda, threads, vector)
    with precise_cuda(cuda, arch=str(target.attrs.get("arch", "sm_75"))), tvm.transform.PassContext():
        lib = tvm.tirx.build(mod, target=target)
    return lib, mod
