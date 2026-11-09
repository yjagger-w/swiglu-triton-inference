"""Scoped precise CUDA compilation; restores TVM's global callback afterwards.

TVM 0.25's default helper unconditionally adds --use_fast_math. Passing expf
alone therefore cannot enforce the repository's FP16 arithmetic contract.
"""
from contextlib import contextmanager
from pathlib import Path
import subprocess
import tempfile
import threading
import tvm

_lock = threading.RLock()


@contextmanager
def capture_cuda_source(path):
    """Capture codegen and stop before compilation, restoring the callback."""
    with _lock:
        previous = tvm.get_global_func("tvm_callback_cuda_compile")
        captured = []
        def capture(code):
            Path(path).write_text(code, encoding="utf-8")
            captured.append(True)
            raise RuntimeError("SwiGLU source-only capture stopped before CUDA compilation")
        tvm.register_global_func("tvm_callback_cuda_compile", capture, override=True)
        try:
            yield
        except Exception:
            if not captured:
                raise
        finally:
            tvm.register_global_func("tvm_callback_cuda_compile", previous, override=True)


def export_cuda_source(mod, path, target=None):
    """Run real CUDA codegen, stop before compilation. Does not fabricate PTX."""
    if target is None:
        target = {"kind": "cuda", "arch": "sm_75"}
    with capture_cuda_source(path):
        tvm.tirx.build(mod, target=target)


@contextmanager
def precise_cuda(enabled=True, *, arch="sm_75"):
    if not enabled:
        yield
        return
    with _lock:
        previous = tvm.get_global_func("tvm_callback_cuda_compile")

        def compile_precise(code):
            # The codegen callback can run outside the caller's Target scope.
            with tempfile.TemporaryDirectory(prefix="swiglu-cuda-") as tmp:
                source = Path(tmp) / "kernel.cu"
                output = Path(tmp) / "kernel.ptx"
                source.write_text(code, encoding="utf-8")
                cmd = ["nvcc", "--ptx", "-O3", f"-arch={arch}", "--fmad=false",
                       "--ftz=false", "--prec-div=true", "--prec-sqrt=true",
                       str(source), "-o", str(output)]
                completed = subprocess.run(cmd, capture_output=True, text=True)
                if completed.returncode:
                    raise RuntimeError("Precise nvcc compilation failed:\n" + completed.stdout + completed.stderr)
                return bytearray(output.read_bytes())

        tvm.register_global_func("tvm_callback_cuda_compile", compile_precise, override=True)
        try:
            yield
        finally:
            tvm.register_global_func("tvm_callback_cuda_compile", previous, override=True)
