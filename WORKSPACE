load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "com_google_googletest",
    strip_prefix = "googletest-609281088cfefc76f9d0ce82e1ff6c30cc3591e5",
    urls = ["https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip"],
)

# stellt Standdard Datenstrukturen zur Verfügung (mit Brew installiert.)
new_local_repository(
    name = "glib",
    build_file = "./packages/brew/gnu-lib/glib.BUILD",
    path = "/opt/homebrew/Cellar/glib/2.72.1",
)
