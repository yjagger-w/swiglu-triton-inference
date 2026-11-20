"""Explicit, optional Relax rewrite, run BEFORE LegalizeOps/decomposition.

Dense input layout is a caller contract (Relax TensorStructInfo has no strides).
Only direct parameter inputs are accepted; views/permutes are rejected.
No TVM built-in FuseOps is used by this pass.
"""
from collections import Counter
import tvm
from tvm import relax
from .operator import primfunc, schedule, silu_expr
from .cuda import precise_cuda, capture_cuda_source


def opname(expr, name):
    return isinstance(expr, relax.Call) and isinstance(expr.op, tvm.ir.Op) and expr.op.name == name


def static_info(expr):
    info = expr.struct_info
    if not isinstance(info, relax.TensorStructInfo) or not isinstance(info.shape, relax.ShapeExpr):
        return None
    dims = info.shape.values
    if not dims or any(not isinstance(x, tvm.tirx.IntImm) or int(x) <= 0 for x in dims):
        return None
    return tuple(int(x) for x in dims), info.dtype


def FuseSwiGLU(enabled=True, enable_fp16=False, cuda=False, dense_inputs=False):
    """Return an independently callable module Pass.

    Opt-in dense_inputs attests to contiguous runtime parameter tensors.
    FP16 is a separate opt-in; callers must run the bitwise T4 acceptance gate.
    """
    @tvm.transform.module_pass(opt_level=0, name="CustomFuseSwiGLU")
    def transform(mod, ctx):
        if not enabled or not dense_inputs:
            return mod
        result = tvm.IRModule(mod.functions, attrs=mod.attrs)
        for gv, func in list(mod.functions.items()):
            if not isinstance(func, relax.Function) or not isinstance(func.body, relax.SeqExpr):
                continue
            bindings = [b for block in func.body.blocks for b in block.bindings]
            defs = {b.var: b.value for b in bindings if isinstance(b, relax.VarBinding)}
            uses = Counter()

            def count(expr):
                # Count operand occurrences, including duplicate operands and tuple outputs.
                if isinstance(expr, relax.Var):
                    uses[expr] += 1
                elif isinstance(expr, relax.Call):
                    for arg in expr.args:
                        count(arg)
                elif isinstance(expr, relax.Tuple):
                    for field in expr.fields:
                        count(field)
                elif isinstance(expr, relax.TupleGetItem):
                    count(expr.tuple_value)
                elif isinstance(expr, relax.SeqExpr):
                    for block in expr.blocks:
                        for b in block.bindings:
                            count(b.value)
                    count(expr.body)
                elif isinstance(expr, relax.If):
                    count(expr.cond)
                    count(expr.true_branch)
                    count(expr.false_branch)
                elif isinstance(expr, relax.Function):
                    count(expr.body)
            count(func.body)
            replacements, removed = {}, set()
            for b in bindings:
                if not isinstance(b, relax.VarBinding) or not opname(b.value, "relax.multiply"):
                    continue
                for activation, up in (b.value.args, list(reversed(b.value.args))):
                    if not isinstance(activation, relax.Var) or uses[activation] != 1:
                        continue
                    silu = defs.get(activation)
                    if not opname(silu, "relax.nn.silu"):
                        continue
                    gate = silu.args[0]
                    # Restrict layout and alias analysis to direct dense parameters.
                    if gate not in func.params or up not in func.params:
                        continue
                    info = static_info(gate)
                    if info is None or info != static_info(up) or info != static_info(activation):
                        continue
                    shape, dtype = info
                    if dtype not in (("float32", "float16") if enable_fp16 else ("float32",)):
                        continue
                    name = "custom_swiglu_" + dtype + "_" + "x".join(map(str, shape))
                    try:
                        kernel_gv = result.get_global_var(name)
                    except ValueError:
                        kernel = schedule(primfunc(shape, dtype, cuda), cuda)["main"]
                        builder = relax.BlockBuilder(result)
                        kernel_gv = builder.add_func(kernel.without_attr("global_symbol"), name)
                        result = builder.get()
                    replacements[b.var] = relax.call_tir(
                        kernel_gv, (gate, up), out_sinfo=b.var.struct_info)
                    removed.add(activation)
                    break
            if replacements:
                blocks = []
                for block in func.body.blocks:
                    new = [relax.VarBinding(b.var, replacements.get(b.var, b.value))
                           if isinstance(b, relax.VarBinding) else b
                           for b in block.bindings if b.var not in removed]
                    blocks.append(type(block)(new))
                result[gv] = relax.Function(func.params, relax.SeqExpr(blocks, func.body.body),
                                           func.ret_struct_info, func.is_pure, func.attrs)
        return result
    return transform


def example(shape=(127,), dtype="float32", kind="target"):
    """Build the actual pinned-version high-level input IR (before LegalizeOps)."""
    gate = relax.Var("gate", relax.TensorStructInfo(shape, dtype))
    up_shape = (1,) if kind == "broadcast" else shape
    up = relax.Var("up", relax.TensorStructInfo(up_shape, dtype))
    bb = relax.BlockBuilder()
    with bb.function("main", [gate, up]):
        with bb.dataflow():
            a = bb.emit(relax.op.nn.relu(gate) if kind == "other" else relax.op.nn.silu(gate))
            y = bb.emit(relax.op.multiply(a, up))
            out = bb.emit_output(relax.Tuple([y, a]) if kind == "multi" else y)
        bb.emit_func_output(out)
    return bb.get()


def legalize_swiglu(mod, cuda=False):
    """Legalize both controls with the same SiLU arithmetic."""
    # Built-in legalization is separate; deliberately do not run FuseOps/FuseTIR.
    def legalize_silu(bb, call):
        # The pinned built-in legalizer uses x * sigmoid(x), including half
        # intermediates. Override BOTH controls to hold the numeric contract fixed.
        def compute(x):
            return tvm.te.compute(x.shape, lambda *i: silu_expr(x[i], x.dtype, cuda), name="silu")
        return bb.call_te(compute, call.args[0], primfunc_name_hint="contract_silu")
    return relax.transform.LegalizeOps({"relax.nn.silu": legalize_silu})(mod)


def build_relax(mod, target="llvm", enabled=True, fp16=False, source_only=None):
    target = tvm.target.Target(target)
    cuda = target.kind.name == "cuda"
    mod = FuseSwiGLU(enabled, fp16, cuda, dense_inputs=True)(mod)
    lowered = legalize_swiglu(mod, cuda)
    if cuda:
        with tvm.target.Target(target):
            lowered = tvm.s_tir.transform.DefaultGPUSchedule()(lowered)
    if source_only is not None:
        if not cuda:
            raise ValueError("source_only requires a CUDA target")
        with capture_cuda_source(source_only):
            relax.build(lowered, target=target)
        return None, mod, lowered
    with precise_cuda(cuda, arch=str(target.attrs.get("arch", "sm_75"))):
        exe = relax.build(lowered, target=target)
    return exe, mod, lowered
