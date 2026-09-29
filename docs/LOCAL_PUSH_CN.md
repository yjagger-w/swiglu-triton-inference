# 在 Windows 解压并推送远端

完整 ZIP 包含项目代码、测试、说明、已归档结果以及 `.git` 历史；分支为 `main`。
不需要在 Windows 上运行 CUDA 测试才能推送。此包未配置 remote，未替用户创建或推送远端仓库。

## 1. 解压到一个新的目录

将下载的 ZIP 放到 Downloads，使用 PowerShell：

```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\swiglu-triton-inference-v0.1.zip" -DestinationPath "D:\personal\HK\cedars\swiglu-triton-inference-release-20260929"
cd "D:\personal\HK\cedars\swiglu-triton-inference-release-20260929\swiglu-triton-inference"
git status -sb
git log -3 --oneline
```

该目标应为空目录。预计状态只有 `## main`；不要覆盖旧目录中的 `.git` 或未提交工作。
包内已有 Git 历史，不需要再次 `git init`。

## 2. 连接并推送空远端

在 GitHub 创建空仓库（不初始化 README、license 或 gitignore），复制仓库 URL。
将下面占位 URL 替换成实际地址：

```powershell
git remote add origin "https://github.com/YOUR_ACCOUNT/swiglu-triton-inference.git"
git push -u origin main
git push origin v0.1.0
```

如果你选择已有非空远端，先 `git fetch origin` 并检查历史关系，再合并或选择分支；不要直接强推。
包中没有模型权重、conda 环境或 HF cache，它们不是本次源码推送内容。

## 3. AutoDL 原始结果备份

停止本轮 GPU 实验后，可在 AutoDL 打包当前服务器项目：

```bash
tar --exclude='__pycache__' --exclude='.pytest_cache' \
  -czf /root/autodl-tmp/swiglu-t4-server-final-20260929.tar.gz \
  -C /root/autodl-tmp swiglu-triton-inference
```

下载该文件到电脑后再关机；不要把“关机”与“释放/删除实例”混为一项操作。
服务器备份随后已上传并核对，原始诊断 JSON 和 profiler 文件通过单独的证据补丁补入仓库。
详见 `results/PROVENANCE.md` 和原始文件哈希清单。保留本地服务器压缩包作为额外备份。
