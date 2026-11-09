# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis

@I.ir_module
class Module:
    @T.prim_func(s_tir=True)
    def main(gate: T.Buffer((1025,), "float16"), up: T.Buffer((1025,), "float16"), swiglu: T.Buffer((1025,), "float16")):
        T.func_attr({"tir.noalias": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for i0 in range(1025):
            with T.sblock("swiglu"):
                v_i0 = T.axis.spatial(1025, i0)
                T.reads(gate[v_i0], up[v_i0])
                T.writes(swiglu[v_i0])
                swiglu[v_i0] = T.Cast("float16", T.Cast("float32", T.Cast("float16", T.Cast("float32", gate[v_i0]) / (T.float32(1.0) + T.exp(T.Cast("float32", gate[v_i0]) * T.float32(-1.0))))) * T.Cast("float32", up[v_i0]))