# SwiGLU 编译追踪与 CUDA 验收

2026-11-02（Asia/Hong_Kong）：冒烟和正式验收均完成。所有阶段退出码为 0，
三个正式 shape 的编译证据齐全，数值通过 `rtol=atol=0.01`。
本报告只描述投影后的 FP16 SwiGLU 独立算子；没有模型生成实验或新增编译器 Pass。

## 环境与源码

用户明确授权上传到 `root@region-9.autodl.pro:30765`。目标项目此前不存在，
从基线 bundle 恢复至 `/root/autodl-tmp/swiglu-triton-inference`，先检查再应用补丁，
没有覆盖已有项目。原始交付文件、失败预检、所有 GPU 输出及缓存均保留。
没有 commit/push，没有安装或升级 Torch、Triton 或其他依赖。

| 项目 | 实际值 |
|---|---|
| GPU | Tesla T4，compute capability 7.5，16707551232 字节显存 |
| NVIDIA 驱动 | 565.57.01 |
| Python | `/root/miniconda3/bin/python`，3.12.3 |
| PyTorch / Triton | 2.5.1+cu124 / 3.1.0 |
| PyTorch CUDA runtime | 12.4（nvidia-smi 驱动能力显示 12.7，两者含义不同） |
| HEAD | `5f1e1578cfe7afc65727ff4082db0d00b11c4d24`，补丁保持未提交 |
| ops.py SHA-256 | `e9d78c612865b63b64da4280a2753db800355d49fbd1156758e138e1fd1329d0` |
| trace 脚本 SHA-256 | `64e7a35fce88279c2adde10ab13a030a917e88400ae16768a52f9b220e9c8fd6` |

实际版本与历史 2.6.0/3.2.0 不同；本次结论以当前版本的真实产物为准。
本地与远端核心源码哈希已比对。算子实现、模型接入及历史测量没有改动。
脚本含本地回归发现的 Windows 缺项路径 `.as_posix()` 修正。

## 检查与运行

| 检查 | 结果 |
|---|---|
| 本地及远端标准库回归 | 各 11/11 通过 |
| 本地及远端 compileall、git diff --check | 通过 |
| 冒烟：T=1，F=5632，3 轮×10 次，3 次预热 | completed，18 项产物，9 组计时样本 |
| 正式：T=1/128/1024，F=5632，6 轮×100 次，25 次预热 | completed，54 项产物，54 组计时样本 |
| 逐 shape 文件、产物大小与 SHA-256、样本数及轮转均衡核对 | 通过 |
| 额外尝试原有 `tests/test_ops.py` | 未执行测试：环境缺少 pytest；失败日志保留，未安装依赖 |

正式运行时间从 `run.json` 的 `2026-11-02T07:12:16.277345+00:00` 起。
冒烟和正式运行分别使用新目录：

```text
results/compile_trace_t4_smoke_20261102_01
results/compile_trace_t4_fp16_20261102_01
```

正式命令：

```bash
/root/miniconda3/bin/python benchmarks/trace_compile_swiglu.py \
  --tokens 1,128,1024 --features 5632 --repeats 6 --calls 100 \
  --warmups 25 --seed 42 --device 0 \
  --output-dir results/compile_trace_t4_fp16_20261102_01
```

trace 和 benchmark 为独立新进程，独立缓存；benchmark 清除调试开关。
`backend=inductor, fullgraph=True, dynamic=False, triton.cudagraphs=False`。
三条路径均分配输出，编译、首次调用、精度检查和预热不计时。
每块调用前后同步，保留 wall、host submit、CUDA event interval；
六轮轮转，每条路径在每个位置出现两次。下表取每块单次平均 wall 时间的六轮中位数。

## 正式数值与性能

单位 ms/调用；所有行的两个候选均为 `strict_tolerance_passed`，无非有限值。

| shape | eager | compiled | 手写 Triton |
|---|---:|---:|---:|
| [1,5632] | 0.026587 | 0.060086 | 0.038759 |
| [128,5632] | 0.030074 | 0.050715 | 0.029001 |
| [1024,5632] | 0.212632 | 0.123808 | 0.124002 |

compiled 在小 shape 更慢，T=1024 时约为 eager 的 1.72 倍速度；
手写 Triton 在 T=128 时约为 1.04 倍，在 T=1024 时约为 1.71 倍。
T=128 的差距较小，应结合波动判断。T=1 样本波动明显，不能仅据中位数推断瓶颈。
T=1024 两种融合路径的差距也不足以支持稳定的优劣结论。

| T | compiled 位型不等数 / 总数 | compiled 最大绝对误差 | compiled 平均绝对误差 | 手写位型不等数 / 最大误差 |
|---|---:|---:|---:|---:|
| 1 | 1510 / 5632 | 0.00390625 | 0.0000575214 | 0 / 0 |
| 128 | 192085 / 720896 | 0.0078125 | 0.0000560688 | 0 / 0 |
| 1024 | 1534695 / 5767168 | 0.0078125 | 0.0000562280 | 0 / 0 |

两条候选的严格容差不匹配数均为 0。手写逐位一致仅针对本轮固定 seed 的输入；
不证明所有输入、版本或模型场景逐位一致。compiled 容差通过不代表逐位一致。
trace 与 benchmark 的数值诊断一致。

以下为六轮 wall 原始样本（按各路径实际采样先后，保留 6 位小数；全精度及另外两项指标见 JSON）：

| T | 路径 | 六轮 ms/调用 |
|---|---|---|
| 1 | eager | 0.027992, 0.027043, 0.024866, 0.024417, 0.037491, 0.026132 |
| 1 | compiled | 0.066140, 0.056834, 0.059653, 0.056851, 0.078496, 0.060519 |
| 1 | Triton | 0.035826, 0.034940, 0.036348, 0.045173, 0.055859, 0.041170 |
| 128 | eager | 0.029981, 0.030311, 0.030029, 0.030037, 0.030216, 0.030110 |
| 128 | compiled | 0.051699, 0.051157, 0.049936, 0.051339, 0.050272, 0.048825 |
| 128 | Triton | 0.029166, 0.028828, 0.026786, 0.028870, 0.029132, 0.030487 |
| 1024 | eager | 0.212259, 0.212298, 0.212488, 0.212859, 0.212840, 0.212776 |
| 1024 | compiled | 0.123971, 0.122932, 0.124222, 0.124748, 0.123644, 0.123600 |
| 1024 | Triton | 0.123577, 0.123485, 0.124130, 0.123946, 0.124058, 0.125441 |

[正式计时全精度结果](evidence/compiler_trace_20261102/formal/benchmark_result.json)
包括精度、顺序和全部 54 组 wall/submit/event 样本。
event interval 可能含提交间隙，不是纯 kernel 时间；本结果是块均值，不是单请求延迟。
已保存运行前后 nvidia-smi 快照，但未控制频率、功率或系统并行负载，也未进行 profiler 瓶颈分析。

## 一次具体融合与舍入追踪：T=1

建议提交的文本证据副本均与原归档逐字节一致，路径对应关系、字节数及 SHA-256 保存在
[manifest.json](evidence/compiler_trace_20261102/manifest.json)。

1. [trace.log](evidence/compiler_trace_20261102/formal/trace.log) 第 22–23 行的 Dynamo 图包含
   `silu = F.silu(l_gate_)`、`mul = silu * l_up_`，输入和输出均为 FP16 [1,5632]。
   后续第 153、308 行分别记录因 shape 变化重新编译；这是静态 shape 专门化的实证，不能写成图中断。
2. [fx_graph_readable.py](evidence/compiler_trace_20261102/formal/t1/fx_graph_readable.py) 第 4–8 行：
   gate 转 FP32，sigmoid，与 gate 相乘得到 SiLU，转回 FP16，再乘 up。
3. [ir_pre_fusion.txt](evidence/compiler_trace_20261102/formal/t1/ir_pre_fusion.txt) 和
   [ir_post_fusion.txt](evidence/compiler_trace_20261102/formal/t1/ir_post_fusion.txt)
   均只有一个 `op0: SchedulerNode(ComputedBuffer)`，body 同时包含 sigmoid、两次乘法和最终 store。
   两文件逐字节相同；T=128/1024 也相同。可确认逐元素表达式已在单个调度节点中，
   无法据此声称本次 scheduler fusion pass 将两个节点合并。
4. [output_code.py](evidence/compiler_trace_20261102/formal/t1/output_code.py) 第 67–74 行：
   两输入加载为 FP32，`tmp2=tl.sigmoid(tmp1)`，`tmp3=tmp1*tmp2`，
   `tmp4=tmp3.to(tl.float32)`，`tmp6=tmp4*tmp5`，最后 store 到 FP16。
   FX 中的 FP16 激活转换没有成为乘 up 前的实际 FP16 舍入。
   第 81–95 行 `call()` 仅分配一个 FP16 `buf0`，第 91 行一次调用
   `triton_poi_fused_mul_silu_0.run(...)`；没有激活中间 tensor 的分配/写回。
   其余两个 shape 的包装函数也各含一次对应调用。这是已成功运行的生成包装函数证据，未额外采集 profiler launch 轨迹。

由此确认本轮自动编译的 SiLU 和乘法在同一个生成 kernel 内完成。
自动代码使用 `x*sigmoid(x)` 且去掉 FP16 中间舍入；自动路径与手写路径的表达式及中间舍入不同，
这些差异与 compiled 的位型差异相符，但本次未做消融，不能把所有误差仅归因于某一项。

### 手写路径

[kernel.ttir](evidence/compiler_trace_20261102/formal/t1/handwritten/kernel.ttir)
第 24–28 行使用 `__nv_expf`、`tt.precise_divf`，随后明确 `truncf f32→f16`、`extf f16→f32`，
第 31–33 行再乘 up、舍入并存储。
[kernel.ptx](evidence/compiler_trace_20261102/formal/t1/handwritten/kernel.ptx)
第 216–235 行可见 `div.rn.ftz.f32` 和中间 `cvt.rn.f16.f32`，
第 240–245 行实际采用 `mul.rn.f16x2` 与向量存储。
不能把源码/TTIR 的 FP32 乘法形式直接描述成最终 PTX 指令。

每个 shape 都导出 TTIR、TTGIR、LLVM IR、PTX、cubin 和 launch 元数据。
三个 shape 的 block=1024，grid 分别为 6/704/5632；num_warps=4、num_ctas=1、shared=0，
`enable_fp_fusion=False`。T=1 有尾部 mask，其他 shape 元素数为整块；这些参数来自实际产物。

### 事实与性能原因推测

已确认：以上节点、dtype 转换、生成包装函数调用、数值差异及延迟均来自实际文件或原始样本。
单 kernel 和省去激活中间 tensor 已由生成代码确认；pre/post IR 相同不能证明调度融合 pass 的具体作用。
本次没有 profiler 或消融实验。主机派发/分配开销可能影响小 shape，减少中间内存流量可能有利于大 shape，
这些仅是待验证解释，不能写成已定位性能瓶颈、已证明 Python 是减速原因或已证明内存带宽受限。

## 归档与复核入口

- 本地完整原始归档：仓库同级 `handoff-20261030/swiglu-cuda-acceptance-20261102_01.tar.gz`，约 664 KiB。
- SHA-256：`dd90a601360fb188226a0ed7a4263bb4cf0ea48a44bce3da06f3d774ad6e88c7`。
- 本地完整解包：`results/compile_trace_remote_archive_20261102_01/`，含两次运行全部日志、调试产物、编译缓存、源码快照、bundle、补丁和远端检查日志。
- 易读副本：`results/compile_trace_gpu_review_20261102_01/`；[正式 summary](evidence/compiler_trace_20261102/formal/summary.json)、[trace 结果](evidence/compiler_trace_20261102/formal/trace_result.json)。
- 可提交文本证据：`docs/evidence/compiler_trace_20261102/`，来源与筛选边界见该目录 README；完整归档和缓存不纳入建议提交清单。
- 远端原目录与 `/root/autodl-tmp/swiglu-cuda-acceptance-20261102_01.tar.gz` 均保留。
- 本地 `handoff-20261030/verify_cuda_archive.py` 可重跑校验归档、逐文件字节、产物哈希和源码一致性，兼容 Windows 长路径。

完整结果目录按 `.gitignore` 忽略，但文件实际存在；文本证据目录可正常纳入 Git。
归档内容固定于运行时；本报告及后续文档状态更新在归档之后产生，不改变归档里的原始源码快照。
**原有 pytest 套件未运行，不能写“全套测试通过”**；本次仅通过标准库流程回归及要求的 GPU 编译追踪、数值和计时验收。
