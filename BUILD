"""Root build file for C Template project."""

load("@hedron_compile_commands//:refresh_compile_commands.bzl", "refresh_compile_commands")

# Refresh compile_commands.json for IDE integration
# Usage: bazel run //:refresh_compile_commands
refresh_compile_commands(
    name = "refresh_compile_commands",
    targets = {
        "//lib/...": "",
        "//app/...": "",
        "//tests/...": "",
    },
)
