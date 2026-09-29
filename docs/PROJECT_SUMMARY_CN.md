# SwiGLU Triton 项目总结 — v0.1

## 定位与完成边界

项目面向 GPU 算子开发与推理性能分析，使用已有的 SwiGLU 公式。
实现范围是 gate/up 投影之后的 SiLU 与逐元素乘法融合，三个线性投影继续使用 PyTorch。
v0.1 于 2026-09-29 收尾：完成正确性修复和分层性能验证，未获得真实生成的端到端加速。
ST-Mamba 论文研究独立推进。

## 环境与模型

- GPU：Tesla T4，compute capability 7.5。
- Python 3.12.14，PyTorch 2.6.0+cu124，Triton 3.2.0，Transformers 4.51.3。
- TinyLlama/TinyLlama-1.1B-Chat-v1.0；revision 为 `fe8a4ea1ffedaf415f4da2f062534de366a451e6`。
- 模型有 22 层 MLP，hidden=2048，intermediate=5632；batch=1、FP16。
- 修正接入后的 T4 测试：21 passed、5 skipped。包内新增诊断脚本的实际运行记录见结果说明。

## 实验过程

1. 建立 PyTorch eager 参考与 Triton 融合实现，验证独立算子和随机权重 MLP。
2. 加入 torch.compile 对照，发现手写内核相对编译器没有明确领先证据。
3. 接入真实 TinyLlama，发现独立算子加速没有传递到完整生成。
4. 检查 profiler 顺序漂移、调用开销、MLP 计算顺序、编译范围和 prefill/decode。
5. 逐层比较原版输入上的算子输出，定位第 7 层首次出现误差；22 层约 1,586 万个元素中仅 14 个不同。
6. 最大误差样本均出现 gate=-2.724609375；原版重复运行与 eager 重建结果完全一致。
7. 遍历 63,488 个有限 FP16 gate 位模式，搭配 7 组 up 输入，比较不同算术表达式。
8. 使用 libdevice exp、精确除法及 FP16 中间舍入后，候选通过算子扫描和当前模型逐层验证。
9. 接入修正并新增回归测试；原来的 315 个 logits 超差消除，当前测试全部 logits 一致。
10. 公平比较原版/Triton 的普通执行和 CUDA Graph 执行，按预设停止条件结束本轮优化。

## 最终结果

| 范围 | 结果 | 解释 |
| --- | --- | --- |
| 独立 FP16 算子 | 已测形状相对 eager 为 1.259–1.888×；最大绝对误差均为 0 | 单次实验结果；微秒级小形状更易波动 |
| 128 输入 + 16 输出 token 生成 | 原版 349.475 ms；Triton 402.405 ms | Triton 慢约 15.1%；没有端到端加速 |
| 固定 forward 普通执行 | 原版 22.116 ms；Triton 24.950 ms | 使用统一 4D causal mask，关闭 KV cache |
| 同范围 CUDA Graph | 原版 17.736 ms；Triton 17.768 ms | 两条路径性能接近，无稳定额外融合收益 |
| 数值一致性 | 生成实验完整 prompt logits 一致；Graph 原始及滚动输入检查一致 | 仅限已测输入、环境和执行范围 |

CUDA Graph 对照采用 8 轮均衡顺序，每轮每条路径连续调用 10 次，报告块内每次 forward 平均耗时。
它不等于单请求延迟，也不等于带 KV cache 的生成速度。原版 Graph 的约 1.247× 改善属于执行方式收益。
Graph 改变了启动、分配和调度行为，不能据此把之前全部减速归因于 Python。

## 数值修复的原因

PyTorch 2.6 CUDA SiLU 使用 `x / (1 + exp(-x))`。原先的 `x * sigmoid(x)` 在浮点执行中可能出现不同舍入。
最终 FP16 内核采用 `tl.div_rn(x, 1 + libdevice.exp(-x))`，随后转回 FP16 再乘 up，保留参考路径的中间舍入。
改动只应用于已验证的 FP16 路径，FP32/BF16 保留原先表达式。
这些结果不保证全部输入对、非有限值、其他 GPU 或其他软件版本都逐位一致。

## 工程价值与后续安排

成果包括：可运行融合内核、模型适配、数值回归、分层 benchmark、编译器对照、Graph 公平对照和结果解释。
适合以“基于 Triton 的 SwiGLU 算子融合与 LLaMA 推理性能分析”作为工程项目介绍。
简历中的加速数字必须注明独立算子、T4、FP16、PyTorch eager 基线，不能写成整个大模型加速倍数。

v0.1 暂停新增性能实验。未来如推进 v0.2，应先确定新问题和时间预算，例如静态 KV cache 的真实 decode、
更大融合范围或 TVM 编译器学习；这些均不属于本版已完成成果。

## 证据与复现

详见根目录 README 和 `results/PROVENANCE.md`。最后几轮 JSON 根据用户完整终端输出转录，
未提供的完整诊断文件只保留摘要，不伪造为原始文件。服务器原始文件仍应另行下载备份。

历史 sigmoid 路径可在提交 `4d3fcaf` 查看；FP16 修正于提交 `b3e8e36` 接入。
现有结果文件保留历史与修正版的不同文件名，重新运行请使用 `recheck_*` 文件名。
