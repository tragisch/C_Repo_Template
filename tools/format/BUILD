"""Format targets for C and Starlark files."""

load("@aspect_rules_lint//format:defs.bzl", "format_multirun")

format_multirun(
    name = "format",
    cc = "@llvm_toolchain_llvm//:bin/clang-format",
    starlark = "@buildifier_prebuilt//:buildifier",
)
