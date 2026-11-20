# SwiGLU FP32 x86 代码生成与性能归因

2026-11-20，Windows 本机实验。基线提交为已发布的 `feature/tvm-swiglu-fusion` 上的 `3e4ce7c`。实验使用现有 Relax Pass 和 SiLU legalizer，计算连续 FP32 张量的 `out = (gate / (1 + exp(-gate))) * up`。TVM 的图级自动融合在本实验的 CPU 构建路径中未启用。

## 复现

用 64 位 Python 和仓库中的 TVM 依赖锁定文件创建独立环境。本机复用已有的 `.venv-tvm`，Python 3.13.5、TVM 0.25.0.post1、TVM FFI 0.1.12、NumPy 2.5.4、pytest 9.2.0，TVM 自带 LLVM 22.1.0。运行只需 LLVM-enabled TVM，无需 PyTorch、Triton、CUDA 设备或外部 LLVM 工具。[依赖快照](evidence/tvm_swiglu_x86_20261120/pip-freeze.txt) · [LLVM 补丁版本探测](evidence/tvm_swiglu_x86_20261120/llvm-version.txt)

```powershell
python -m venv .venv-tvm
$tvmPython = "./.venv-tvm/Scripts/python.exe"
& $tvmPython -m pip install -r requirements-tvm.txt
$env:PYTHONPATH = "src"
$env:TVM_NUM_THREADS = "1"
$env:OMP_NUM_THREADS = "1"
& $tvmPython -m pytest -q -p no:cacheprovider
& $tvmPython benchmarks/tvm_swiglu.py cpu --output results/tvm_cpu_baseline
& $tvmPython benchmarks/tvm_swiglu_x86.py --cpu 0 --output results/tvm_cpu_x86_run
```

输出目录需为新目录。省略 `--cpu` 时选当前进程亲和性掩码中的首个逻辑处理器。正式运行覆盖 `[1,5632]`、`[128,5632]`、`[1024,5632]`、`[1024]` 及 `[1025]`。可用 `--smoke --rounds 6` 验证编译、尾部和计时链路。正式证据位于 [本机运行目录](evidence/tvm_swiglu_x86_20261120/)。

## 本机环境和对照设计

Intel Core Ultra 7 255H，Windows 11 10.0.26200。Win32 功能探测确认 SSE2、SSE4.1、SSE4.2、AVX 和 AVX2 可用，AVX-512F 未报告可用。LLVM 将宿主识别为 `arrowlake`。进程掩码从 `0xffff` 改成 `0x1` 并回读确认，固定到逻辑 CPU 0。TVM 运行时回报 1 线程，三个线程环境变量均设为 1。未辨认逻辑 CPU 0 的核类型，未锁频。目标采用已探测能力范围内的 `x86_64-pc-windows-msvc`、`mcpu=x86-64` 和 `mattr=+avx2`。两组 target 均设 LLVM `opt-level=3`、`fast-math=false`，TVM `tirx.enable_fast_math=false`。[环境与目标](evidence/tvm_swiglu_x86_20261120/environment.json) · [Win32 指令集探测 API](https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-isprocessorfeaturepresent)

| 组别 | Pass | 调度与开关 |
|---|---|---|
| `default_off` / `default_on` | 关 / 开 | 原始 CPU Legalize 路径，保留 LLVM 自动向量化 |
| `unscheduled_disable_off` / `unscheduled_disable_on` | 关 / 开 | 同一默认路径，仅设置 `tirx.disable_vectorize=true`，只导出编译对照 |
| `scalar_off` / `scalar_on` | 关 / 开 | 两边每个点算子均展开为单一线性索引，拆成 8 元素整块和独立余数循环。关闭 LLVM 自动向量化与 TIR 向量循环 lowering |
| `simd_off` / `simd_on` | 关 / 开 | 同一调度和 target，允许 TIR 将整块内层显式向量化 |

在已安装的 pinned wheel 中，`PassContext.list_configs()` 注册的是 `tirx.disable_vectorize`。执行路径使用 `tvm/s_tir/pipeline.py` 中的 `VectorizeLoop(not config[…])`。LLVM target 使用 `cl-opt` 接收 `-vectorize-loops:bool=false` 和 `-vectorize-slp:bool=false`。对本机 wheel，`llvm-options` 被 target schema 拒绝。向量开关是否形成有效对照以导出的 LLVM IR 和 x86 汇编为准。[TVM 上游 LLVM 选项处理](https://github.com/apache/tvm/blob/main/src/target/llvm/llvm_instance.cc)

输入由 NumPy PCG64 的固定种子 42 生成，每个尺寸独立初始化种子，gate 乘 5。逐尺寸记录 gate/up 的小端 FP32 C-order SHA-256。使用 NumPy FP32 参考和 `rtol=atol=3e-5` 验证 VM 输出，并将预分配路径与同组 VM 结果进行位级比较。编译、输入转换、JIT 初始化和正确性校验均在稳态计时前完成。

## 计时口径

- **`vm`** 使用 TVM C++ `time_evaluator` 调用实际 Relax VM `main`，含字节码、形状检查、池化分配和所有 TIR 调用。每次调用返回的输出不跨调用持有。
- **`preallocated`** 使用同一 VM 计时器和同一个已编译的 LLVM 模块，通过最小 VM 字节码顺序调用原有 TIR 函数。scratch 和 out 由调用方预分配。它保留 VM 分派与两阶段先后关系，省去原 `main` 的检查、分配和相关对象管理。正是同一份机器码，适合控制运行时开销。
- **`kernel_*`** 直接用 LLVM 模块的 C++ `time_evaluator` 计时预分配 TIR packed 函数，含 packed ABI 开销。未融合组分别报告 SiLU 和 multiply。两项独立重复，缓存状态可能不同，分析两阶段连续运行使用 `preallocated` 数据。

每个尺寸共享同一对输入和预分配缓冲区，VM 使用池化分配。每个样本内重复使用这些地址，不冲刷缓存。正式运行 12 轮，每个变体在每个位置出现两次，并均衡同轮相邻变体。三个计时口径在变体内轮换。每个样本为一批调用的单次平均耗时，TVM 计时器自身还执行一次未计时预热。报告每批均值的中位数、IQR 和最小/最大值。编译耗时、VM 构造与首次函数查找、首次调用另存于 `raw.json` 的 `builds` 项。首次调用视运行时惰性初始化情况可能包含该阶段的工作。

## 证据定位

各 shape 目录的 `before.py`、`after_off.py`、`after_on.py` 保存 Pass 前后 Relax IR。`legalized_*.py` 保存 Legalize 后 IR，`scheduled_*.py` 保存受控调度后的同一份 TIR。每个组的 `module.ll`、`module.s` 来自实际 TVM LLVM 模块的 `inspect_source("ll")`、`inspect_source("asm")`。汇编是 LLVM 后端输出，未读取 JIT 内存字节。`vm.txt` 和 `preallocated.txt` 保存两种 VM 字节码，配套 JSON 汇总算子调用和 tensor 分配指令。原始计时、输入哈希、编译耗时、误差和代码哈希在 [raw.json](evidence/tvm_swiglu_x86_20261120/raw.json)，完整中位数和波动表在 [summary.md](evidence/tvm_swiglu_x86_20261120/summary.md)。

## 编译证据

1. **Pass 和缓冲区。** `[128,5632]` 的 Pass off 保留 `R.nn.silu` 和 `R.multiply`，Legalize 生成两个 `R.call_tir`。VM 对 SiLU 中间结果执行 `alloc_storage` 和 `alloc_tensor`，将该张量作为 `contract_silu` 的写入目标与 `multiply` 的读取输入。Pass on 在 Legalize 前将两步替换为一次 `R.call_tir(custom_swiglu…)`，VM 只分配最终输出。池化运行时可以回收底层内存，字节码的分配次数只证明运行时分配操作的次数。[Pass off](evidence/tvm_swiglu_x86_20261120/128x5632/after_off.py) · [Pass on](evidence/tvm_swiglu_x86_20261120/128x5632/after_on.py) · [Legalize off](evidence/tvm_swiglu_x86_20261120/128x5632/legalized_off.py) · [Legalize on](evidence/tvm_swiglu_x86_20261120/128x5632/legalized_on.py) · [VM off](evidence/tvm_swiglu_x86_20261120/128x5632/default_off/vm.txt#L6) · [VM on](evidence/tvm_swiglu_x86_20261120/128x5632/default_on/vm.txt#L6)
2. **机器码确认落地。** `simd_off` 的 `contract_silu_compute_` 在 `vdivps` 后写入调用方给出的中间数组，`multiply_compute_` 从中间数组和 up 取值后写结果。`simd_on` 将 `vdivps` 结果直接接给 `vmulps`，随后写最终结果。按元素有效载荷推导，off 读写 `20N` 字节，on 为 `12N` 字节，省去一次 `4N` 中间写入和一次 `4N` 读取。`[128,5632]` 减少 5.5 MiB 显式数组读写，`[1024,5632]` 减少 44 MiB。这些量来自代码，未计入栈访问、cache line writeback、写分配或内存控制器流量。[off LLVM 中间写入](evidence/tvm_swiglu_x86_20261120/128x5632/simd_off/module.ll#L915) · [off LLVM 中间读取](evidence/tvm_swiglu_x86_20261120/128x5632/simd_off/module.ll#L949) · [off 汇编写入](evidence/tvm_swiglu_x86_20261120/128x5632/simd_off/module.s#L1469) · [off 汇编读取](evidence/tvm_swiglu_x86_20261120/128x5632/simd_off/module.s#L1496) · [on 汇编](evidence/tvm_swiglu_x86_20261120/128x5632/simd_on/module.s#L893)
3. **向量化及 exp。** 默认路径的 off/on 都可见部分 SIMD。只切换 `tirx.disable_vectorize` 的默认调度未形成有效向量化对照，两个状态各自的汇编与 LLVM IR 哈希相同。受控调度中，`scalar_*` 使用标量 `vdivss`/`vmulss`，`simd_*` 整块使用 YMM 寄存器的 `vaddps`、`vdivps` 和 `vmulps`，宽度 256 位、8 个 FP32 lane。`llvm.exp.v8f32` 在 LLVM IR 中存在，最终每块拆出八次 `callq expf`，再经 shuffle/insert 重组。两组的 exp 均为标量库调用，每元素一次。观察到 lane 提取、重组和栈暂存，SIMD 算术收益需与这些成本合看。仅追到生成代码与 `expf` 的调用边界，未分析系统数学库内部实现。[受控标量汇编](evidence/tvm_swiglu_x86_20261120/128x5632/scalar_on/module.s) · [向量 intrinsic](evidence/tvm_swiglu_x86_20261120/128x5632/simd_on/module.ll#L605) · [8 次标量调用和重组](evidence/tvm_swiglu_x86_20261120/128x5632/simd_on/module.s#L862)
4. **尾部。** `[1025]` 的受控调度为 128 个整块和一个独立标量元素，尾部在汇编中用标量 load、`expf`、`vdivss`、`vmulss` 与 store，off 的 multiply 也有标量收尾。不存在掩码尾部。`[1024]` 用于配对观察，两者生成代码也可能有不同展开因子与循环布局，计时分辨率不足时只报告尾部实现。[1025 调度 TIR](evidence/tvm_swiglu_x86_20261120/1025/scheduled_on.py) · [1025 LLVM IR](evidence/tvm_swiglu_x86_20261120/1025/simd_on/module.ll) · [1025 汇编](evidence/tvm_swiglu_x86_20261120/1025/simd_on/module.s)

## 实测与归因

下表为每组“off 中位数 ÷ on 中位数”，大于 1 表示该次实验中融合后的中位数更低。逐组波动和直接 TIR 计时见完整汇总。

| Shape | 默认 VM | 标量 VM | SIMD VM | 默认预分配 | 标量预分配 | SIMD 预分配 |
|---|---:|---:|---:|---:|---:|---:|
| 1×5632 | 1.065× | 1.026× | 1.027× | 1.027× | 1.014× | 1.008× |
| 128×5632 | 1.075× | 1.032× | 1.071× | 1.044× | 1.039× | 1.059× |
| 1024×5632 | 1.079× | 1.245× | 1.057× | 1.007× | 1.176× | 0.923× |
| 1024 | 0.983× | 1.213× | 1.112× | 0.934× | 0.960× | 1.053× |
| 1025 | 1.039× | 1.046× | 1.094× | 1.214× | 0.889× | 1.060× |

**以 `[128,5632]` 的 SIMD 组为例。** VM 中位数从 6.264 ms 降到 5.849 ms，下降 6.6%，12 个同轮比较中有 11 轮 on 更低。VM 的 off/on IQR 分别为 1.030/0.423 ms。复用同一份机器码和调用方缓冲区后，两阶段连续调用的中位数从 6.148 ms 降到 5.804 ms，下降 5.6%，10/12 轮 on 更低。此对照表明，在两端同时去掉原 VM 分配和检查后，本次仍观察到融合收益。保留下来的差别包括少一次 packed 调用、一次数组写入及读取，以及不同的代码布局和缓存行为。现有计时无法将这些影响拆成独立百分比。[128×5632 逐轮数据](evidence/tvm_swiglu_x86_20261120/raw.json) · [各组 IQR](evidence/tvm_swiglu_x86_20261120/summary.md)

同一尺寸，直接计时的 `simd_off` SiLU、multiply 中位数分别为 5.885、0.265 ms，`simd_on` 完整 packed kernel 为 5.683 ms。SiLU 阶段包含主要耗时，同时涵盖标量 expf、向量除法和访存，无法从阶段耗时量出 expf 独占时间。标量和 SIMD 预分配 off 分别是 6.141、6.148 ms，基本持平。on 分别是 5.912、5.804 ms，约 1.02×，逐轮比值的四分位区间跨过 1。结合八次标量 expf 调用，结果支持“其余算术的向量化收益可能被标量 exp 调用和 lane 拆装所限制”。要量出 exp、缓存或栈暂存的独立成本，需要性能计数器、库内部测量或更细的对照，本轮未采集这些数据。[直接 TIR 计时](evidence/tvm_swiglu_x86_20261120/summary.md)

**小尺寸的 VM 开销。** `[1024]` 的 SIMD 组中，完整 VM 的 off/on 中位数为 8.020/7.213 µs。预分配 VM 为 6.242/5.925 µs。同轮同代码的 `vm − preallocated` 中位数为 off 2.392 µs、on 1.531 µs，说明运行时额外工作与小尺寸融合的收益处在相近量级。这个差值也包含形状检查和张量生命周期管理，无法作为分配器独占开销。两种尺寸的 SIMD fused 直接 TIR 中位数为 `[1024]` 5.244 µs、`[1025]` 4.556 µs，IQR 分别为 2.135、1.931 µs。该差异不支持给单元素尾部估算独立成本。

**大尺寸的相反结果。** `[1024,5632]` 的标量预分配 off/on 中位数为 60.297/51.280 ms，on 在 10/12 轮更低。同尺寸 SIMD 预分配 off/on 为 55.529/60.161 ms，on 的中位数高 8.3%，但同轮 7/12 轮 on 更低，说明轮间波动足以改变排序。融合已消除中间缓冲区，这是静态证据。大尺寸 SIMD 的中位数退步可能受生成代码的标量调用拆装、寄存器/栈流量、缓存状态或系统频率/负载波动影响，没有依据把其中任一项判为主因。独立计时口径也不能直接相减来分摊大尺寸的收益。

数值检查覆盖全部 30 个编译单元，最大绝对误差为 `3.8146973e-6`，均符合既有容差。预分配路径与同组完整 VM 的输出位级一致。基线 TVM 测试 35 通过、17 跳过，新增 10 项确定性用例覆盖分块边界、FP32 非有限值、二维非对齐输入和 x86 代码生成开关。最终全仓测试 56 通过、21 跳过，跳过项需要当前独立环境未安装的 PyTorch。[pytest 日志](evidence/tvm_swiglu_x86_20261120/pytest.log)

## 可用于简历的描述

为 TVM Relax SwiGLU 融合 Pass 构建 FP32 x86 编译与性能对照，在 Intel Core Ultra 7 255H 单线程 12 轮实测中，`[128,5632]` 的 SIMD 配置将 VM 中位耗时从 6.26 ms 降至 5.85 ms（6.6%），用 LLVM IR、x86 汇编和预分配对照验证了中间张量消除及 expf 逐元素调用。

## 本轮文件

- `src/swiglu_tvm/fusion.py` 提取可复用的 SiLU Legalize 函数。原构建入口继续使用它。
- `src/swiglu_tvm/cpu.py` 和 `benchmarks/tvm_swiglu_x86.py` 提供受控调度、编译、验证、采样和导出。
- `tests/test_tvm_swiglu.py` 增加调度、尾部和开关回归。`.gitattributes` 保留证据目录原文件字节。
- `docs/evidence/tvm_swiglu_x86_20261120/` 保存编译产物、完整运行数据、依赖快照、测试记录和逐文件校验清单。[证据校验清单](evidence/tvm_swiglu_x86_20261120/sha256.txt)
