"""
Deprecated: This file is no longer used.
The LLVM toolchain is now provided by MODULE.bazel with toolchains_llvm.
"""

        compile_flags = ["-Wall", "-Wextra", "-no-canonical-prefixes"],
        cxx_flags = ["-std=c++17"],
        link_flags = ["-lc++", "-fuse-ld=lld"],
        dbg_mode_compile_flags = ["-g"],
        opt_mode_compile_flags = ["-O3"],
        coverage_compile_flags = ["--coverage"],
        coverage_link_flags = ["--coverage"],
    )
