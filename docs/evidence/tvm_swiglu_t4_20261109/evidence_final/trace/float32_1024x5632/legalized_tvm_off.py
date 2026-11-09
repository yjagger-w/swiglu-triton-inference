# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis
# from tvm.script import relax as R

@I.ir_module
class Module:
    @T.prim_func(private=True, s_tir=True)
    def contract_silu(gate: T.Buffer((T.int64(1024), T.int64(5632)), "float32"), silu: T.Buffer((T.int64(1024), T.int64(5632)), "float32")):
        T.func_attr({"tirx.is_scheduled": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for i0_i1_fused_1 in T.thread_binding(T.int64(256), thread="blockIdx.x"):
            for i0_i1_fused_2 in T.thread_binding(T.int64(1024), thread="threadIdx.x"):
                for i0_i1_fused_0 in range(T.int64(22)):
                    with T.sblock("silu"):
                        v_i0 = T.axis.spatial(T.int64(1024), (i0_i1_fused_0 * T.int64(262144) + i0_i1_fused_1 * T.int64(1024) + i0_i1_fused_2) // T.int64(5632))
                        v_i1 = T.axis.spatial(T.int64(5632), (i0_i1_fused_0 * T.int64(262144) + i0_i1_fused_1 * T.int64(1024) + i0_i1_fused_2) % T.int64(5632))
                        T.reads(gate[v_i0, v_i1])
                        T.writes(silu[v_i0, v_i1])
                        silu[v_i0, v_i1] = T.call_pure_extern("float32", "__fdiv_rn", gate[v_i0, v_i1], T.float32(1.0) + T.call_pure_extern("float32", "expf", gate[v_i0, v_i1] * T.float32(-1.0)))

    @T.prim_func(private=True, s_tir=True)
    def multiply(lv: T.Buffer((T.int64(1024), T.int64(5632)), "float32"), up: T.Buffer((T.int64(1024), T.int64(5632)), "float32"), T_multiply: T.Buffer((T.int64(1024), T.int64(5632)), "float32")):
        T.func_attr({"tirx.is_scheduled": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for ax0_ax1_fused_1 in T.thread_binding(T.int64(256), thread="blockIdx.x"):
            for ax0_ax1_fused_2 in T.thread_binding(T.int64(1024), thread="threadIdx.x"):
                for ax0_ax1_fused_0 in range(T.int64(22)):
                    with T.sblock("T_multiply"):
                        v_ax0 = T.axis.spatial(T.int64(1024), (ax0_ax1_fused_0 * T.int64(262144) + ax0_ax1_fused_1 * T.int64(1024) + ax0_ax1_fused_2) // T.int64(5632))
                        v_ax1 = T.axis.spatial(T.int64(5632), (ax0_ax1_fused_0 * T.int64(262144) + ax0_ax1_fused_1 * T.int64(1024) + ax0_ax1_fused_2) % T.int64(5632))
                        T.reads(lv[v_ax0, v_ax1], up[v_ax0, v_ax1])
                        T.writes(T_multiply[v_ax0, v_ax1])
                        T_multiply[v_ax0, v_ax1] = lv[v_ax0, v_ax1] * up[v_ax0, v_ax1]

    @R.function
    def main(gate: R.Tensor((1024, 5632), dtype="float32"), up: R.Tensor((1024, 5632), dtype="float32")) -> R.Tensor((1024, 5632), dtype="float32"):
        cls = Module
        with R.dataflow():
            lv = R.call_tir(cls.contract_silu, (gate,), out_sinfo=R.Tensor((1024, 5632), dtype="float32"))
            lv1 = R.call_tir(cls.multiply, (lv, up), out_sinfo=R.Tensor((1024, 5632), dtype="float32"))
            gv: R.Tensor((1024, 5632), dtype="float32") = lv1
            R.output(gv)
        return gv