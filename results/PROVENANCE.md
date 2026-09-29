# Result provenance

No GPU measurements were executed by the packaging environment. Measurements
were run by the user on AutoDL T4 and supplied through uploaded artifacts or
terminal output. The repository records the distinction below.

## Final 2026-09-29 results

| File | Source and completeness |
| --- | --- |
| `t4_fp16_div.json` | All six printed result rows transcribed exactly. The original JSON wrapper was not supplied; no measurement timestamp was invented. |
| `t4_fp16_div.csv` | CSV generated from the transcribed six rows, not an uploaded original CSV. |
| `t4_tinyllama_generate_fp16_div.json` | Complete displayed JSON transcribed from the user's terminal, including raw repetitions. Formatting is regenerated; original file bytes were not received. |
| `t4_tinyllama_cudagraph_control_fp16.json` | Complete displayed JSON transcribed, including raw wall/submission measurements, orders and validation. Original file bytes were not received. |
| `t4_tinyllama_full_mlp_compile_fp16.json` | Complete displayed full-MLP compiler result transcribed before the numerical fix. |
| `t4_diagnostics_summary_20260929.json` | Explicit summary of the displayed prefill/decode, layer and arithmetic experiments; not their complete original JSON. |

Original files still on the T4 include
`t4_tinyllama_prefill_decode_fp16.json`,
`t4_tinyllama_accuracy_layers_fp16.json`,
`t4_swiglu_math/fp16_operator_checks.json` and
`t4_swiglu_math/libdevice_div_layer_accuracy.json`.
These full files have not been supplied to the packaging environment. Retain
the server backup to preserve their detailed records and additional traces.

## Historical results

The 2026-09-27 experiment log in `docs/t4_baseline_20260927.md` records sources
and uploaded archive hashes for earlier baselines and operator profiles.
Earlier JSON, profile tables and available traces remain unchanged. Their
sigmoid-path accuracy failures and performance apply to the earlier code,
not to an unmeasured run of the corrected division kernel.

## Checking and updating

Packaging checks recompute reported medians and speedup ratios from retained
raw values, validate JSON and CSV correspondence, and verify archive bytes.
Such checks do not replace execution on a GPU. If originals are later
uploaded, compare their values, replace the transcriptions with the original
bytes where appropriate, and update this provenance file in the same commit.
Do not invent absent timestamps, raw samples or profile traces.
