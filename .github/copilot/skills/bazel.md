---
description: "Bazel/Starlark conventions for this repo"
applyTo: "**/*.{bzl,BUILD,BUILD.bazel,MODULE.bazel,bazelrc,.bazelrc}"
---

# Bazel / Starlark (C Repo Template)

- No source globs; list `srcs`/`hdrs` explicitly.
- Prefer tight `visibility`; avoid `//visibility:public` unless required.
- Always list `deps` explicitly.
- Attribute order: `name`, `srcs`/`hdrs`, `includes`/`strip_include_prefix`, `deps`, `visibility`, `target_compatible_with`, other attrs.
- Use `target_compatible_with` with `@platforms` when platform-specific; if unsure, add TODO instead of guessing.
- External deps go in `MODULE.bazel` with pinned versions; avoid ad‑hoc repository rules.
- Prefer structured rules over `genrule`/`run_shell` for simple tasks.
- Keep `.bzl` macros small and documented (short docstring with purpose + key args).
- For tests, use the `unity_test` macro from `//:tools/unity_test.bzl` when appropriate.
