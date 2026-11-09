# 2026-11-05 本地 TVM 证据

生成命令（仓库根目录，隔离环境）：

```powershell
$env:PYTHONPATH='src'
.venv-tvm/Scripts/python benchmarks/tvm_swiglu.py cpu --output docs/evidence/tvm_swiglu_20261105
.venv-tvm/Scripts/python -m pytest -q
```

float32/float16 各包含 before.py、after_on/off.py、legalized_on/off.py、VM 指令、
调用/分配计数与真实 LLVM 代码，以及 1025 非对齐、5632 对齐的 GPU 调度 IR 和
实际 CUDA 源码；另含完整 Relax CUDA lowering 的 on/off 源码及 kernel 定义计数
（off=2、on=1）。CUDA 源码由 TVM codegen 产生，在调用编译器前有意截取并停止，
因此命名 source_only，绝非 GPU 运行证据。无 PTX/cubin、本次 T4 时间或加速比。

environment.json 是本机环境和生成时 Git 状态；pip-freeze.txt 为本地完整依赖。
pytest.log 保存实际测试结果。pytest_without_tvm.log 使用 import 屏蔽模拟未安装 TVM，
验证原测试仍可收集。status.json 中 GPU/performance 为 not_run。
旧项目的 T4 数据没有复制到本目录，也没有用于填补未执行项。
