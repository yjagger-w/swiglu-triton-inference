# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis
# from tvm.script import relax as R

@I.ir_module
class Module:
    @T.prim_func(private=True, s_tir=True)
    def contract_silu(gate: T.Buffer((T.int64(1025),), "float16"), silu: T.Buffer((T.int64(1025),), "float16")):
        T.func_attr({"tirx.is_scheduled": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for i0_fused_0 in T.thread_binding(T.int64(2), thread="blockIdx.x"):
            for i0_fused_1 in T.thread_binding(T.int64(1024), thread="threadIdx.x"):
                with T.sblock("silu"):
                    v_i0 = T.axis.spatial(T.int64(1025), i0_fused_0 * T.int64(1024) + i0_fused_1)
                    T.where(i0_fused_0 * T.int64(1024) + i0_fused_1 < T.int64(1025))
                    T.reads(gate[v_i0])
                    T.writes(silu[v_i0])
                    silu[v_i0] = T.Cast("float16", T.call_pure_extern("float32", "__fdiv_rn", T.Cast("float32", gate[v_i0]), T.float32(1.0) + T.call_pure_extern("float32", "expf", T.Cast("float32", gate[v_i0]) * T.float32(-1.0))))

    @T.prim_func(private=True, s_tir=True)
    def multiply(lv: T.Buffer((T.int64(1025),), "float16"), up: T.Buffer((T.int64(1025),), "float16"), T_multiply: T.Buffer((T.int64(1025),), "float16")):
        T.func_attr({"tirx.is_scheduled": True, "tirx.noalias": True})
        # with T.sblock("root"):
        for ax0_fused_0 in T.thread_binding(T.int64(2), thread="blockIdx.x"):
            for ax0_fused_1 in T.thread_binding(T.int64(1024), thread="threadIdx.x"):
                with T.sblock("T_multiply"):
                    v_ax0 = T.axis.spatial(T.int64(1025), ax0_fused_0 * T.int64(1024) + ax0_fused_1)
                    T.where(ax0_fused_0 * T.int64(1024) + ax0_fused_1 < T.int64(1025))
                    T.reads(lv[v_ax0], up[v_ax0])
                    T.writes(T_multiply[v_ax0])
                    T_multiply[v_ax0] = lv[v_ax0] * up[v_ax0]

    @R.function
    def main(gate: R.Tensor((1025,), dtype="float16"), up: R.Tensor((1025,), dtype="float16")) -> R.Tensor((1025,), dtype="float16"):
        cls = Module
        with R.dataflow():
            lv = R.call_tir(cls.contract_silu, (gate,), out_sinfo=R.Tensor((1025,), dtype="float16"))
            lv1 = R.call_tir(cls.multiply, (lv, up), out_sinfo=R.Tensor((1025,), dtype="float16"))
            gv: R.Tensor((1025,), dtype="float16") = lv1
            R.output(gv)
        return gv