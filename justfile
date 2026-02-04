# Justfile: Common build commands for C Template Project
# Usage: just [recipe] [options]

# Show help
help:
    just --list

# Default: build all targets
default:
    bazel build //...

# Build all targets in debug mode
build-debug:
    bazel build //... -c dbg

# Build all targets in opt mode
build-opt:
    bazel build //... -c opt --define=NDEBUG=1

# Build a specific library

# Usage: just build-lib example_lib
build-lib LIB:
    bazel build //lib/{{ LIB }}

# Build a specific app

# Usage: just build-app example_app
build-app APP:
    bazel build //app/{{ APP }}

# Run a specific app

# Usage: just run example_app
run APP:
    bazel run //app/{{ APP }}

# Run example app
run-example:
    bazel run //app/example_app

# Run all unit tests
test:
    bazel test //tests/...

# Run tests in debug mode with verbose output
test-debug:
    bazel test //tests/... -c dbg --config=debug --test_output=all

# Run a specific test

# Usage: just test-one test_example_lib
test-one TEST:
    bazel test //tests/unit:{{ TEST }}

# Generate code coverage
coverage:
    bazel coverage --config=debug //tests/... && \
    echo "Coverage report generated in bazel-out/"

# Clean all build artifacts
clean:
    bazel clean --expunge

# Remove cache
clean-cache:
    rm -rf .cache/bazel_cache

# Full clean (artifacts + cache)
clean-full: clean clean-cache

# Refresh compile_commands.json for IDE integration
refresh-compile-commands:
    bazel run //:refresh_compile_commands

# Build and run tests
build-test: default test

# Platform-specific build for Linux (with Homebrew LLVM)
build-linux:
    bazel build //... --config=linux_llvm

# Build with ASAN (Address Sanitizer)
build-asan:
    bazel build //... --config=debug --copt=-fsanitize=address --copt=-fsanitize=undefined

# Static analysis with clang-tidy
lint:
    bazel build //... --config=tidy

# Format code (requires clang-format)
format:
    find . -name "*.c" -o -name "*.h" | grep -v bazel-out | xargs clang-format -i

# Profile build
profile:
    bazel build //... --config=profile && \
    echo "Profile saved to profile.gz"

# Query targets
query PATTERN='//...':
    bazel query {{ PATTERN }}

# List all libraries
list-libs:
    bazel query 'kind(cc_library, //lib/...)'

# List all applications
list-apps:
    bazel query 'kind(cc_binary, //app/...)'

# List all tests
list-tests:
    bazel query 'kind(cc_test, //tests/...)'

# Print workspace info
info:
    bazel info
    echo ""
    echo "Git Info:"
    git log --oneline -1
    git branch -v
