load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "Unity",
    build_file = "@//:packages/http/ThrowTheSwitch/Unity/unity.BUILD",
    strip_prefix = "Unity-2.5.2",
    urls = [
        "https://github.com/ThrowTheSwitch/Unity/archive/refs/tags/v2.5.2.zip",
    ],
)

# stellt Standdard Datenstrukturen zur Verfügung (mit Brew installiert.)
new_local_repository(
    name = "glib",
    build_file = "./packages/brew/gnu-lib/glib.BUILD",
    path = "/opt/homebrew/Cellar/glib/2.72.1",
)
