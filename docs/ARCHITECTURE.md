# Architecture

This document describes the overall structure and design decisions of the C Template project.

## Overview

This is a modern C development template optimized for:
- **macOS** (Apple Silicon & Intel)
- **Linux** (x86_64)
- **Build System**: Bazel with Bzlmod
- **Testing**: Unity framework
- **Code Quality**: Clang-tidy, ASAN/UBSAN

## Directory Structure

### `/lib/` - Reusable Libraries

Contains all shareable C libraries. Each library has its own directory:

```
lib/
├── example_lib/
│   ├── BUILD                # Bazel rules for this library
│   ├── include/             # Public headers
│   │   └── example_lib.h
│   └── src/                 # Implementation
│       ├── example_lib.c
│       └── example_lib_*.c  # Platform-specific implementations
```

**Design Principles:**
- One library per directory
- Headers in `include/`
- Implementation in `src/`
- Platform-specific code suffixed (e.g., `_arm64.c`, `_x86_64.c`)

### `/app/` - Executable Applications

Contains all executable programs:

```
app/
├── example_app/
│   ├── BUILD                # Bazel rules
│   ├── include/             # Private headers (app-only)
│   └── src/
│       └── main.c
```

**Design Principles:**
- One application per directory
- Each app has its own `main.c`
- Can depend on any library in `/lib/`

### `/tests/` - Test Suite

Organized by test type:

```
tests/
├── unit/                    # Unit tests
│   ├── BUILD
│   └── test_*.c             # One test per library/module
├── integration/             # Integration tests (optional)
└── coverage/                # Generated coverage data
```

**Testing Strategy:**
- **Unit Tests**: Test individual libraries
- **Unity Framework**: For simplified C testing (no C++ required)
- **Coverage**: LLVM-based coverage reports

### `/tools/` - Build Tools & Scripts

```
tools/
├── build/
│   ├── BUILD
│   ├── cc_rules.bzl         # Helper macros for C/C++ targets
│   └── test_rules.bzl       # Test helper macros (future)
└── scripts/
    ├── workspace_status.sh  # Git metadata for builds
    └── coverage_wrapper.sh  # Coverage report generation
```

**Key Files:**
- `cc_rules.bzl`: Provides `c_lib()`, `c_bin()`, `c_test()` macros
  - Standardizes compiler flags
  - Ensures consistent linker options
  - Simplifies BUILD file syntax

### `/config/` - Build Configuration

```
config/
├── BUILD
└── platforms/
    └── BUILD                # Platform definitions
```

**Platform Targets:**
- `@platforms//os:macos` + `@platforms//cpu:arm64`
- `@platforms//os:linux` + `@platforms//cpu:x86_64`

### `/docs/` - Documentation

```
docs/
├── BUILD.md                 # Building guide
├── DEVELOPMENT.md           # Setup & workflow guide
└── ARCHITECTURE.md          # This file
```

## Build System Design

### Bazel & Bzlmod

**Advantages:**
- Cross-platform support (macOS, Linux, Windows)
- Fine-grained dependency management
- Hermetic, reproducible builds
- Excellent for monorepos

**Configuration:**
- `MODULE.bazel`: Declares module + external dependencies
- `.bazelrc`: Build configurations (debug, opt, coverage, etc.)

### Helper Macros (cc_rules.bzl)

Instead of repeating full `cc_library` definitions, we use helpers:

```python
# Instead of:
cc_library(
    name = "mylib",
    srcs = ["mylib.c"],
    hdrs = ["mylib.h"],
    copts = ["-Wall", "-Wextra", "-std=c11"],
    linkopts = ["-lm"],
    ...
)

# Use:
c_lib(
    name = "mylib",
    srcs = ["mylib.c"],
    hdrs = ["mylib.h"],
)
```

**Benefits:**
- Reduced boilerplate
- Consistent compiler flags
- Easy to update defaults

## Dependency Model

```
    /app/example_app
          ↓
    /lib/example_lib
          ↓
    @unity (external)
```

**Principles:**
- `app/` depends on `lib/`
- `lib/` should not depend on `app/`
- External dependencies declared in `MODULE.bazel`
- No circular dependencies (Bazel enforces this)

## Compilation Configurations

### Debug (default for development)
```bash
bazel build //... --config=debug
```
- Optimization: `-O0`
- Symbols: `-g` (with frame pointers)
- Sanitizers: ASAN + UBSAN
- Use for: Development, testing, debugging

### Optimize (release)
```bash
bazel build //... --config=opt
```
- Optimization: `-O3 -march=native`
- Stripped: Yes
- NDEBUG: Defined
- Use for: Production builds, benchmarking

### Profile
```bash
bazel build //... --config=profile
```
- Tracks compiler optimizations
- Generates `profile.gz` for analysis
- Use for: Performance analysis

### Coverage
```bash
bazel coverage --config=debug //tests/...
```
- LLVM coverage instrumentation
- Generates LCOV reports
- Use for: Test coverage analysis

## Testing Architecture

### Unit Tests with Unity

Each library X has `tests/unit/test_X.c`:

```c
#include "unity.h"
#include "X.h"

void test_function_a(void) {
    TEST_ASSERT_EQUAL_INT(expected, actual);
}

int main(void) {
    UNITY_BEGIN();
    RUN_TEST(test_function_a);
    return UNITY_END();
}
```

**Features:**
- No C++ runtime required
- Simple assertion macros
- Clear test output
- BAZEL integration via `c_test()`

## Platform-Specific Code

For platform-specific implementations:

```
lib/mylib/src/
├── mylib.c           # Common implementation
├── mylib_arm64.c     # ARM64-specific (macOS)
└── mylib_x86_64.c    # x86_64-specific (Linux)
```

**Selection via BUILD:**
```python
c_lib(
    name = "mylib",
    srcs = select({
        "@platforms//cpu:arm64": ["src/mylib.c", "src/mylib_arm64.c"],
        "@platforms//cpu:x86_64": ["src/mylib.c", "src/mylib_x86_64.c"],
    }),
    ...
)
```

## Code Quality Tools

### Compiler Warnings
```bash
# In .bazelrc:
build --copt=-Wall
build --copt=-Wextra
build --copt=-Wpedantic
build --copt=-Werror=implicit-function-declaration
```

### Clang-tidy (Static Analysis)
```bash
just lint  # Uses .clang-tidy config
```

### Address Sanitizer (Runtime)
```bash
bazel build //... --config=debug  # Includes ASAN/UBSAN
```

### Code Coverage
```bash
bazel coverage //tests/...
# Generates: bazel-out/_coverage/...
```

## External Dependencies

Managed via `MODULE.bazel` with Bzlmod:

```python
# C/C++ Rules
bazel_dep(name = "rules_cc", version = "0.1.2")

# Platform definitions
bazel_dep(name = "platforms", version = "0.0.11")

# LLVM Toolchain
bazel_dep(name = "toolchains_llvm", version = "1.6.0")

# Testing
# Unity (via http_archive in MODULE.bazel)
```

## Development Workflow

1. **Create a new library**
   ```bash
   mkdir -p lib/mylib/{include,src}
   # Create files...
   bazel build //lib/mylib
   ```

2. **Write tests**
   ```bash
   mkdir -p tests/unit
   # Create test_mylib.c
   bazel test //tests/unit:test_mylib
   ```

3. **Create an app**
   ```bash
   mkdir -p app/myapp/src
   # Create main.c
   bazel build //app/myapp
   bazel run //app/myapp
   ```

4. **Check code quality**
   ```bash
   just format   # Format code
   just lint     # Run clang-tidy
   just coverage # Generate coverage report
   ```

## Performance Considerations

### Build Caching
- Local disk cache: `.cache/bazel_cache`
- Remote caching: Configured in `.bazelrc` (commented)

### Incremental Builds
- Bazel only rebuilds changed targets
- Dependency tracking ensures correctness

### Platform-Specific Optimizations
- ARM64 (macOS): Can use NEON intrinsics
- x86_64 (Linux): Can use AVX/AVX2

## Future Extensions

Potential additions:
- **Integration tests**: `tests/integration/`
- **Benchmarks**: `benchmarks/` with Google Benchmark
- **Documentation**: Doxygen integration
- **CI/CD**: GitHub Actions, GitLab CI
- **Fuzzing**: libFuzzer targets

## Design Decisions

| Decision                    | Rationale                                     |
| --------------------------- | --------------------------------------------- |
| Bazel over Make             | Hermetic, language-agnostic, scales well      |
| Bzlmod over WORKSPACE       | Modern, cleaner dependency management         |
| Unity over other frameworks | Pure C, no C++ runtime, simple                |
| Helper macros               | DRY principle, consistency                    |
| Platform abstraction        | Support macOS + Linux from one codebase       |
| LLVM toolchain              | Consistent across platforms, modern C support |

## See Also

- [BUILD.md](BUILD.md) - Building guide
- [DEVELOPMENT.md](DEVELOPMENT.md) - Setup & workflow
- [Bazel Documentation](https://docs.bazel.build/)
