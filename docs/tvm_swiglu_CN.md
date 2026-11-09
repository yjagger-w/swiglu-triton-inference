# TVM SwiGLU 与自定义 Relax Pass：实现及验收边界

本地验证于 2026-11-05 完成，T4 验收于 2026-11-09 完成。分支 `feature/tvm-swiglu-fusion`，
基线提交 `5a829c9`。
工作区原有未跟踪文档 `compiler_trace_local_acceptance_20261102_CN.md` 已保留。
在工作区及其祖先检查范围未找到 AGENTS.md。未 commit、push 或合并。

## 状态

| 项目 | 状态 | 证据/限制 |
|---|---|---|
| 静态连续 FP32/FP16 张量 IR、CPU 执行 | 已实现、已运行 | tests/test_tvm_swiglu.py |
| 自定义 Relax Pass、拒绝条件及幂等 | 已实现、已运行 | 同上，before/after IR |
| FP16 中间舍入 | CPU 回归已运行 | half → float → SiLU → half → float → multiply → half |
| CUDA 调度及算子/Relax 开关实际 CUDA 源码生成 | 已实现、已运行源码生成 | source_only.cu；不代表编译成功 |
| CUDA runtime 与设备识别 | 已运行 | T4 上重编译 CUDA 12.4 runtime 后 `tvm.cuda().exist` 为真 |
| CUDA/PTX 编译、GPU 尾部执行 | 已通过 | 编译回调显式传递目标架构，完成 T4 非对齐尺寸测试 |
| T4 五方正确性/位级回归及性能 | 已通过 | 84 通过、5 跳过。完成 8 组、5 方计时和 CUPTI 追踪 |

最终结果、各轮诊断和可重查的原始数据见 [远端验收证据](evidence/tvm_swiglu_t4_20261109/README.md)。
本地系统 Python 3.13.5 没有 torch、Triton、TVM、numpy、pytest；新增依赖均安装于
`.venv-tvm`，原 Python 环境未修改。完整 CPU 测试输出见 evidence 目录。

## 固定环境与入口

TVM 固定 `apache-tvm==0.25.0.post1`，`apache-tvm-ffi==0.1.12`，其余直接依赖
见 `requirements-tvm.txt`，完整本地锁定快照见 `pip-freeze.txt`。
尝试 0.22.0 时 PyPI 无本机兼容 wheel；尝试较新 FFI 时 Windows DLL 导入
WinError 127；固定 0.1.12 后 CPU LLVM 编译可用。该经验不证明其他平台组合可用。
使用已安装版本内的 Python 源码确定 API：此版本使用 `tirx`/`s_tir.Schedule`、
`get_sblock` 和 JSON dict CUDA target，不支持旧 CLI target 字符串。
[TVM 发布包](https://pypi.org/project/apache-tvm/0.25.0.post1/)；
[上游源码](https://github.com/apache/tvm)。

Windows CPU 命令见根 README。Linux CPU：

```bash
python3.12 -m venv .venv-tvm
source .venv-tvm/bin/activate
python -m pip install -r requirements-tvm.txt
export PYTHONPATH="$PWD/src"
export OMP_NUM_THREADS=1
python -m pytest -q
python benchmarks/tvm_swiglu.py cpu --output results/tvm_cpu
```

无需 `pip install -e .`，因此 CPU 验证不引入主项目的 torch/Triton 必选依赖。
新包独立于 `swiglu_triton.__init__`。未安装 TVM 时该测试模块 importorskip；
原有测试不需要为 TVM 改动。

## 数值与支持策略

计算仅限投影后 `out = silu(gate) * up`。输入相同 shape/dtype、非空静态 shape、
连续 dense；不实现投影、反向、Attention、GEMM、MoE、MLIR 或 Transformer。
CPU SiLU 使用 FP32 `x / (1 + exp(-x))`。CUDA 显式使用 FP32 `expf` 和 `__fdiv_rn`。
FP16 SiLU 计算后必须先 cast half，再扩展 float 与 up 相乘，最后 cast half。

TVM 0.25 默认 CUDA 编译 helper 无条件加入 `--use_fast_math`；只写 expf 不足以
保持原项目契约。`cuda.py` 在 build 作用域替换编译回调，直接调用 nvcc 生成 PTX，
明确 `--fmad=false --ftz=false --prec-div=true --prec-sqrt=true`，退出后恢复回调。
回调的作用域测试覆盖异常恢复；同一进程内其他线程同时编译 TVM 不在支持范围。
本地仅通过真实 TVM codegen 回调截取 CUDA 源码，在调用 nvcc 前有意停止；
从未伪造 PTX、cubin 或成功的 GPU 编译结果。

数值容差复用 `tests/test_ops.py`：FP32 `rtol=atol=3e-5`、FP16 `3e-3`。
这比历史编译 benchmark 的 0.01 更严格，没有为通过 TVM 放宽阈值。
CPU 以 numpy FP32 算术加明确 half 舍入检验阈值；这不代替 CUDA eager。
FP16 CUDA 测试另检查已有 -2.724609375 边界、63,488 个有限 gate 配 unit up
和 seeded permutation up 的位型完全一致，包括有限输入导致的 overflow 和 signed zero。
这仍不覆盖全部 gate/up 对。T4 benchmark 要求 TVM on/off FP16 位级相等，否则保留
诊断并退出，不计时。torch.compile 只验原算子容差并另报位型差异；融合可能改变
其中间舍入，不能把它标成位级等价实现。

NaN/Inf 策略：支持 IEEE 结果分类（-Inf gate → NaN，+Inf gate 与有限非零 up
按通常乘法传播），比较 equal_nan；不承诺 NaN payload/sign、非有限场景的零符号。
CPU 与 T4 均通过 NaN/Inf 分类测试。有限输入 FP16 位级测试保留 signed zero。

## Pass 与调度

```python
from swiglu_tvm.fusion import FuseSwiGLU, example, build_relax
mod = example((128, 5632), "float32")
after = FuseSwiGLU(dense_inputs=True)(mod)
unchanged = FuseSwiGLU(enabled=False)(mod)
# FP16 通过 enable_fp16=True 单独开启。
exe, high_level, legalized = build_relax(mod, target="llvm", enabled=True)
```

Pass 自己统计变量 operand 使用次数（包括 tuple 输出、分支和嵌套函数），只替换
`relax.multiply(relax.nn.silu(gate), up)`，也支持外层乘法交换参数。
要求 SiLU 绑定变量恰好一个消费者、gate/up 为函数直接参数、静态正整数 shape 相等、
dtype FP32，或显式扩展 FP16。Relax TensorStructInfo 不含 stride，故默认
`dense_inputs=False` 完全不改写；应用方需保证运行时参数连续，非参数 view 输入拒绝。
不支持 broadcasting、动态/未知 shape、空/标量 shape、BF16/FP64、SiLU 多消费者。
不匹配 relu、已经分解的 gate*sigmoid(gate)、或已经 LegalizeOps 的 call_tir。
必须在 SiLU 分解与 LegalizeOps **之前**调用。本版本原生有 `relax.nn.silu`，
因此无需扩大到精度约束不同的分解模式。

自定义 Pass 仅负责匹配、合法性和替换为命名 PrimFunc `call_tir`；`operator.py`
独立负责 TensorIR 和 schedule；`LegalizeOps` 负责余下算子的 TVM 内置合法化。
没有把内置 FuseOps/FuseTIR 称为本项目的 Pass，也没有显式调用这些融合 Pass。
Pass 关闭时使用同一 SiLU 数学表达式的自定义合法化（不是融合），保留两个调用。
否则固定版本内置的 x*sigmoid(x) 路径会混入 FP16 语义差异。
这是受控对照，不是 TVM 所有内置优化都开启的性能上限。

CPU 实际最终 VM：off 为 contract_silu、multiply 两次张量调用、两次张量分配；
on 为 custom_swiglu 一次张量调用、一次张量分配。消除了 SiLU 中间全量张量存取。
T4 的最终 VM 在两种模式下均显示一次输出分配、一次张量调用。off 的
`fused_contract_silu_multiply` 宿主包装函数通过 `TVMBackendAllocWorkspace`
为 SiLU 中间结果申请工作区，再启动两个 GPU kernel。on 直接启动一个 kernel，
宿主包装函数省去这块中间工作区。全部 8 组的 PTX 入口数和 CUPTI 实际启动次数
均为 off 两个、on 一个。详见 [GPU 证据](evidence/tvm_swiglu_t4_20261109/README.md#融合证据)。

GPU schedule 将所有维度展平成一个循环，split 为 ceil(N/256) blocks、128 threads、
2 lanes；绑定 blockIdx.x、threadIdx.x 并 vectorize 内层。T.where 谓词保护尾部。
对 1025 元素真实生成代码，TVM 将 vector loop 降为带边界检查的标量循环；
另保存 [1,5632] 对齐源码也显示标量 lane 循环（extern 标量数学操作限制 lowering）。
因此当前只验证了 IR 的 vectorize 指令，没有证明最终向量访存，更没有证明向量化收益。
保留 T4 实测使用的 128 线程、2 lane 基线参数。当前结果只覆盖这一配置。

## 已授权且可用的 Linux T4 上复现

需 Python 3.12、可用 NVIDIA T4、驱动、LLVM wheel 及 CUDA toolkit 的 nvcc。
TVM Linux wheel 的 CUDA runtime 部件依赖 `libcudart.so.13`。如果 T4 主机使用
CUDA 12.4，TVM 可能无法识别设备，即使 PyTorch 可以识别。下面的兼容步骤使用
同版本 TVM 源码，只替换隔离环境内的 CUDA runtime。编译需要 g++ 和 CUDA 12.4
头文件。脚本给 CUDA 12.8 新增的 preferred cluster launch 属性加版本检查，
并在 `FreeDataSpace` 处理 `cudaErrorCudartUnloading`。后者用于 TVM 工作区在进程
结束时的清理，保留其余 CUDA 错误。见 [TVM 发布构建脚本](https://github.com/apache/tvm/blob/v0.25.0.post1/ci/scripts/package/manylinux_build_libtvm_runtime_cuda.sh)。

沿用历史 2.5.1 / Triton 3.1.0 对照版本，在全新环境中安装：

```bash
python3.12 -m venv .venv-tvm-t4
source .venv-tvm-t4/bin/activate
python -m pip install -r requirements-tvm.txt
python -m pip install torch==2.5.1 --index-url https://download.pytorch.org/whl/cu124
python -m pip install triton==3.1.0
export CUDA_HOME=/usr/local/cuda
export PATH="$CUDA_HOME/bin:$PATH"
# CUDA 12.4 主机如无法加载 wheel 的 CUDA runtime，重编译该部件。
curl -fL https://codeload.github.com/apache/tvm/tar.gz/refs/tags/v0.25.0.post1 -o /tmp/tvm-v0.25.0.post1.tar.gz
bash benchmarks/build_tvm_cuda12_sidecar.sh /tmp/tvm-v0.25.0.post1.tar.gz results/tvm_cuda12_sidecar
python -c 'import tvm; assert tvm.cuda().exist'
export PYTHONPATH="$PWD/src"
export OMP_NUM_THREADS=1
nvidia-smi
nvcc --version
python benchmarks/tvm_swiglu.py t4 --output results/tvm_t4_20261109
python -m pip freeze > results/tvm_t4_20261109/pip-freeze.txt
tar -czf results/tvm_t4_20261109.tar.gz --exclude=inductor_cache --exclude=triton_cache results/tvm_t4_20261109
```

T4 入口先跑全仓库测试，然后 trace 和 benchmark 各起独立新进程、独立缓存，清除
继承的调试环境。拒绝非 T4；测试失败或精度失败不得报告通过。
固定输入 seed 42，同一 shape/dtype 五方共享输入，保存输入 hash；尺寸 [1,5632]、
[128,5632]、[1024,5632]、[1025]，FP32/FP16。每方默认分配输出，TVM 输入 DLPack
转换和编译在计时外，TVM 与 torch 使用同一 CUDA stream。
统一 warmup 25、100 calls/block、10 个轮换轮次，每方占据每个顺序位置两次。
复用已有 measure_block：块前后同步，保存 wall、submit、CUDA event interval。
wall 包含 host dispatch、分配和最终同步。event 是 GPU stream 区间，可能含主机
提交空隙。独立 trace 进程通过 CUPTI 记录每次 kernel 的持续时间，结果单列在
`trace/raw.json`，原始事件在各尺寸目录的 `profile_*.json`。
TVM/Triton/torch.compile build+首次调用成本单列，不混入后续执行计时。

产物包括 environment.json、pytest.log、trace/run.log、benchmark/run.log、raw.json、
summary.md，以及 on/off 的 before/after/legalized IR、VM、分配与张量调用计数、
真实 CUDA/PTX 源码。raw 保存每块次序和时间、阈值与位型诊断。
失败会保留 status traceback 和已收集数据。缺失的源码格式在 modules.json errors
中列明。完整实测表见 [T4 验收结果](evidence/tvm_swiglu_t4_20261109/README.md)。
