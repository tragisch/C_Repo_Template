# C Repo Template

A C repository template using Bazel 9 + Bzlmod, LLVM toolchains, and Unity tests.
Targets: macOS ARM64 and Linux x86_64.

## Requirements

- [Bazel 9+](https://bazel.build/) (Bazelisk recommended)
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
- Coverage: `bazel coverage //...` then `bazel run //:coverage_html`
- Compile commands: `bazel run //:refresh_compile_commands`

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

## Notes

- `direnv allow` enables optional environment loading via `.envrc`.
- `bazel run //tools:bazel_env` adds the full developer toolchain to PATH.
