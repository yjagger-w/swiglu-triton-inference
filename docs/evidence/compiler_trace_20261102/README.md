# 2026-11-02 编译追踪文本证据

本目录是实际 GPU 运行归档的必要文本子集，可随源码和验收报告提交。
所有 40 个原始文件逐字节复制，未重排 JSON、截断日志、改写路径或清理编译器空白。
本 README 与 `manifest.json` 为整理时生成，不是 GPU 原始输出。
`.gitattributes` 对本目录关闭文本转换和空白告警，以保留原始字节；生成的 Python 文件仅供阅读。

## 来源

原始归档：仓库同级 `handoff-20261030/swiglu-cuda-acceptance-20261102_01.tar.gz`，679566 字节。
SHA-256：`dd90a601360fb188226a0ed7a4263bb4cf0ea48a44bce3da06f3d774ad6e88c7`。
[manifest.json](manifest.json) 列出每个文件在归档中的路径、原始字节数及 SHA-256。
完整归档、完整解包及旧复核副本仍保留本地，均未删除或替换。

| 路径 | 证据用途 |
|---|---|
| `smoke/` | 冒烟配置、版本、完整 summary、数值/计时结果和 Dynamo/AOT 追踪日志 |
| `formal/` 下的 JSON 与 `trace.log` | 正式运行配置、来源、全部精度检查及 54 组 wall/submit/event 样本、shape 重编译记录 |
| `formal/t1/`、`t128/`、`t1024/` | 各 shape 的 FX、融合前后调度 IR、生成包装函数/kernel，以及手写 launch 参数 |
| `formal/t1/handwritten/kernel.ttir`、`kernel.ptx` | 具体 exp/div、FP16 中间舍入及最终指令的对应证据 |
| `checks/` | 11 项标准库回归、pytest 缺失原始日志与退出码、运行前后显卡快照、逐文件审计及启动日志 |

这不是全部编译产物目录。完整 TTGIR、LLVM IR、全部 shape 的手写 PTX/TTIR、cubin、
Inductor/Triton 缓存及运行源码快照仍在完整归档。
原始 `summary.json` 保留完整产物清单，可能指向本子集中没有的成员；应以 manifest 描述本子集，
以完整归档复核这些额外文件，不能因本目录缺少 cubin 推断原运行缺失产物。
`run.json` 记录的是运行时源码状态，晚于运行的文档修改不应被误认为当时源码。

## 结果边界

Tesla T4 / PyTorch 2.5.1+cu124 / Triton 3.1.0；只测 FP16 投影后独立算子。
冒烟、正式编译追踪与计时通过，不等于模型生成加速。
标准库流程回归 11 项通过；原有 pytest 套件未运行，`checks/cuda_ops_tests.log` 显示
`No module named pytest`，不得表述为“全套测试通过”。

具体分析见[验收报告](../../compiler_trace_gpu_acceptance_20261102_CN.md)。
