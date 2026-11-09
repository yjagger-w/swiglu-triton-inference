#!/usr/bin/env bash
# Rebuild only the TVM 0.25.0.post1 CUDA runtime for a CUDA 12.4 Linux x86_64 venv.
set -euo pipefail

if [[ $# != 2 ]]; then
  echo "Usage: bash $0 UPSTREAM_TVM_TARBALL BUILD_DIR" >&2
  exit 2
fi
archive=$(realpath "$1")
mkdir -p "$2"
build=$(realpath "$2")
cuda=${CUDA_HOME:-/usr/local/cuda}
printf '%s  %s\n' 4582150f510b2fbcfd64a2d91feb8db478bb54755fdb388b0e3efd06e536df66 "$archive" | sha256sum -c -

packages=$(python - <<'PY'
import importlib.metadata as metadata
import importlib.util
from pathlib import Path
import sys

assert sys.prefix != sys.base_prefix, "Activate a dedicated venv"
assert sys.platform == "linux"
assert metadata.version("apache-tvm") == "0.25.0.post1"
assert metadata.version("apache-tvm-ffi") == "0.1.12"
for module in ("tvm", "tvm_ffi"):
    path = Path(importlib.util.find_spec(module).origin).resolve().parent
    assert path.is_relative_to(Path(sys.prefix).resolve()), f"{module} must be installed in the venv"
    print(path)
PY
)
mapfile -t package <<< "$packages"
tvm=${package[0]}
ffi=${package[1]}
tar -xzf "$archive" -C "$build"
src="$build/tvm-0.25.0.post1"

# CUDA 12.4 lacks the preferred cluster launch attribute introduced in 12.8.
python - "$src/src/backend/cuda/runtime/cuda_module.cc" <<'PY'
from pathlib import Path
import sys

path = Path(sys.argv[1])
source = path.read_text()
start = source.index("    // 1b) Preferred cluster")
end = source.index("    // 2) Programmatic stream serialization", start)
block = source[start:end]
begin = "      CUlaunchAttribute attr{};\n"
finish = "      attrs.push_back(attr);\n"
assert block.count(begin) == 1 and block.count(finish) == 1
block = block.replace(begin, "#if CUDA_VERSION >= 12080\n" + begin)
block = block.replace(finish, finish + '#else\n      TVM_FFI_THROW(InternalError) << "Preferred cluster dimensions require CUDA 12.8+";\n#endif\n')
path.write_text(source[:start] + block + source[end:])

# WorkspacePool can release its cached allocations after CUDA shuts down.
# Preserve errors from live CUDA calls and tolerate only runtime unloading.
device_api = path.with_name("cuda_device_api.cc")
source = device_api.read_text()
start = source.index("  void FreeDataSpace(Device dev, void* ptr) final {")
end = source.index("\n protected:", start)
block = source[start:end]
block = block.replace(
    "      TVM_FFI_CHECK_CUDA_ERROR(cudaFreeHost(ptr));",
    "      const auto status = cudaFreeHost(ptr);\n"
    "      if (status != cudaErrorCudartUnloading) TVM_FFI_CHECK_CUDA_ERROR(status);",
)
block = block.replace(
    "      TVM_FFI_CHECK_CUDA_ERROR(cudaSetDevice(dev.device_id));",
    "      const auto selected = cudaSetDevice(dev.device_id);\n"
    "      if (selected == cudaErrorCudartUnloading) return;\n"
    "      TVM_FFI_CHECK_CUDA_ERROR(selected);",
)
block = block.replace(
    "      TVM_FFI_CHECK_CUDA_ERROR(cudaFree(ptr));",
    "      const auto status = cudaFree(ptr);\n"
    "      if (status != cudaErrorCudartUnloading) TVM_FFI_CHECK_CUDA_ERROR(status);",
)
assert block.count("cudaErrorCudartUnloading") == 3
device_api.write_text(source[:start] + block + source[end:])
PY

sidecar=libtvm_runtime_cuda.so
g++ -std=c++17 -O2 -shared -fPIC -pthread -DTVM_RUNTIME_EXPORTS -DTVM_FFI_EXPORTS \
    -I"$src/include" -I"$ffi/include" -I"$cuda/include" \
    "$src"/src/backend/cuda/runtime/*.cc "$src"/src/runtime/vm/cuda/*.cc \
    -L"$tvm/lib" -L"$ffi/lib" -L"$cuda/lib64" -ltvm_runtime -ltvm_ffi -lcudart -l:libcuda.so.1 \
    -Wl,--no-undefined -Wl,-soname,"$sidecar" -Wl,-rpath,'$ORIGIN' -o "$build/$sidecar"

cp -n "$tvm/lib/$sidecar" "$tvm/lib/$sidecar.cu13-backup"
cp "$build/$sidecar" "$tvm/lib/$sidecar"
if ! python -c 'import tvm; assert tvm.cuda().exist, "TVM CUDA device unavailable"'; then
  cp "$tvm/lib/$sidecar.cu13-backup" "$tvm/lib/$sidecar"
  exit 1
fi
sha256sum "$build/$sidecar"
