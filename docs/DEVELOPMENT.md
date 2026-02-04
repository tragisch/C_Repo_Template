# Development Setup

This guide covers setting up your development environment for C development with Bazel.

## Prerequisites

### macOS

1. **Xcode Command Line Tools**
   ```bash
   xcode-select --install
   ```

2. **Homebrew** (if not installed)
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. **Build Tools**
   ```bash
   brew install bazel
   brew install llvm
   brew install clang-format
   ```

4. **Optional: direnv** (for automatic environment setup)
   ```bash
   brew install direnv
   # Add to your shell config (~/.zshrc, ~/.bash_profile):
   eval "$(direnv hook zsh)"  # or bash
   direnv allow /path/to/project
   ```

### Linux (Ubuntu/Debian)

1. **LLVM and Build Tools**
   ```bash
   sudo apt-get update
   sudo apt-get install -y \
       build-essential \
       clang \
       llvm \
       lld \
       clang-format \
       git
   ```

2. **Bazel** (using Homebrew on Linux)
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   brew install bazel
   ```

3. **direnv** (optional)
   ```bash
   sudo apt-get install direnv
   # Add to your shell config
   eval "$(direnv hook bash)"
   ```

## IDE Setup

### Visual Studio Code

1. **Install Extensions**
   - C/C++ (Microsoft)
   - Bazel (Bazel Build Tools)
   - clang-format (xaver)

2. **Configure Workspace Settings** (`.vscode/settings.json`)
   ```json
   {
       "C_Cpp.default.intelliSenseEngine": "Tag Parser",
       "[c]": {
           "editor.formatOnSave": true,
           "editor.defaultFormatter": "xaver.clang-format"
       },
       "clang-format.style": "LLVM",
       "files.exclude": {
           "bazel-*": true,
           ".cache": true
       }
   }
   ```

3. **Refresh Compile Commands**
   ```bash
   bazel run //:refresh_compile_commands
   ```

### CLion

1. Open project
2. Configure project to use Bazel
3. In Settings → Languages & Frameworks → C/C++ → Toolchains
   - Set compiler to Clang

## Project Structure

```
c-template/
├── lib/                    # Reusable libraries
│   └── example_lib/        # Example library
│       ├── include/        # Public headers
│       ├── src/            # Implementation
│       └── BUILD           # Bazel build rules
├── app/                    # Executable applications
│   └── example_app/        # Example application
│       ├── src/
│       └── BUILD
├── tests/                  # Test suite
│   ├── unit/               # Unit tests
│   └── BUILD
├── tools/                  # Build tools and scripts
│   ├── build/              # Build macros
│   │   └── cc_rules.bzl    # C/C++ helper macros
│   └── scripts/
├── docs/                   # Documentation
├── MODULE.bazel            # Bazel module definition
├── .bazelrc               # Bazel configuration
├── .bazelversion          # Bazel version pin
├── .clang-tidy            # Clang-tidy configuration
├── .envrc                 # direnv setup
└── justfile               # Just command recipes
```

## Creating a New Library

1. **Create directory structure**
   ```bash
   mkdir -p lib/mylib/{include,src}
   ```

2. **Create header file** (`lib/mylib/include/mylib.h`)
   ```c
   #ifndef MYLIB_H
   #define MYLIB_H
   
   int myfunction(int x);
   
   #endif
   ```

3. **Create source file** (`lib/mylib/src/mylib.c`)
   ```c
   #include "mylib.h"
   
   int myfunction(int x) {
       return x * 2;
   }
   ```

4. **Create BUILD file** (`lib/mylib/BUILD`)
   ```python
   load("//tools/build:cc_rules.bzl", "c_lib")
   
   c_lib(
       name = "mylib",
       srcs = ["src/mylib.c"],
       hdrs = ["include/mylib.h"],
       strip_include_prefix = "include",
       visibility = ["//visibility:public"],
   )
   ```

## Creating Tests

1. **Create test file** (`tests/unit/test_mylib.c`)
   ```c
   #include "unity.h"
   #include "mylib.h"
   
   void test_myfunction(void) {
       TEST_ASSERT_EQUAL_INT(10, myfunction(5));
   }
   
   int main(void) {
       UNITY_BEGIN();
       RUN_TEST(test_myfunction);
       return UNITY_END();
   }
   ```

2. **Add to BUILD file** (`tests/unit/BUILD`)
   ```python
   load("//tools/build:cc_rules.bzl", "c_test")
   
   c_test(
       name = "test_mylib",
       srcs = ["test_mylib.c"],
       deps = ["//lib/mylib"],
   )
   ```

3. **Run tests**
   ```bash
   bazel test //tests/unit:test_mylib
   ```

## Common Workflows

### Building & Running

```bash
# Build all
bazel build //...

# Run an application
bazel run //app/example_app

# Build specific target
bazel build //lib/mylib

# Build with optimizations
bazel build //... -c opt
```

### Testing

```bash
# Run all tests
bazel test //tests/...

# Run specific test
bazel test //tests/unit:test_mylib

# Run tests with verbose output
bazel test //tests/... --test_output=all

# Generate coverage
bazel coverage --config=debug //tests/...
```

### Code Quality

```bash
# Format code
just format

# Run clang-tidy (static analysis)
just lint

# Check with sanitizers
bazel build //... --config=debug  # Includes ASAN/UBSAN
```

### Debugging with LLDB

```bash
# Build in debug mode
bazel build //app/example_app -c dbg

# Run under debugger
lldb bazel-bin/app/example_app/example_app

# Or use with gdb
gdb bazel-bin/app/example_app/example_app
```

## Using justfile

Quick commands via `justfile`:

```bash
just build-opt        # Build all in optimized mode
just run-example      # Run example app
just test             # Run all tests
just coverage         # Generate coverage report
just format           # Format code
just clean-full       # Clean everything
```

## Environment Variables

Set via `.envrc` (with direnv):

```bash
export CC=clang
export CXX=clang++
export PATH="$(pwd)/bazel-bin:$PATH"
```

Or manually:
```bash
export CC=$(which clang)
export CXX=$(which clang++)
```

## Performance Tips

1. **Enable local caching**
   ```bash
   # Already configured in .bazelrc:
   build --disk_cache=.cache/bazel_cache
   ```

2. **Use opt mode for releases**
   ```bash
   bazel build //... --config=opt
   ```

3. **Parallel builds**
   ```bash
   bazel build --jobs=8 //...
   ```

4. **Cache warmup**
   ```bash
   bazel build //... --disk_cache=/shared/cache
   ```

## Troubleshooting

### Module errors
Make sure your `MODULE.bazel` is properly configured with all dependencies.

### Compilation errors
- Check C standard: `-std=c11` in `tools/build/cc_rules.bzl`
- Verify include paths in BUILD files

### LLVM/Clang not found
```bash
# Check installation
which clang
which clang++

# Install if missing
brew install llvm  # macOS
apt-get install clang llvm  # Linux
```

### direnv issues
```bash
# Reload direnv
direnv reload

# List loaded variables
direnv export bash
```

## References

- [Bazel Documentation](https://docs.bazel.build/)
- [LLVM Documentation](https://llvm.org/)
- [C Standard Library](https://en.cppreference.com/w/c)
