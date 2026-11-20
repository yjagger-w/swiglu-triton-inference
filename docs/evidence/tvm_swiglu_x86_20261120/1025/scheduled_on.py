# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis
# from tvm.script import relax as R

@I.ir_module
class Module:
    @T.prim_func(private=True, s_tir=True)
    def custom_swiglu_float32_1025(gate: T.Buffer((1025,), "float32"), up: T.Buffer((1025,), "float32"), swiglu: T.Buffer((1025,), "float32")):
        T.func_attr({"tir.noalias": True, "tirx.noalias": True})
        with T.sblock("root"):
            T.reads()
            T.writes()
            with T.sblock("swiglu_i0_common"):
                T.reads()
                T.writes()
                with T.sblock("swiglu_i00_partition"):
                    T.reads()
                    T.writes()
                    for i00_0 in range(128):
                        for i00_1 in T.vectorized(8):
                            with T.sblock("swiglu_i00"):
                                v_i0 = T.axis.spatial(1024, i00_0 * 8 + i00_1)
                                T.reads(gate[0:1024], up[0:1024])
                                T.writes(swiglu[0:1024])
                                swiglu[v_i0] = gate[v_i0] / (T.float32(1.0) + T.exp(gate[v_i0] * T.float32(-1.0))) * up[v_i0]
                with T.sblock("swiglu_i01_partition"):
                    T.reads()
                    T.writes()
                    for i01 in range(1024, 1025):
                        with T.sblock("swiglu_i01"):
                            v_i0 = T.axis.spatial((1024, 1025), i01)
                            T.reads(gate[1024], up[1024])
                            T.writes(swiglu[1024])
                            swiglu[v_i0] = gate[v_i0] / (T.float32(1.0) + T.exp(gate[v_i0] * T.float32(-1.0))) * up[v_i0]

    @R.function
    def main(gate: R.Tensor((1025,), dtype="float32"), up: R.Tensor((1025,), dtype="float32")) -> R.Tensor((1025,), dtype="float32"):
        cls = Module
        with R.dataflow():
            lv1 = R.call_tir(cls.custom_swiglu_float32_1025, (gate, up), out_sinfo=R.Tensor((1025,), dtype="float32"))
            gv: R.Tensor((1025,), dtype="float32") = lv1
            R.output(gv)
        return gv
