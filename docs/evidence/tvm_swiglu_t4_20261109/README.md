# 2026-11-09 AutoDL T4 验收记录

最终验收退出码为 0，84 项通过，5 项因 T4 不支持原有 Triton BF16 路径而跳过。
Tesla T4 16 GiB、驱动 550.90.07、CUDA 12.4.131、Python 3.12.3、
PyTorch 2.5.1+cu124、Triton 3.1.0、TVM 0.25.0.post1 和 FFI 0.1.12。
运行包、修复包与 sidecar 脚本的 SHA-256 见 [最终环境记录](evidence_final/preflight.txt)。
归档从基线 `5a829c9` 的工作区提取验收所需源码，远端副本省去 Git 元数据。
将四文件修复包覆盖到原始源码包后，与 sidecar 脚本一起生成了
[19 个执行文件的 SHA-256 清单](execution-sha256.txt)。在还原原始运行包后，可从其根目录
用 `sha256sum -c /path/to/execution-sha256.txt` 核对。Git 按仓库规则把
`benchmarks/tvm_swiglu.py`、`src/swiglu_tvm/cuda.py` 和
`tests/test_tvm_swiglu.py` 的 CRLF 转成 LF，其他执行文件的字节与原运行包一致。
复现步骤见 [运行文档](../../tvm_swiglu_CN.md)。

公开版证据保留数值、计时、编译产物和版本记录。诊断日志与 profiler 记录中的主机工作路径及 GPU 总线标识已替换为占位符，完整远端软件包清单仅保留在原始归档。原始证据及其 SHA-256 留存于本地备份。公开文件使用独立校验清单。从本目录运行 `sha256sum -c public-evidence-sha256.txt` 可逐文件校验。[公开证据 SHA-256 清单](public-evidence-sha256.txt)。

## 正确性

五方在两种 dtype、四种尺寸下均满足原算子阈值，FP32 `rtol=atol=3e-5`，
FP16 `rtol=atol=3e-3`。FP16 的 TVM off、TVM on 和手写 Triton 在四组固定输入上
均与 eager 位级一致。独立 TVM CUDA 算子通过 63,488 个有限 FP16 gate 的扫值、
舍入边界和非对齐尾部测试。Relax 开关两路通过 NaN/Inf 分类测试。
`torch.compile` 的 FP16 最大绝对误差为 0.0078125，满足相对与绝对联合容差，
四组输入均有位型差异。详见 [pytest 日志](evidence_final/pytest.log)、
[trace 原始数据](evidence_final/trace/raw.json)和[计时原始数据](evidence_final/benchmark/raw.json)。

## 性能

下表为调用墙钟时间，单位 µs/次。每方预热 25 次，100 次/块，10 轮轮换。
表中值为每块单次平均的中位数，含主机提交、分配和块结束同步。
构建、首次调用和 DLPack 输入转换在计时前完成。独立进程的两阶段输入哈希一致。

| dtype | shape | eager | torch.compile | Triton | TVM off | TVM on |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| FP32 | 1,5632 | 17.708 | 52.878 | 29.969 | 10.360 | 7.259 |
| FP32 | 128,5632 | 52.184 | 51.433 | 33.750 | 63.430 | 34.456 |
| FP32 | 1024,5632 | 402.374 | 239.729 | 239.356 | 410.248 | 237.895 |
| FP32 | 1025 | 19.121 | 52.230 | 29.886 | 10.181 | 7.569 |
| FP16 | 1,5632 | 19.567 | 50.999 | 32.112 | 10.730 | 7.515 |
| FP16 | 128,5632 | 30.043 | 51.881 | 30.044 | 51.717 | 28.811 |
| FP16 | 1024,5632 | 203.453 | 123.419 | 123.072 | 241.933 | 132.136 |
| FP16 | 1025 | 18.143 | 49.248 | 29.710 | 9.841 | 7.163 |

开启 Pass 相对关闭时快 1.35–1.84×。FP32 `[128,5632]` 和 FP16 `[1024,5632]`
的 TVM on 分别比手写 Triton 慢约 2.1% 和 7.4%。这些是单卡单次实验的算子结果。
[墙钟和 CUDA event 区间完整表](evidence_final/benchmark/summary.md)。

下表为独立 trace 进程中每方连续 25 次调用的 CUPTI kernel 时长之和除以 25，
单位 µs/次。它与 benchmark 是不同采样窗口。例如大 FP16 的 TVM on 在 CUPTI
窗口中为 184.299 µs，在 benchmark 窗口中为 132.136 µs 墙钟。
两张表的差值不能用来估算主机开销。

| dtype | shape | eager | torch.compile | Triton | TVM off | TVM on |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| FP32 | 1,5632 | 6.214 | 2.883 | 3.374 | 6.593 | 3.387 |
| FP32 | 128,5632 | 50.842 | 31.860 | 32.070 | 67.065 | 35.965 |
| FP32 | 1024,5632 | 394.085 | 233.379 | 234.277 | 432.058 | 235.844 |
| FP32 | 1025 | 4.984 | 2.312 | 3.044 | 5.220 | 2.797 |
| FP16 | 1,5632 | 6.378 | 2.881 | 6.406 | 6.426 | 3.409 |
| FP16 | 128,5632 | 27.566 | 17.508 | 17.912 | 50.757 | 27.583 |
| FP16 | 1024,5632 | 203.011 | 119.694 | 120.218 | 284.055 | 184.299 |
| FP16 | 1025 | 4.987 | 2.280 | 5.080 | 5.013 | 2.780 |

正式 benchmark 中各尺寸的构建和首次调用区间如下。Triton 和 torch.compile
的首次调用包括 JIT 和进程首轮初始化。eager 没有编译项。

| provider | 构建和首次调用，秒 |
| --- | ---: |
| torch.compile | 0.354–1.656 |
| Triton | 0.099–1.648 |
| TVM off | 0.432–0.551 |
| TVM on | 0.428–0.542 |

## 融合证据

八组输入的 CUPTI 实际启动数均为 eager 2、torch.compile 1、Triton 1、
TVM off 2、TVM on 1。TVM 两路的 PTX 入口数与启动数一致。
GPU 上的两个 TVM 方案都显示一次 VM 张量调用和输出分配。off 的宿主函数内部
另调用 `TVMBackendAllocWorkspace`，在 FP16 `[1024,5632]` 为 SiLU 缓冲区申请
11 MiB 工作区，然后由第二个 kernel 读取。on 的宿主函数中省去该工作区，
FP16 SiLU 中间舍入保留在单 kernel 内。示例可从
[Pass 前 IR](evidence_final/trace/float16_1024x5632/before.py)、
[Pass 后 IR](evidence_final/trace/float16_1024x5632/after_tvm_on.py)、
[off 宿主 LLVM](evidence_final/trace/float16_1024x5632/tvm_off/module_1.ll)、
[on CUDA](evidence_final/trace/float16_1024x5632/tvm_on/module_2.cu)、
[off PTX](evidence_final/trace/float16_1024x5632/tvm_off/module_2.ptx)和
[on PTX](evidence_final/trace/float16_1024x5632/tvm_on/module_2.ptx)复查。

## 兼容性排查

| 阶段 | 实测结果 |
| --- | --- |
| PyPI wheel 原样运行 | 64 通过、20 失败、5 跳过。CUDA sidecar 链接的 `libcudart.so.13` 在主机缺失 |
| 重编译 CUDA 12.4 sidecar | TVM 能识别 T4，动态链接指向 `libcudart.so.12` |
| 修复 runtime 后重跑原源码 | 67 通过、17 失败、5 跳过。编译回调执行时缺当前目标对象 |
| 显式传递架构后 | 测试断言 84 通过、5 跳过，进程清理阶段触发 SIGABRT |
| 处理 CUDA 卸载状态后 | 全套测试正常退出，完成五方 trace 和 benchmark |

原始 [首轮测试](evidence/pytest.log)、[runtime 修复后测试](evidence_cuda12/pytest.log)、
[动态链接检查](evidence_cuda12/ldd.txt)和[设备探测](evidence_cuda12/tvm-cuda.txt)随仓库保留。
原生堆栈定位到 `WorkspacePool` 析构调用 `FreeDataSpace`。最终 CUDA 12.4 sidecar
给 preferred cluster launch 属性加版本检查，并在释放函数中只处理
`cudaErrorCudartUnloading`。见 [中止诊断](evidence_run_600491a1/probe-native-abort.log)
和 [最终 sidecar 构建记录](evidence_final/sidecar-build.log)。
