# Building with Bazel

This guide covers building, testing, and running code using Bazel.

## Quick Start

```bash
# Build all targets
bazel build //...

# Build in debug mode
bazel build //... -c dbg

# Build in optimized mode
bazel build //... -c opt
```

## Useful Commands

### Building

```bash
# Build all targets
bazel build //...

# Build a specific library
bazel build //lib/example_lib

# Build a specific application
bazel build //app/example_app

# Build with specific config
bazel build //... --config=debug
bazel build //... --config=opt
bazel build //... --config=linux_llvm
```

### Running

```bash
# Run an application
bazel run //app/example_app

# Run with arguments
bazel run //app/example_app -- arg1 arg2
```

### Testing

```bash
# Run all tests
bazel test //tests/...

# Run specific test
bazel test //tests/unit:test_example_lib

# Run tests with verbose output
bazel test //tests/... --test_output=all

# Run tests in debug mode
bazel test //tests/... -c dbg
```

### Code Coverage

```bash
# Generate code coverage report (LLVM coverage)
bazel coverage --config=debug //tests/...

# Coverage reports are in bazel-out/
```

### Cleaning

```bash
# Clean build artifacts
bazel clean

# Clean everything including cache
bazel clean --expunge
rm -rf .cache/bazel_cache
```

## Build Configurations

Defined in `.bazelrc`:

### Debug Mode
```bash
bazel build //... --config=debug
```
- Compilation: `-O0`
- Symbols: `-g`
- Sanitizers: AddressSanitizer + UBSan
- Features: Layering checks, sandbox debug

### Optimize Mode
```bash
bazel build //... --config=opt
```
- Compilation: `-O3 -march=native`
- Stripped binary: Yes
- NDEBUG: Defined

### Profile Mode
```bash
bazel build //... --config=profile
```
- Tracks build time and optimization passes
- Output: `profile.gz`

### Coverage Mode
```bash
bazel coverage --config=debug //tests/...
```
- LLVM Coverage instrumentation
- Output format: LCOV

### Linux with LLVM (Homebrew)
```bash
bazel build //... --config=linux_llvm
```
- Uses LLVM from Homebrew
- Sets clang/clang++/lld toolchain
- Platform: Linux x86_64

## Using justfile

The `justfile` provides convenient shortcuts:

```bash
# See all available recipes
just --list

# Build all
just build-opt

# Run example app
just run-example

# Run all tests
just test

# Generate coverage
just coverage

# Clean everything
just clean-full

# Format code
just format
```

## Bazel Concepts

### Targets

- `//lib/example_lib` - Library target (cc_library)
- `//app/example_app` - Application target (cc_binary)
- `//tests/unit:test_example_lib` - Test target (cc_test)

### Dependencies

Dependencies are declared in BUILD files:
```python
deps = [
    "//lib/example_lib",  # Depends on example_lib
    "@unity",              # External dependency (Unity test framework)
]
```

### Labels

- `:target_name` - Target in current package
- `//package:target` - Target in specific package
- `@repository//package:target` - External repository target

## Compiler Flags

Default compiler flags (in `tools/build/cc_rules.bzl`):
- `-Wall -Wextra -Wpedantic` - Warnings
- `-std=c11` - C11 standard
- `-lm` - Link math library

Platform-specific flags are configured in `.bazelrc`.

## Troubleshooting

### Bazel version mismatch
Check `.bazelversion` - ensure your Bazel installation matches.

### Rebuilding everything
```bash
bazel clean --expunge
bazel build //...
```

### Cache issues
```bash
rm -rf .cache/bazel_cache
bazel build //...
```

### Debugging builds
```bash
bazel build //... -s  # Show detailed command lines
bazel analyze //...   # Analyze dependencies
bazel query '...'     # Query targets and dependencies
```

### Verbose test output
```bash
bazel test //tests/... --test_output=all --verbose_failures
```

## References

- [Bazel Documentation](https://docs.bazel.build/)
- [Bazel C++ Rules](https://github.com/bazelbuild/rules_cc)
- [Platform Documentation](https://github.com/bazelbuild/platforms)
