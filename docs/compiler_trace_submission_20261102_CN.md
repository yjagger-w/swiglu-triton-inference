# 本轮建议提交清单与 diff 复核

本清单仅列出建议纳入后续提交的文件，未执行 git add、commit 或 push。
本轮在此前已应用补丁基础上增补文档和必要文本证据，保留其他现有文件。

## 建议提交：52 个文件

源码/配置与说明共 10 个：追踪脚本、标准库回归、忽略规则、证据字节保护规则，
README、项目总结、运行手册、GPU 报告、来源说明和本清单。
另有 42 个文本证据目录文件：40 个原始证据、1 个来源/哈希 manifest 和 1 个说明 README。
证据原始数据共 221044 字节；它们是完整归档的子集。

### 源码、配置与报告

```text
.gitattributes
.gitignore
README.md
benchmarks/trace_compile_swiglu.py
tests/test_compile_trace.py
docs/PROJECT_SUMMARY_CN.md
docs/compiler_trace_runbook_CN.md
docs/compiler_trace_gpu_acceptance_20261102_CN.md
docs/compiler_trace_submission_20261102_CN.md
results/PROVENANCE.md
```

### 必要文本证据（逐文件）

```text
docs/evidence/compiler_trace_20261102/README.md
docs/evidence/compiler_trace_20261102/checks/cuda_ops_tests.exit
docs/evidence/compiler_trace_20261102/checks/cuda_ops_tests.log
docs/evidence/compiler_trace_20261102/checks/evidence_audit.json
docs/evidence/compiler_trace_20261102/checks/formal.exit
docs/evidence/compiler_trace_20261102/checks/formal_launcher.log
docs/evidence/compiler_trace_20261102/checks/nvidia_after.txt
docs/evidence/compiler_trace_20261102/checks/nvidia_before.txt
docs/evidence/compiler_trace_20261102/checks/remote_git_status.txt
docs/evidence/compiler_trace_20261102/checks/remote_unit_tests.log
docs/evidence/compiler_trace_20261102/checks/smoke.exit
docs/evidence/compiler_trace_20261102/checks/smoke_launcher.log
docs/evidence/compiler_trace_20261102/formal/benchmark_result.json
docs/evidence/compiler_trace_20261102/formal/preflight.json
docs/evidence/compiler_trace_20261102/formal/run.json
docs/evidence/compiler_trace_20261102/formal/summary.json
docs/evidence/compiler_trace_20261102/formal/t1/fx_graph_readable.py
docs/evidence/compiler_trace_20261102/formal/t1/handwritten/kernel.ptx
docs/evidence/compiler_trace_20261102/formal/t1/handwritten/kernel.ttir
docs/evidence/compiler_trace_20261102/formal/t1/handwritten/launch.json
docs/evidence/compiler_trace_20261102/formal/t1/ir_post_fusion.txt
docs/evidence/compiler_trace_20261102/formal/t1/ir_pre_fusion.txt
docs/evidence/compiler_trace_20261102/formal/t1/output_code.py
docs/evidence/compiler_trace_20261102/formal/t1024/fx_graph_readable.py
docs/evidence/compiler_trace_20261102/formal/t1024/handwritten/launch.json
docs/evidence/compiler_trace_20261102/formal/t1024/ir_post_fusion.txt
docs/evidence/compiler_trace_20261102/formal/t1024/ir_pre_fusion.txt
docs/evidence/compiler_trace_20261102/formal/t1024/output_code.py
docs/evidence/compiler_trace_20261102/formal/t128/fx_graph_readable.py
docs/evidence/compiler_trace_20261102/formal/t128/handwritten/launch.json
docs/evidence/compiler_trace_20261102/formal/t128/ir_post_fusion.txt
docs/evidence/compiler_trace_20261102/formal/t128/ir_pre_fusion.txt
docs/evidence/compiler_trace_20261102/formal/t128/output_code.py
docs/evidence/compiler_trace_20261102/formal/trace.log
docs/evidence/compiler_trace_20261102/formal/trace_result.json
docs/evidence/compiler_trace_20261102/manifest.json
docs/evidence/compiler_trace_20261102/smoke/benchmark_result.json
docs/evidence/compiler_trace_20261102/smoke/preflight.json
docs/evidence/compiler_trace_20261102/smoke/run.json
docs/evidence/compiler_trace_20261102/smoke/summary.json
docs/evidence/compiler_trace_20261102/smoke/trace.log
docs/evidence/compiler_trace_20261102/smoke/trace_result.json
```

证据选择依据：smoke/formal 的配置与完成状态、完整数值和原始性能样本、Dynamo/AOT 日志，
每个正式 shape 的图/调度 IR/实际生成代码、手写 launch 参数，以及 T=1 的舍入 TTIR/PTX。
附标准库测试、pytest 缺失日志、显卡快照和哈希审计，便于核对验证边界。
生成 Python 文件只作证据，不作为新实现或测试执行。

## 仅本地保留，不在建议提交清单

- 仓库外 `handoff-20261030/`：原交付包解压、baseline.bundle、上传补丁、完整 CUDA 归档及 sha256、整理/核验脚本与本轮 review diff。
- 完整归档 `swiglu-cuda-acceptance-20261102_01.tar.gz`：679566 字节，SHA-256 为 `dd90a601360fb188226a0ed7a4263bb4cf0ea48a44bce3da06f3d774ad6e88c7`，继续保留，不删除。
- `results/compile_trace_local_preflight_20261102_01/`：本机缺 Torch 失败预检与回归日志。
- `results/compile_trace_remote_archive_20261102_01/`：完整解包，含二进制、缓存和运行源码快照。
- `results/compile_trace_gpu_review_20261102_01/`：前次易读副本，仍保留；本次报告改用可提交文本证据链接。
- `docs/compiler_trace_local_acceptance_20261102_CN.md`：本地过程/连接排障记录，保留但不建议作为项目结论提交。

没有新增模型权重、Python 环境、cubin、编译缓存或完整压缩包到建议清单。
没有更改 `src/swiglu_triton/ops.py`、`pyproject.toml`、模型接入或历史测量结果。

## diff 与内容复核

已检查跟踪文件 diff，并将所有建议新增文件纳入仓库外
`handoff-20261030/proposed_submission_20261102.diff` 供完整审阅，无需暂存。
`git diff --check` 检查跟踪改动；新增源码/文档检查末尾空白，原始证据以哈希和归档逐字节校验，
不对编译器原始空白做改写。已核对本轮文档链接、三行中位数、容差与位型差异、测试边界、归档与来源映射。

已确认事实是成功运行、实际产物和原始测量；主机派发/分配开销或内存流量影响只是待验证解释。
本轮原有 pytest 套件未运行，不能写“全套测试通过”；11 项标准库回归和 GPU 验收通过不能替代它。
本次只是文档与证据整理，没有重跑 GPU 计时或升级依赖。
