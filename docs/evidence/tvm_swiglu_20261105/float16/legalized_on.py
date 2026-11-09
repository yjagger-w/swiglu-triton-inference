# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis
# from tvm.script import relax as R

@I.ir_module
class Module:
    @T.prim_func(private=True, s_tir=True)
    def custom_swiglu_float16_1025(gate: T.Buffer((1025,), "float16"), up: T.Buffer((1025,), "float16"), swiglu: T.Buffer((1025,), "float16")):
        T.func_attr({"tir.noalias": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for i0 in range(1025):
            with T.sblock("swiglu"):
                v_i0 = T.axis.spatial(1025, i0)
                T.reads(gate[v_i0], up[v_i0])
                T.writes(swiglu[v_i0])
                swiglu[v_i0] = T.Cast("float16", T.Cast("float32", T.Cast("float16", T.Cast("float32", gate[v_i0]) / (T.float32(1.0) + T.exp(T.Cast("float32", gate[v_i0]) * T.float32(-1.0))))) * T.Cast("float32", up[v_i0]))

    @R.function
    def main(gate: R.Tensor((1025,), dtype="float16"), up: R.Tensor((1025,), dtype="float16")) -> R.Tensor((1025,), dtype="float16"):
        cls = Module
        with R.dataflow():
            lv1 = R.call_tir(cls.custom_swiglu_float16_1025, (gate, up), out_sinfo=R.Tensor((1025,), dtype="float16"))
            gv: R.Tensor((1025,), dtype="float16") = lv1
            R.output(gv)
        return gv