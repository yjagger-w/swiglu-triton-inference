# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis
# from tvm.script import relax as R

@I.ir_module
class Module:
    @T.prim_func(private=True, s_tir=True)
    def custom_swiglu_float32_1x5632(gate: T.Buffer((1, 5632), "float32"), up: T.Buffer((1, 5632), "float32"), swiglu: T.Buffer((1, 5632), "float32")):
        T.func_attr({"tir.noalias": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for i0_i1_fused_0 in range(704):
            for i0_i1_fused_1 in T.vectorized(8):
                with T.sblock("swiglu"):
                    v_i0 = T.axis.spatial(1, 0)
                    v_i1 = T.axis.spatial(5632, i0_i1_fused_0 * 8 + i0_i1_fused_1)
                    T.reads(gate[v_i0, v_i1], up[v_i0, v_i1])
                    T.writes(swiglu[v_i0, v_i1])
                    swiglu[v_i0, v_i1] = gate[v_i0, v_i1] / (T.float32(1.0) + T.exp(gate[v_i0, v_i1] * T.float32(-1.0))) * up[v_i0, v_i1]

    @R.function
    def main(gate: R.Tensor((1, 5632), dtype="float32"), up: R.Tensor((1, 5632), dtype="float32")) -> R.Tensor((1, 5632), dtype="float32"):
        cls = Module
        with R.dataflow():
            lv1 = R.call_tir(cls.custom_swiglu_float32_1x5632, (gate, up), out_sinfo=R.Tensor((1, 5632), dtype="float32"))
            gv: R.Tensor((1, 5632), dtype="float32") = lv1
            R.output(gv)
        return gv
