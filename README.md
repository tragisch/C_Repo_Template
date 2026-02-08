# C Repo Template

A template for C projects using:

- **Bazel 9** with Bzlmod for dependency management
- **LLVM Toolchain** (20.1.0) via `toolchains_llvm` for consistent builds across platforms
- **ThrowTheSwitch Unity** for unit testing
- **Target Platforms:** macOS ARM64, Linux x86_64

## Prerequisites

- [Bazel 9+](https://bazel.build/) (via Bazelisk recommended)
- Xcode Command Line Tools (macOS)
- (Optional) direnv for automatic environment setup

## Quick Start

```bash
# Initialize Bazel environment (repo cache, etc.)
bash tools/setup/init_bazel_env.sh

# Build everything
bazel build //...

# Run tests
bazel test //...

# Run the example application
bazel run //app:example_app
```

## Build Configurations

| Config   | Command                              | Description                     |
| -------- | ------------------------------------ | ------------------------------- |
| Default  | `bazel build //...`                  | Standard build                  |
| Debug    | `bazel build --config=debug //...`   | Debug + ASAN/UBSAN              |
| Release  | `bazel build --config=opt //...`     | Optimized (`-O3 -march=native`) |
| Profile  | `bazel build --config=profile //...` | Profiling (`-ftime-report`)     |
| Coverage | `bazel coverage //...`               | LLVM code coverage (lcov)       |

## Coverage Report (HTML)

Das Template bringt `bazelcov` mit, um aus `bazel coverage` einen HTML‑Report
zu erzeugen. Voraussetzung: `genhtml` ist installiert (z. B. via `brew install lcov`).

Standard-Ausgabeort: `docs/coverage`

```bash
# HTML-Report für das gesamte Repo
bazel run //:coverage_html

# Nur bestimmte Targets
bazel run //:coverage_html -- //app/... //tests/...
```

## Native Linux Builds

```bash
# On Linux (native), same toolchain setup via LLVM
bazel build //...
```

## Tooling (direnv + multitool)

This template uses LLVM via Bazel toolchains and can fetch developer tools
through `rules_multitool`.

### direnv

Enable automatic environment loading:

```bash
direnv allow
```

Optionally add local overrides to `.env` (e.g. `CC`/`CXX`), which are loaded by
`.envrc`.

### bazel_env

Activate the full developer toolchain (adds tools to your PATH):

```bash
bazel run //tools:bazel_env
```

Refresh your shell hash table if needed:

```bash
rehash
```

### rules_multitool

The lockfile lives at `tools/tools.lock.json`. Add tools there and they become
available as Bazel toolchains. Example usage:

```bash
bazel run @multitool//tools/<tool-name>:cwd -- --help
```

## Project Structure

```
app/              # Application targets (cc_binary, cc_library)
config/platforms/ # Platform definitions (macOS, Linux, etc.)
tests/unit/       # Unit tests (Unity framework)
third_party/      # External library BUILD files
tools/            # Build tooling, compiler flags, macros
```

## Dependencies

All external dependencies are managed via `MODULE.bazel` (Bzlmod).
See [MODULE.bazel](MODULE.bazel) for the full list.
   
