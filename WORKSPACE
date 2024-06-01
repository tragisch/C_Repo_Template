load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

maybe(
    http_archive,
    name = "bazel_skylib",
    sha256 = "cd55a062e763b9349921f0f5db8c3933288dc8ba4f76dd9416aac68acee3cb94",
    url = "https://github.com/bazelbuild/bazel-skylib/releases/download/1.5.0/bazel-skylib-1.5.0.tar.gz",
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")

bazel_skylib_workspace()

# Simple Unit Testing for C
# https://github.com/ThrowTheSwitch/Unity/archive/v2.5.2.zip
# LICENSE: MIT

http_archive(
    name = "Unity",
    build_file = "@//:third_party/throw_the_switch_unity.BUILD",
    sha256 = "4598298723ecca1f242b8c540a253ae4ab591f6810cbde72f128961007683034",
    strip_prefix = "Unity-2.5.2",
    urls = [
        "https://github.com/ThrowTheSwitch/Unity/archive/refs/tags/v2.5.2.zip",
    ],
)

# A few macros that prints and returns the value of a given expression
# for quick and dirty debugging, inspired by Rusts dbg!(…) macro and its C++ variant.
# https://github.com/eerimoq/dbg-macro

http_archive(
    name = "dbg-macro",
    build_file = "@//:third_party/dbg-macro.BUILD",
    sha256 = "2cd05a0ab0c93d115bf0ee476a5746189f3ced1d589abb098307daeaa57ef329",
    strip_prefix = "dbg-macro-0.12.1",
    url = "https://github.com/eerimoq/dbg-macro/archive/refs/tags/0.12.1.zip",
)

# A minimal, zero-config, BSD licensed, "readline" replacement
http_archive(
    name = "linenoise",
    build_file = "@//:third_party/linenoise.BUILD",
    sha256 = "f5054a4fe120d43d85427cf58af93e56b9bb80389d507a9bec9b75531a340014",
    strip_prefix = "linenoise-1.0",
    url = "https://github.com/antirez/linenoise/archive/refs/tags/1.0.tar.gz",
)

# Simple benchmarking library for C
http_archive(
    name = "simple_bench",
    strip_prefix = "Simple-Benchmark-C-Header-main",
    url = "https://github.com/tragisch/Simple-Benchmark-C-Header/archive/refs/heads/main.zip",
)
