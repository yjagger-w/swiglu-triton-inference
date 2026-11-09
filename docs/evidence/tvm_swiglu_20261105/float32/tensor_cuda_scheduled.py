# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis

@I.ir_module
class Module:
    @T.prim_func(s_tir=True)
    def main(gate: T.Buffer((1025,), "float32"), up: T.Buffer((1025,), "float32"), swiglu: T.Buffer((1025,), "float32")):
        T.func_attr({"tir.noalias": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for i0_0 in T.thread_binding(5, thread="blockIdx.x"):
            for i0_1 in T.thread_binding(128, thread="threadIdx.x"):
                for i0_2 in T.vectorized(2):
                    with T.sblock("swiglu"):
                        v_i0 = T.axis.spatial(1025, i0_0 * 256 + i0_1 * 2 + i0_2)
                        T.where((i0_0 * 128 + i0_1) * 2 + i0_2 < 1025)
                        T.reads(gate[v_i0], up[v_i0])
                        T.writes(swiglu[v_i0])
                        swiglu[v_i0] = T.call_pure_extern("float32", "__fdiv_rn", gate[v_i0], T.float32(1.0) + T.call_pure_extern("float32", "expf", gate[v_i0] * T.float32(-1.0))) * up[v_i0]