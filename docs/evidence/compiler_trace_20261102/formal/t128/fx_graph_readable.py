class <lambda>(torch.nn.Module):
    def forward(self, arg0_1: "f16[128, 5632]", arg1_1: "f16[128, 5632]"):
         # File: /root/autodl-tmp/swiglu-triton-inference/src/swiglu_triton/ops.py:55 in swiglu_torch, code: return F.silu(gate) * up
        convert_element_type: "f32[128, 5632]" = torch.ops.prims.convert_element_type.default(arg0_1, torch.float32);  arg0_1 = None
        sigmoid: "f32[128, 5632]" = torch.ops.aten.sigmoid.default(convert_element_type)
        mul: "f32[128, 5632]" = torch.ops.aten.mul.Tensor(convert_element_type, sigmoid);  convert_element_type = sigmoid = None
        convert_element_type_1: "f16[128, 5632]" = torch.ops.prims.convert_element_type.default(mul, torch.float16);  mul = None
        mul_1: "f16[128, 5632]" = torch.ops.aten.mul.Tensor(convert_element_type_1, arg1_1);  convert_element_type_1 = arg1_1 = None
        return (mul_1,)
        