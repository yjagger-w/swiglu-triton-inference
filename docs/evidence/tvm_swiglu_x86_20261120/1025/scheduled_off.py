# from tvm.script import ir as I
# from tvm.script import tirx as T
# from tvm.tirx.layout import Axis
# from tvm.script import relax as R

@I.ir_module
class Module:
    @T.prim_func(private=True, s_tir=True)
    def contract_silu(gate: T.Buffer((T.int64(1025),), "float32"), silu: T.Buffer((T.int64(1025),), "float32")):
        T.func_attr({"tirx.noalias": True})
        with T.sblock("root"):
            T.reads()
            T.writes()
            with T.sblock("silu_i0_common"):
                T.reads()
                T.writes()
                with T.sblock("silu_i00_partition"):
                    T.reads()
                    T.writes()
                    for i00_0 in range(T.int64(128)):
                        for i00_1 in T.vectorized(T.int64(8)):
                            with T.sblock("silu_i00"):
                                v_i0 = T.axis.spatial(T.int64(1024), i00_0 * T.int64(8) + i00_1)
                                T.reads(gate[T.int64(0):T.int64(1024)])
                                T.writes(silu[T.int64(0):T.int64(1024)])
                                silu[v_i0] = gate[v_i0] / (T.float32(1.0) + T.exp(gate[v_i0] * T.float32(-1.0)))
                with T.sblock("silu_i01_partition"):
                    T.reads()
                    T.writes()
                    for i01 in range(T.int64(1024), T.int64(1025)):
                        with T.sblock("silu_i01"):
                            v_i0 = T.axis.spatial((T.int64(1024), T.int64(1025)), i01)
                            T.reads(gate[T.int64(1024)])
                            T.writes(silu[T.int64(1024)])
                            silu[v_i0] = gate[v_i0] / (T.float32(1.0) + T.exp(gate[v_i0] * T.float32(-1.0)))

    @T.prim_func(private=True, s_tir=True)
    def multiply(lv: T.Buffer((T.int64(1025),), "float32"), up: T.Buffer((T.int64(1025),), "float32"), T_multiply: T.Buffer((T.int64(1025),), "float32")):
        T.func_attr({"tirx.noalias": True})
        with T.sblock("root"):
            T.reads()
            T.writes()
            with T.sblock("T_multiply_ax0_common"):
                T.reads()
                T.writes()
                with T.sblock("T_multiply_ax00_partition"):
                    T.reads()
                    T.writes()
                    for ax00_0 in range(T.int64(128)):
                        for ax00_1 in T.vectorized(T.int64(8)):
                            with T.sblock("T_multiply_ax00"):
                                v_ax0 = T.axis.spatial(T.int64(1024), ax00_0 * T.int64(8) + ax00_1)
                                T.reads(lv[T.int64(0):T.int64(1024)], up[T.int64(0):T.int64(1024)])
                                T.writes(T_multiply[T.int64(0):T.int64(1024)])
                                T_multiply[v_ax0] = lv[v_ax0] * up[v_ax0]
                with T.sblock("T_multiply_ax01_partition"):
                    T.reads()
                    T.writes()
                    for ax01 in range(T.int64(1024), T.int64(1025)):
                        with T.sblock("T_multiply_ax01"):
                            v_ax0 = T.axis.spatial((T.int64(1024), T.int64(1025)), ax01)
                            T.reads(lv[T.int64(1024)], up[T.int64(1024)])
                            T.writes(T_multiply[T.int64(1024)])
                            T_multiply[v_ax0] = lv[v_ax0] * up[v_ax0]

    @R.function
    def main(gate: R.Tensor((1025,), dtype="float32"), up: R.Tensor((1025,), dtype="float32")) -> R.Tensor((1025,), dtype="float32"):
        cls = Module
        with R.dataflow():
            lv = R.call_tir(cls.contract_silu, (gate,), out_sinfo=R.Tensor((1025,), dtype="float32"))
            lv1 = R.call_tir(cls.multiply, (lv, up), out_sinfo=R.Tensor((1025,), dtype="float32"))
            gv: R.Tensor((1025,), dtype="float32") = lv1
            R.output(gv)
        return gv
