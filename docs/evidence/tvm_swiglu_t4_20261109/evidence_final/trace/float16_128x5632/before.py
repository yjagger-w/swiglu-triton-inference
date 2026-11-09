# from tvm.script import ir as I
# from tvm.script import relax as R

@I.ir_module
class Module:
    @R.function
    def main(gate: R.Tensor((128, 5632), dtype="float16"), up: R.Tensor((128, 5632), dtype="float16")) -> R.Tensor((128, 5632), dtype="float16"):
        with R.dataflow():
            lv: R.Tensor((128, 5632), dtype="float16") = R.nn.silu(gate)
            lv1: R.Tensor((128, 5632), dtype="float16") = R.multiply(lv, up)
            gv: R.Tensor((128, 5632), dtype="float16") = lv1
            R.output(gv)
        return gv