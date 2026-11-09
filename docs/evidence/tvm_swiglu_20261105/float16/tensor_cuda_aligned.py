# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis

@I.ir_module
class Module:
    @T.prim_func(s_tir=True)
    def main(gate: T.Buffer((1, 5632), "float16"), up: T.Buffer((1, 5632), "float16"), swiglu: T.Buffer((1, 5632), "float16")):
        T.func_attr({"tir.noalias": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for i0_i1_fused_0 in T.thread_binding(22, thread="blockIdx.x"):
            for i0_i1_fused_1 in T.thread_binding(128, thread="threadIdx.x"):
                for i0_i1_fused_2 in T.vectorized(2):
                    with T.sblock("swiglu"):
                        v_i0 = T.axis.spatial(1, 0)
                        v_i1 = T.axis.spatial(5632, i0_i1_fused_0 * 256 + i0_i1_fused_1 * 2 + i0_i1_fused_2)
                        T.reads(gate[v_i0, v_i1], up[v_i0, v_i1])
                        T.writes(swiglu[v_i0, v_i1])
                        swiglu[v_i0, v_i1] = T.Cast("float16", T.Cast("float32", T.Cast("float16", T.call_pure_extern("float32", "__fdiv_rn", T.Cast("float32", gate[v_i0, v_i1]), T.float32(1.0) + T.call_pure_extern("float32", "expf", T.Cast("float32", gate[v_i0, v_i1]) * T.float32(-1.0))))) * T.Cast("float32", up[v_i0, v_i1]))