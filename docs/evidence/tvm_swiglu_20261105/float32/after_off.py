# from tvm.script import ir as I
# from tvm.script import relax as R

@I.ir_module
class Module:
    @R.function
    def main(gate: R.Tensor((1025,), dtype="float32"), up: R.Tensor((1025,), dtype="float32")) -> R.Tensor((1025,), dtype="float32"):
        with R.dataflow():
            lv: R.Tensor((1025,), dtype="float32") = R.nn.silu(gate)
            lv1: R.Tensor((1025,), dtype="float32") = R.multiply(lv, up)
            gv: R.Tensor((1025,), dtype="float32") = lv1
            R.output(gv)
        return gv