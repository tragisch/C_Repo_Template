# C Repo Template

A template for C projects using:

- **Bazel 9** with Bzlmod for dependency management
- **LLVM Toolchain** (20.1.0) via `toolchains_llvm` for consistent builds across platforms
- **ThrowTheSwitch Unity** for unit testing
- **Target Platforms:** macOS ARM64, Linux x86_64

## Prerequisites

- [Bazel 9+](https://bazel.build/) (via Bazelisk recommended)
- Xcode Command Line Tools (macOS)

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

| Config | Command | Description |
|--------|---------|-------------|
| Default | `bazel build //...` | Standard build |
| Debug | `bazel build --config=debug //...` | Debug + ASAN/UBSAN |
| Release | `bazel build --config=opt //...` | Optimized (`-O3 -march=native`) |
| Profile | `bazel build --config=profile //...` | Profiling (`-ftime-report`) |
| Benchmark | `bazel build --config=benchmark //...` | Benchmark build |
| Coverage | `bazel coverage //...` | LLVM code coverage (lcov) |

## Cross-Compilation

```bash
# Build for Linux (using Homebrew LLVM)
bazel build --config=linux_llvm //...
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
   
