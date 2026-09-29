# Result provenance

GPU measurements were run by the user on AutoDL T4. No GPU measurements were
executed by the packaging environment.

## Original server evidence received on 2026-09-29

The user supplied `swiglu-t4-server-final-20260929.tar.gz` (100421 bytes).
Its SHA256 is
`0bfde6ab3543542c43267c19d0ec4b066c0fbb7bdd1383fba29ba366fd3eb980`.
Archive integrity and paths were checked before importing results.

All 38 original result files in the archive were copied byte-for-byte.
`server_archive_manifest.json` lists each imported path, size and SHA256.
Original CSV line endings are preserved through `.gitattributes`.
Server Git metadata and older source/documentation files were not imported.

The original final generation and CUDA Graph JSON files match the previously
archived records. All six rows in `t4_fp16_div.json` match the terminal
transcription; the original now also supplies its full metadata. Earlier
reconstructed result JSON files agree in parsed values. Original files replace
those transcriptions, including original CSV files and profiler tables.

The backup also supplies the previously missing detailed evidence:

- `t4_tinyllama_prefill_decode_fp16.json`
- `t4_tinyllama_accuracy_layers_fp16.json`
- `t4_swiglu_math/fp16_operator_checks.json`
- `t4_swiglu_math/libdevice_div_layer_accuracy.json`
- Generation profiler event records and A/B/A profiler tables and events.

## Derived summaries

`t4_diagnostics_summary_20260929.json` and
`t4_tinyllama_profile_aba/summary.json` remain derived summaries of reported
experiments. They are not original server result files and are not included
in the original-file manifest. Consult the detailed original files for raw
records and their scope.

## Historical results and interpretation

The experiment log in `docs/t4_baseline_20260927.md` records the experiment
sequence and earlier archive provenance. Historical sigmoid-path accuracy
failures and timings describe the earlier implementation. They must not be
presented as measurements of the corrected division kernel.

Final generation validation passed for the recorded prompt and checkpoint.
The CUDA Graph experiment measures repeated fixed-shape forwards without KV
cache or generation. Neither result establishes correctness or speedup for
all prompts, models or serving workloads.

## Verification

Packaging checks validate original-file hashes and structured result data.
They do not replace execution on a GPU. Keep the uploaded server archive as
an additional backup; the repository preserves its result files and hash
manifest without including the archive itself.
