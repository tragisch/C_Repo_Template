load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "cc_toolchain_config")

def define_brew_clang_toolchain():
    cc_toolchain_config(
        name = "brew_clang_toolchain",
        toolchain_identifier = "brew-clang",
        host_system_name = "local",
        target_system_name = "macos",
        target_cpu = "darwin_arm64",
        target_libc = "unknown",
        compiler = "clang",
        abi_version = "local",
        abi_libc_version = "local",
        builtin_sysroot = None,
        tool_paths = [
            ("gcc", "/opt/homebrew/opt/llvm/bin/clang"),
            ("g++", "/opt/homebrew/opt/llvm/bin/clang++"),
            ("ld", "/opt/homebrew/opt/llvm/bin/ld.lld"),
            ("cpp", "/opt/homebrew/opt/llvm/bin/clang -E"),
            ("ar", "/opt/homebrew/opt/llvm/bin/llvm-ar"),
            ("strip", "/opt/homebrew/opt/llvm/bin/llvm-strip"),
            ("nm", "/opt/homebrew/opt/llvm/bin/llvm-nm"),
            ("objdump", "/opt/homebrew/opt/llvm/bin/llvm-objdump"),
            ("objcopy", "/opt/homebrew/opt/llvm/bin/llvm-objcopy"),
            ("dwp", "/opt/homebrew/opt/llvm/bin/llvm-dwp"),
        ],
        cxx_builtin_include_directories = [
            "/opt/homebrew/opt/llvm/include/c++/v1",
            "/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include",
        ],
        compile_flags = ["-Wall", "-Wextra", "-no-canonical-prefixes"],
        cxx_flags = ["-std=c++17"],
        link_flags = ["-lc++", "-fuse-ld=lld"],
        dbg_mode_compile_flags = ["-g"],
        opt_mode_compile_flags = ["-O3"],
        coverage_compile_flags = ["--coverage"],
        coverage_link_flags = ["--coverage"],
    )
