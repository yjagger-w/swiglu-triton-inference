# SwiGLU：torch.compile 编译追踪与独立计时

2026-11-02 更新：已在现有 T4、PyTorch 2.5.1 / Triton 3.1.0 环境完成冒烟与正式验收，
见[实际 GPU 验收报告](compiler_trace_gpu_acceptance_20261102_CN.md)。
下述“交付环境未运行”描述保留为原交付状态，当前结果以该验收报告和原始归档为准。

## 本次新增与实际完成边界

新增 `benchmarks/trace_compile_swiglu.py`，将现有的 `swiglu_torch` 交给
`torch.compile(..., backend="inductor", fullgraph=True, dynamic=False)`。
本次显式设置 `triton.cudagraphs=False`，控制自动 CUDA Graph 带来的额外变量。
它只编译投影后的 `F.silu(gate) * up`，没有编译整个 MLP 或模型生成。

新增代码已完成标准库流程测试、语法检查与无依赖环境的失败路径检查。
**交付环境没有 PyTorch、Triton、NVIDIA GPU，因此真实 FX/Inductor/Triton
产物、CUDA 正确性与性能尚未运行验收。** 不能将这些新增代码写成已经完成的
GPU 编译追踪实验，更不能增加新的加速成绩。

本次没有新增编译器优化 Pass。原有算子、模型适配器和历史测量结果保持独立，
不把它们自动解释为本脚本的测量结果。

## 两条编译链怎样对应

| 路径 | 入口 | 应当检查的材料 |
|---|---|---|
| 自动编译 | `swiglu_torch → Dynamo → FX/AOTDispatch → Inductor → 生成 kernel` | `trace.log`、FX 图、融合前后 IR、`output_code.py` |
| 手写 kernel | `swiglu_triton → _swiglu_fp16_kernel → Triton 编译阶段` | `kernel.ttir/ttgir/llir/ptx/cubin`、`launch.json` |
| 执行 | 输出分配、编译结果复用、kernel 启动与同步 | `benchmark/result.json` 的原始样本、顺序与精度记录 |

IR 不是单一格式。FX 描述操作和依赖；Inductor 还处理循环、缓冲区与融合；
Triton 的 NVIDIA 后端继续生成更低层 IR、PTX 和 cubin。
本项目是推理，不因使用 AOTAutograd/AOTDispatch 组件就执行了反向传播。

## 运行前置条件

- 使用可见 NVIDIA CUDA GPU 的 Linux 环境。Windows 本机可读代码和跑流程测试；
  本次目标 GPU 路径建议沿用此前 AutoDL 环境。
- 依赖沿用历史 PyTorch 2.6.0+cu124、Triton 3.2.0；脚本会记录实际版本。
  私有调试接口在其他版本可能变化，不承诺所有 `torch>=2.2` 都有相同产物。
- 从仓库根目录运行。无需下载 TinyLlama，也无需访问 Hugging Face。
- 对输出目录使用全新名称。存在的目录一律拒绝覆盖，包括上次失败的目录。
- 默认只需要 batch 展平后的 `[T,F]` 激活，不包含 Linear、attention 或 KV cache。

## 先做小规模 GPU 冒烟

此前 AutoDL 项目路径和解释器如下；如果实例已释放，应先恢复代码和环境。
这两个路径不是对当前服务器状态的保证。

```bash
cd /root/autodl-tmp/swiglu-triton-inference
PY=/root/autodl-tmp/st-mamba/environment/st-mamba-py312/bin/python
test -x "$PY" || exit 1
nvidia-smi -L

"$PY" benchmarks/trace_compile_swiglu.py \
  --tokens 1 --features 5632 \
  --repeats 3 --calls 10 --warmups 3 \
  --output-dir results/compile_trace_t4_smoke_01
```

先看 `summary.json` 的 status 和各阶段退出码。只有 GPU 冒烟完成并核对产物后，
再运行正式采样；不要把冒烟的三轮十次调用作为最终性能结果。

## 正式追踪与独立采样

```bash
"$PY" benchmarks/trace_compile_swiglu.py \
  --tokens 1,128,1024 --features 5632 \
  --repeats 6 --calls 100 --warmups 25 \
  --seed 42 --device 0 \
  --output-dir results/compile_trace_t4_fp16_01
```

默认 F=5632 对应 TinyLlama 的 intermediate size。`T=1` 对应一个 token 的
投影后激活，`T=128` 对应128个 token。独立算子 T=1024 是更大工作负载，
并不代表脚本测了1024-token模型生成。

`--only trace` 和 `--only benchmark` 可分别运行一个阶段，每次仍需新输出目录。
`--repeats` 必须是3的正整数倍，保证三条路径在各执行位置的出现次数一致。

## 输出内容

| 路径 | 内容 |
|---|---|
| `run.json` | 参数、时间、源码 commit、dirty 状态、核心源码 SHA-256 |
| `preflight.json` | 实际 Python/PyTorch/Triton/CUDA/GPU 信息；只有预检通过才生成 |
| `*_failure.json`、`*.log` | 失败原因与 traceback；失败不伪造后续结果 |
| `trace/inductor_debug/t*_f*/` | 每个输入 shape 各自的 FX、Inductor IR 与生成代码 |
| `trace/handwritten_t*_f*/` | 手写 FP16 kernel 的可用编译阶段与实际编译元数据 |
| `trace/result.json` | 追踪配置、逐 shape 精度与导出情况，没有性能结论 |
| `benchmark/result.json` | 无调试日志的新进程中得到的精度、顺序、原始样本及中位数 |
| `summary.json` | 阶段退出码、产物清单与 SHA-256、缺项、整体状态 |
| `REPORT.md` | 自动整理的产物索引与计时表，附人工核对项 |

编译缓存也分别保留在 `trace/` 和 `benchmark/` 下，不能把编译缓存误当作
已被逐行解释的编译证据。若仅提交人工选择后的文本产物，应另外保留原始运行目录。

## 按这个顺序读产物

1. **先读 `trace.log`。** 找到 Dynamo 捕获的图，以及 AOT 图、重新编译信息。
   `fullgraph=True` 要求单次调用完整捕获；遇到不支持的图中断应失败，不能静默回退。
   不同输入 shape 仍可能分别编译，不等于只会生成一张通用图。
2. **读 `fx_graph_readable.py` / `fx_graph_transformed.py`。** 找到 SiLU、乘法或
   实际分解后的算子，核对 shape 与 dtype。不要把示意图当成真实导出图。
3. **对照 `ir_pre_fusion.txt` 与 `ir_post_fusion.txt`。** 观察调度节点和依赖变化，
   再与生成代码对应。具体节点名称以本次文件为准，不预设某种模式一定融合。
4. **读 `output_code.py`。** 核对生成 kernel 和实际调用；看读写哪些指针，
   是否有中间 tensor 分配，哪些值被转成 FP32/FP16。不要只按函数定义数断言 launch 数。
5. **读手写 `kernel.ptx` 与上层 IR。** 对应 exp/div、dtype 转换、加载和存储；
   `launch.json` 中记录可获取的 num_warps 等实际元数据，不将默认猜测写成结果。
6. **最后读 `benchmark/result.json`。** 数值与范围一致后，再讨论延迟。

`REPORT.md` 只自动整理文件和数据，不会自动声称“已经证明融合”“已经证明
去掉中间舍入”或“已经证明某一性能瓶颈”。这些判断必须引用实际产物。

## 计时协议

- launcher 启动独立 trace/benchmark 进程，在 import PyTorch 之前设置各自环境。
- trace 开启 `TORCH_LOGS=graph_code,aot_graphs,output_code,graph_breaks,recompiles`
  及 Inductor trace；benchmark 清理这些调试开关，并显式关闭 trace。
- 两阶段使用独立缓存目录，避免旧编译缓存导致调试产物缺失。
- 三条路径使用同一对 contiguous FP16 gate/up；输入生成、首次编译、验证和预热不计时。
- eager、compiled、手写 Triton 都使用默认输出分配，不单独给 Triton 预分配 out。
- 六轮按三条路径旋转，每个位置各出现两次。保留所有样本，不挑最好一次。
- 每块100次调用，前后同步；对每块求每次平均时间，再取六块中位数。
- 同时保存 host submit 和 CUDA event interval；event interval 可能包含主机提交间隙，
  不是纯设备计算时间；submit 也可能包含内部阻塞，不是纯 CPU 工作量。
- 显式关闭 compiled 路径的 CUDA Graph，不能把它和此前 Graph 控制实验混为一轮。
- 当前未自动采集或控制 GPU 频率、温度、功率和并行任务，状态漂移仍是限制。

本协议与历史 `do_bench` 微基准不同，不能将两者毫秒数直接拼成同轮排行榜。
它也不是单请求生成延迟或吞吐测试。

## 数值状态与失败语义

两候选统一对 eager 使用 `rtol=atol=0.01`，并额外记录数值不等数、位型不等数、
最大/平均绝对误差。`strict_tolerance_passed` 不等于 FP16 bitwise 一致。
本次不改变模型生成实验的历史验收结果。

- 有非有限输出：停止该阶段，不进行性能比较。
- 严格容差失败：保留诊断/采样，但整体标记 `exploratory_strict_tolerance_failed`，
  不能作为通过精度要求的性能胜出；launcher 返回非零供自动化识别。
- 编译/预检失败：记录 `worker_failed`，停止后续阶段。
- 子进程成功但结果或指定编译产物缺失：标记 incomplete，不能称追踪完成。
- 每个 shape 都检查指定 Inductor 产物；缺失手写阶段也会记录，不编造空文件占位。

## 不用 GPU 的流程回归

```bash
python -m unittest discover -s tests -p test_compile_trace.py -v
python benchmarks/trace_compile_swiglu.py --help
```

这些测试检查环境隔离、均衡顺序、旧文件保护、失败停止、缺项与探索性状态。
测试中的模拟产物都是测试夹具，不是编译器实际输出。
它们不代替原有 CUDA 数值测试或本脚本 GPU 验收。

## GPU 执行后的验收清单

- 记录真实 GPU、软件版本、源码状态与输出目录。
- 冒烟通过；正式运行的所有 shape 都有完整 trace 和 benchmark 结果。
- 在图、IR和生成代码之间找到一次具体融合，写出逐文件对应关系。
- 核对自动生成代码是否保留中间 FP16 舍入，结合误差数据解释，不凭性能推断。
- 对照手写 kernel 的 mask、块大小和编译元数据，区分源码参数与编译结果。
- 汇报完整原始样本、精度状态和稳定性，不只报告最大 speedup。
- 没有端到端模型实验就不新增端到端加速声明；没有修改 Pass 就不写已实现 Pass。

## 已核对的版本化参考

- [PyTorch 2.6 compiler troubleshooting](https://github.com/pytorch/pytorch/blob/v2.6.0/docs/source/torch.compiler_troubleshooting.rst)
- [PyTorch 2.6 logging registrations](https://github.com/pytorch/pytorch/blob/v2.6.0/torch/_logging/_registrations.py)
- [PyTorch 2.6 Inductor trace configuration](https://github.com/pytorch/pytorch/blob/v2.6.0/torch/_inductor/config.py)
- [PyTorch 2.6 debug artifact writers](https://github.com/pytorch/pytorch/blob/v2.6.0/torch/_inductor/debug.py)
- [Triton 3.2 NVIDIA compiler stages](https://github.com/triton-lang/triton/blob/v3.2.0/third_party/nvidia/backend/compiler.py)
