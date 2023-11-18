load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Simple Unit Testing for C
# https://github.com/ThrowTheSwitch/Unity/archive/v2.5.2.zip
# LICENSE: MIT
def load_unity():
    http_archive(
        name = "Unity",
        build_file = "@//:tools/ThrowTheSwitch/Unity/BUILD",
        sha256 = "4598298723ecca1f242b8c540a253ae4ab591f6810cbde72f128961007683034",
        strip_prefix = "Unity-2.5.2",
        urls = [
            "https://github.com/ThrowTheSwitch/Unity/archive/refs/tags/v2.5.2.zip",
        ],
    )

def load_unity_cmock():
    http_archive(
        name = "CMock",
        build_file = "@//:tools/ThrowTheSwitch/CMock/BUILD",
        sha256 = "fd30724405b527f2b1d2894b27a1600af3ccb4aad12e63e48ba4f0ea8ae88fe9c",
        strip_prefix = "CMock-2.5.3",
        url = "https://github.com/ThrowTheSwitch/CMock/archive/refs/tags/v2.5.3.tar.gz",
    )

# A few macros that prints and returns the value of a given expression
# for quick and dirty debugging, inspired by Rusts dbg!(…) macro and its C++ variant.
# https://github.com/eerimoq/dbg-macro
def load_dbg_marco():
    http_archive(
        name = "dbg-macro",
        build_file = "@//:tools/dbg-macro/BUILD",
        sha256 = "2cd05a0ab0c93d115bf0ee476a5746189f3ced1d589abb098307daeaa57ef329",
        strip_prefix = "dbg-macro-0.12.1",
        url = "https://github.com/eerimoq/dbg-macro/archive/refs/tags/0.12.1.zip",
    )

# progressbar is a C-class (it's a convention, dammit) for displaying
# attractive progress bars on the command line.
def load_progress_bar():
    git_repository(
        name = "progress_bar",
        commit = "ac56232610abf58cc2db2bc86efc8fcba7dfe8c2",
        remote = "https://github.com/doches/progressbar.git",
        build_file = "@//:third_party/progress_bar/progress_bar.BUILD",
    )

def load_benchmark():
    git_repository(
        name = "com_google_benchmark",
        remote = "https://github.com/google/benchmark.git",
        tag = "v1.8.0",
    )

def load_logger():
    git_repository(
        name = "logging",
        commit = "f9ea34994bd58ed342d2245cd4110bb5c6790153",
        remote = "https://github.com/rxi/log.c.git",
        build_file = "@//:tools/logging/logging.BUILD",
    )

# A minimal, zero-config, BSD licensed, "readline" replacement
def load_linenoise():
    http_archive(
        name = "linenoise",
        build_file = "@//:third_party/linenoise/linenoise.BUILD",
        sha256 = "f5054a4fe120d43d85427cf58af93e56b9bb80389d507a9bec9b75531a340014",
        strip_prefix = "linenoise-1.0",
        url = "https://github.com/antirez/linenoise/archive/refs/tags/1.0.tar.gz",
    )

# micro parster combinators (mpc) is a lightweight and powerful Parser Combinator library for C.
def load_mpc():
    http_archive(
        name = "mpc",
        build_file = "@//:third_party/mpc/mpc.BUILD",
        sha256 = "da6e798accec57d7b0512ecc38adc151961adefde09811c1c25ee993a653e47c",
        strip_prefix = "mpc-0.9.0",
        url = "https://github.com/orangeduck/mpc/archive/refs/tags/0.9.0.tar.gz",
    )

##################################
## Load C Third Party Libraries ##

# load all C repositories
def third_party_repositories():
    """
    Loads third-party repositories for C.
    """
    load_linenoise()
    load_mpc()
    load_progress_bar()
    load_dbg_marco()
    load_unity()
    load_unity_cmock()
    load_logger()
    load_benchmark()
