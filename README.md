# C Repo Template

A C repository template using Bazel 9 + Bzlmod, LLVM toolchains, and Unity tests.
Targets: macOS ARM64 and Linux x86_64.

## Requirements

- [Bazel 9+](https://bazel.build/) (Bazelisk recommended)
- [Ruby](https://www.ruby-lang.org/) (for Unity test runner generation)
- Xcode Command Line Tools (macOS)
- Optional: `direnv`, `lcov` (for HTML coverage)

## Quick Start

```bash
bash tools/setup/init_bazel_env.sh
bazel build //...
bazel test //...
bazel run //apps/example_app:example_app
```

## Common Tasks

- Debug build: `bazel build --config=debug //...`
- Release build: `bazel build --config=opt //...`
- Format code: `bazel run //tools/format:format`
- DWYU check: `bazel build --config=dwyu //...`
- Coverage: `bazel coverage //...` then `bazel run //:coverage_html`
- Compile commands: `bazel run //:refresh_compile_commands`
- License report: `bazel build //tools/license:license_report`
- SBOM generation: `bazel build //tools/license:sbom`

## Structure

```
apps/example_app/   # Demo binary
apps/example_lib/   # Demo library
tests/test_example_lib/ # Unity tests
config/platforms/   # Platform definitions
third_party/        # External BUILD files
tools/              # Build tooling
docs/coverage/      # Coverage HTML output
```

## Tooling

- **Formatting**: `clang-format` (C) + `buildifier` (Starlark) via `aspect_rules_lint`
- **Static Analysis**: `.clang-tidy` configured with `bugprone-*`, `cert-*` checks
- **DWYU**: "Depend on What You Use" aspect for dependency hygiene
- **License/SBOM**: `rules_license` integration with SPDX 2.3 SBOM generation
- **Coverage**: LLVM-based coverage with HTML report generation

## Notes

- `direnv allow` enables optional environment loading via `.envrc`.
- `bazel run //tools:bazel_env` adds the full developer toolchain to PATH.

## How to Use This Template

1. Clone/fork this repo or use it as a GitHub template
2. Update `module(name = "...")` in `MODULE.bazel` to your project name
3. Rename/replace `apps/example_app/` and `apps/example_lib/` with your code
4. Update `tests/` with your own test files
5. Run `bash tools/setup/init_bazel_env.sh` to initialize the environment
6. `bazel build //...` and `bazel test //...` to verify everything works
