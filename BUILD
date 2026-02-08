"""Root build file for C Template project."""

# Komfort-Targets für gängige Entwickler-Workflows.
# So funktionieren z. B.:
#   bazel run //:refresh_compile_commands
#   bazel run //:coverage_html

load("@rules_shell//shell:sh_binary.bzl", "sh_binary")

alias(
    name = "refresh_compile_commands",
    actual = "@wolfd_bazel_compile_commands//:generate_compile_commands",
)

sh_binary(
    name = "coverage_html",
    srcs = ["tools/scripts/coverage_html.sh"],
    data = ["@phst_bazelcov//:bazelcov"],
)
