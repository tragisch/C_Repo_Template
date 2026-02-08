load("@bazel_env.bzl", "bazel_env")
load("@bazelrc-preset.bzl", "bazelrc_preset")
load("@multitool//:tools.bzl", MULTITOOL_TOOLS = "TOOLS")

bazel_env(
    name = "bazel_env",
    toolchains = {
        "jdk": "@rules_java//toolchains:current_host_java_runtime",
        "python": "@rules_python//python:current_py_toolchain",
    },
    tools = MULTITOOL_TOOLS | {
        # Tools can be specified as labels - these override multitool
        "buildifier": "@buildifier_prebuilt//:buildifier",
        "buildozer": "@buildozer//:buildozer",
        "format": "//tools/format:format",
        "jar": "$(JAVABASE)/bin/jar",
        "java": "$(JAVA)",
        "python": "$(PYTHON3)",
    },
)

bazelrc_preset(
    name = "preset",
)
