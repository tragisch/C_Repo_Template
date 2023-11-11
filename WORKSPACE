load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

##########################
## Http Archives
##########################

# Simple Unit Testing for C
# https://github.com/ThrowTheSwitch/Unity/archive/v2.5.2.zip
# LICENSE: MIT
http_archive(
    name = "Unity",
    build_file = "@//:tools/ThrowTheSwitch/Unity/BUILD",
    sha256 = "4598298723ecca1f242b8c540a253ae4ab591f6810cbde72f128961007683034",
    strip_prefix = "Unity-2.5.2",
    urls = [
        "https://github.com/ThrowTheSwitch/Unity/archive/refs/tags/v2.5.2.zip",
    ],
)

http_archive(
    name = "CMock",
    build_file = "@//:tools/ThrowTheSwitch/CMock/BUILD",
    sha256 = "fd30724405b527f2b1d2894b27a1600af3ccb4aad12e63e48ba4f0ea8ae88fe9c",
    strip_prefix = "CMock-2.5.3",
    url = "https://github.com/ThrowTheSwitch/CMock/archive/refs/tags/v2.5.3.tar.gz",
)

# https://github.com/meekrosoft/fff
http_archive(
    name = "fff",
    build_file = "@//:tools/fff/BUILD",
    sha256 = "510efb70ab17a0035affd170960401921c9cc36ec81002ed00d2bfec6e08f385",
    strip_prefix = "fff-1.1",
    url = "https://github.com/meekrosoft/fff/archive/refs/tags/v1.1.tar.gz",
)

# A few macros that prints and returns the value of a given expression
# for quick and dirty debugging, inspired by Rusts dbg!(…) macro and its C++ variant.
# https://github.com/eerimoq/dbg-macro
http_archive(
    name = "dbg-macro",
    build_file = "@//:tools/dbg-macro/BUILD",
    sha256 = "2cd05a0ab0c93d115bf0ee476a5746189f3ced1d589abb098307daeaa57ef329",
    strip_prefix = "dbg-macro-0.12.1",
    url = "https://github.com/eerimoq/dbg-macro/archive/refs/tags/0.12.1.zip",
)

##########################
## LOCAL REPOSITORIES (e.g. BREW)
##########################

# stellt Standdard Datenstrukturen zur Verfügung (mit Brew installiert.)
new_local_repository(
    name = "glib",
    build_file = "./third_party/gnu-lib/glib.BUILD",
    path = "/opt/homebrew/Cellar/glib/2.76.4",
)
