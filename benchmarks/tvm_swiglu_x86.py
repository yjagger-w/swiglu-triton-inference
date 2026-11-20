"""Run the FP32 x86 SwiGLU experiment and export compiler and timing evidence."""

import argparse
import ctypes
import hashlib
from importlib.metadata import version
import os
from pathlib import Path
import platform
import statistics
import sys
import time

from tvm_swiglu import ROOT, environment, save, vm_evidence

THREAD_SETTINGS = dict.fromkeys(("TVM_NUM_THREADS", "OMP_NUM_THREADS", "OPENBLAS_NUM_THREADS"), "1")
os.environ.update(THREAD_SETTINGS)

import numpy as np
import tvm
from tvm import relax
from tvm.target import codegen
from swiglu_tvm.cpu import LLVM_NO_AUTO_VECTOR, VECTOR_WIDTH, VECTORIZATION_CONFIG, compile_cpu, strip_mine_fp32
from swiglu_tvm.fusion import FuseSwiGLU, example, legalize_swiglu


SHAPES = ((1, 5632), (128, 5632), (1024, 5632), (1024,), (1025,))
VARIANTS = tuple(f"{mode}_{state}" for mode in ("default", "scalar", "simd") for state in ("off", "on"))
SEED = 42


def dump(path, text):
    path.write_text(text.rstrip("\n") + "\n", encoding="utf-8", newline="\n")


def windows_hardware(cpu):
    import winreg
    kernel = ctypes.WinDLL("kernel32", use_last_error=True)
    mask_type = ctypes.c_size_t
    kernel.GetCurrentProcess.restype = ctypes.c_void_p
    kernel.GetProcessAffinityMask.argtypes = [ctypes.c_void_p, ctypes.POINTER(mask_type), ctypes.POINTER(mask_type)]
    kernel.SetProcessAffinityMask.argtypes = [ctypes.c_void_p, mask_type]
    kernel.IsProcessorFeaturePresent.argtypes = [ctypes.c_uint]
    kernel.IsProcessorFeaturePresent.restype = ctypes.c_ubyte
    process = kernel.GetCurrentProcess()
    current, system = mask_type(), mask_type()

    def get_mask():
        if not kernel.GetProcessAffinityMask(process, ctypes.byref(current), ctypes.byref(system)):
            raise ctypes.WinError(ctypes.get_last_error())
        return current.value

    before = get_mask()
    cpu = (before & -before).bit_length() - 1 if cpu is None else cpu
    if not (before & (1 << cpu)):
        raise ValueError(f"Logical CPU {cpu} is outside the process mask {before:#x}")
    if not kernel.SetProcessAffinityMask(process, 1 << cpu):
        raise ctypes.WinError(ctypes.get_last_error())
    after = get_mask()
    if after != 1 << cpu:
        raise RuntimeError(f"Unexpected observed affinity mask {after:#x}")
    with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, rf"HARDWARE\DESCRIPTION\System\CentralProcessor\{cpu}") as key:
        model = winreg.QueryValueEx(key, "ProcessorNameString")[0].strip()
    features = {name: bool(kernel.IsProcessorFeaturePresent(flag)) for name, flag in
                (("sse2", 10), ("sse4_1", 37), ("sse4_2", 38), ("avx", 39), ("avx2", 40), ("avx512f", 41))}
    return model, features, {"logical_cpu": cpu, "before_mask": hex(before), "after_mask": hex(after)}


def linux_hardware(cpu):
    before = os.sched_getaffinity(0)
    cpu = min(before) if cpu is None else cpu
    os.sched_setaffinity(0, {cpu})
    after = os.sched_getaffinity(0)
    if after != {cpu}:
        raise RuntimeError(f"Unexpected observed affinity {after}")
    processors = Path("/proc/cpuinfo").read_text().strip().split("\n\n")
    for record in processors:
        fields = dict(line.split(":", 1) for line in record.splitlines() if ":" in line)
        fields = {key.strip(): value.strip() for key, value in fields.items()}
        if fields.get("processor") == str(cpu):
            flags = set(fields["flags"].split())
            features = {name: name in flags for name in ("sse2", "sse4_1", "sse4_2", "avx", "avx2", "avx512f")}
            return fields["model name"], features, {"logical_cpu": cpu, "before": sorted(before), "after": sorted(after)}
    raise RuntimeError(f"Could not identify logical CPU {cpu}")


def targets(cpu):
    if platform.machine().lower() not in ("amd64", "x86_64"):
        raise RuntimeError("An x86-64 host is required")
    probe = windows_hardware if sys.platform == "win32" else linux_hardware
    model, isa, affinity = probe(cpu)
    if not isa["avx"] or not isa["avx2"]:
        raise RuntimeError("Enabled AVX and AVX2 are required for this eight-lane experiment")
    # Restrict codegen to the validated SIMD generation; record LLVM's host CPU separately.
    base = {"kind": "llvm", "mtriple": codegen.llvm_get_system_triple(),
            "mcpu": "x86-64", "mattr": ["+avx2"], "fast-math": False, "opt-level": 3}
    controlled = dict(base, **{"cl-opt": list(LLVM_NO_AUTO_VECTOR)})
    metadata = {
        "cpu": model, "llvm_host_cpu": codegen.llvm_get_system_cpu(), "os_enabled_isa": isa,
        "affinity": affinity, "llvm_major": codegen.llvm_version_major(),
        "targets": {"default": base, "controlled": controlled},
        "pass_context": {"vectorization_switch": VECTORIZATION_CONFIG, "tirx.enable_fast_math": False},
        "thread_environment": THREAD_SETTINGS, "tvm_runtime_threads": tvm.runtime.num_threads(),
    }
    if metadata["tvm_runtime_threads"] != 1:
        raise RuntimeError("TVM runtime did not select one thread")
    return base, controlled, metadata


def runtime_parts(exe, fused):
    library, = (m for m in exe.mod.imports if m.kind == "llvm")
    names = [line.split()[1] for line in vm_evidence(exe)["tensor_calls"]]
    if len(names) != (1 if fused else 2):
        raise RuntimeError(f"Unexpected VM TIR calls: {names}")
    return library, names


def preallocated_executable(library, names):
    """Use the identical packed kernels in a VM body taking caller buffers."""
    builder = relax.ExecBuilder()
    with builder.function("main", 4, ["gate", "up", "scratch", "out"]):
        gate, up, scratch, out = map(builder.r, range(4))
        if len(names) == 1:
            builder.emit_call(names[0], [gate, up, out])
        else:
            builder.emit_call(names[0], [gate, scratch])
            builder.emit_call(names[1], [scratch, up, out])
        builder.emit_ret(out)
    exe = builder.get()
    exe.mod.import_module(library)
    return exe


def first_call(fn, args):
    start = time.perf_counter_ns()
    output = fn(*args)
    elapsed = (time.perf_counter_ns() - start) / 1e3
    return output, elapsed


def sha(data):
    return hashlib.sha256(data).hexdigest()


def export_code(lib, path):
    hashes = {}
    for suffix, fmt in (("ll", "ll"), ("s", "asm")):
        file = path / f"module.{suffix}"
        dump(file, lib.inspect_source(fmt))
        hashes[suffix] = sha(file.read_bytes())
    return hashes


def build_cell(name, mod, path, target, data, expected, calls, warmup):
    mode, state = name.split("_")
    path.mkdir()
    start = time.perf_counter_ns()
    exe = compile_cpu(mod, target, vectorize=mode != "scalar")
    compile_ms = (time.perf_counter_ns() - start) / 1e6
    # Construct and invoke the VM before inspecting the library or resolving
    # direct packed symbols, so this call captures any remaining lazy JIT work.
    dev = tvm.cpu()
    start = time.perf_counter_ns()
    vm = relax.VirtualMachine(exe, dev, memory_cfg="pooled")
    main = vm["main"]
    vm_init_ms = (time.perf_counter_ns() - start) / 1e6
    result, first_us = first_call(main, data[:2])
    result = result.numpy()
    np.testing.assert_allclose(result, expected, rtol=3e-5, atol=3e-5)
    lib, names = runtime_parts(exe, state == "on")
    pre_exe = preallocated_executable(lib, names)
    pre_vm = relax.VirtualMachine(pre_exe, dev)
    pre_main = pre_vm["main"]
    gate, up, scratch, out = data
    scratch.copyfrom(np.full(expected.shape, np.nan, dtype="float32"))
    out.copyfrom(np.full(expected.shape, np.nan, dtype="float32"))
    _, pre_first_us = first_call(pre_main, data)
    np.testing.assert_array_equal(out.numpy().view("uint32"), result.view("uint32"))
    record = {"compile_ms": compile_ms, "vm_init_and_lookup_ms": vm_init_ms,
              "first_vm_us": first_us, "first_preallocated_us_after_vm": pre_first_us,
              "vm_max_abs_error": float(np.max(np.abs(result - expected))),
              "vm_equals_preallocated_bits": True, "kernels": names,
              "code_sha256": export_code(lib, path)}
    for label, executable in (("vm", exe), ("preallocated", pre_exe)):
        dump(path / f"{label}.txt", executable.as_text())
        save(path / f"{label}.json", vm_evidence(executable))
    for _ in range(warmup):
        main(gate, up)
        pre_main(*data)

    evaluators = {
        "vm": (vm.time_evaluator("main", dev, number=calls), data[:2]),
        "preallocated": (pre_vm.time_evaluator("main", dev, number=calls), data),
    }
    if state == "on":
        stages = {"kernel_fused": (names[0], (gate, up, out))}
    else:
        stages = {"kernel_silu": (names[0], (gate, scratch)), "kernel_multiply": (names[1], (scratch, up, out))}
    evaluators.update((label, (lib.time_evaluator(symbol, dev, number=calls), args))
                      for label, (symbol, args) in stages.items())
    return record, evaluators


def sample(cells, rounds, calls):
    samples = []
    for round_id in range(rounds):
        # Balanced Latin square: all positions and all ordered adjacent pairs
        # occur once per six rounds. Alternate the order of direct stages.
        order = [VARIANTS[(i + round_id) % 6] for i in (0, 1, 5, 2, 4, 3)]
        for position, name in enumerate(order):
            cell = cells[name]
            groups = [("vm",), ("preallocated",), tuple(key for key in cell if key.startswith("kernel_"))]
            if ((round_id // 6) + (round_id % 6)) % 2:
                groups[2] = groups[2][::-1]
            offset = round_id % 3
            order_us = []
            for group in groups[offset:] + groups[:offset]:
                for label in group:
                    fn, args = cell[label]
                    seconds, = fn(*args).results
                    order_us.append({"scope": label, "us_per_call": seconds * 1e6})
            samples.append({"round": round_id + 1, "position": position + 1, "variant": name,
                            "calls_per_sample": calls, "measurements_in_order": order_us})
    return samples


def run_shape(shape, path, base, controlled, rounds, warmup, calls):
    path.mkdir()
    rng = np.random.default_rng(SEED)
    gate = (rng.standard_normal(shape) * 5).astype("<f4")
    up = rng.standard_normal(shape).astype("<f4")
    hashes = {"gate": sha(gate.tobytes()), "up": sha(up.tobytes())}
    expected = (gate / (np.float32(1) + np.exp(-gate))) * up
    data = (tvm.runtime.tensor(gate), tvm.runtime.tensor(up),
            tvm.runtime.empty(shape, "float32"), tvm.runtime.empty(shape, "float32"))
    original = example(shape)
    dump(path / "before.py", original.script())
    records, cells, probes = {}, {}, {}
    for fused, state in ((False, "off"), (True, "on")):
        after = FuseSwiGLU(enabled=fused, dense_inputs=True)(original)
        legalized = legalize_swiglu(after)
        scheduled = strip_mine_fp32(legalized)
        for label, mod in (("after", after), ("legalized", legalized), ("scheduled", scheduled)):
            dump(path / f"{label}_{state}.py", mod.script())
        for mode, mod, target in (("default", legalized, base), ("scalar", scheduled, controlled),
                                  ("simd", scheduled, controlled)):
            key = f"{mode}_{state}"
            records[key], cells[key] = build_cell(key, mod, path / key, target, data, expected, calls, warmup)
        probe = compile_cpu(legalized, base, vectorize=False)
        lib, _ = runtime_parts(probe, fused)
        probe_path = path / f"unscheduled_disable_{state}"
        probe_path.mkdir()
        probe_hash = export_code(lib, probe_path)
        probes[state] = {"code_sha256": probe_hash, "identical": probe_hash == records[f"default_{state}"]["code_sha256"]}
    return {"shape": shape, "input_sha256_le_fp32_c_order": hashes, "builds": records, "tir_toggle_probe": probes,
            "samples": sample(cells, rounds, calls)}


def summarize(rows):
    lines = ["| Shape | Cell | Scope | Median µs | IQR µs | Min µs | Max µs |",
             "|---|---|---|---:|---:|---:|---:|"]
    for row in rows:
        for name in VARIANTS:
            results = {}
            for sample_row in row["samples"]:
                if sample_row["variant"] == name:
                    for measure in sample_row["measurements_in_order"]:
                        results.setdefault(measure["scope"], []).append(measure["us_per_call"])
            for scope, values in results.items():
                q1, _, q3 = statistics.quantiles(values, n=4)
                shape = "×".join(map(str, row["shape"]))
                lines.append(f"| {shape} | {name} | {scope} | {statistics.median(values):.3f} | "
                             f"{q3-q1:.3f} | {min(values):.3f} | {max(values):.3f} |")
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True, help="New directory for the run")
    parser.add_argument("--cpu", type=int, help="Logical CPU within the current affinity mask")
    parser.add_argument("--rounds", type=int, default=12)
    parser.add_argument("--warmup", type=int, default=8)
    parser.add_argument("--smoke", action="store_true", help="Compile and exercise one tail shape with one call per sample")
    args = parser.parse_args()
    if args.warmup < 1 or args.rounds < 6 or args.rounds % 6 or (args.cpu is not None and args.cpu < 0):
        parser.error("Positive warmup, rounds divisible by six, and a nonnegative CPU are required")
    base, controlled, hardware = targets(args.cpu)
    args.output.mkdir(parents=True)
    info = environment()
    # Record source digests instead of unrelated untracked filenames or machine paths.
    info.pop("git_status")
    info.update(hardware, numpy=version("numpy"), pytest=version("pytest"), seed=SEED, vector_width=VECTOR_WIDTH,
                rounds=args.rounds, explicit_warmup_calls=args.warmup, smoke=args.smoke,
                source_sha256={name: sha((ROOT / name).read_bytes()) for name in
                               ("benchmarks/tvm_swiglu_x86.py", "src/swiglu_tvm/cpu.py",
                                "src/swiglu_tvm/fusion.py", "src/swiglu_tvm/operator.py")})
    save(args.output / "environment.json", info)
    rows = []
    for shape, calls in ((((1025,), 1),) if args.smoke else zip(SHAPES, (512, 32, 8, 1024, 1024))):
        label = "x".join(map(str, shape))
        print(f"Running {label} ({calls} calls per sample)", flush=True)
        rows.append(run_shape(shape, args.output / label, base, controlled, args.rounds, args.warmup, calls))
        save(args.output / "raw.json", rows)
        dump(args.output / "summary.md", summarize(rows))
    save(args.output / "status.json", {"status": "passed", "shapes": [row["shape"] for row in rows]})


if __name__ == "__main__":
    main()
