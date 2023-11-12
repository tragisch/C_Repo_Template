cc_library(
    name = "progress_bar",
    srcs = [
        "lib/progressbar.c",
        "lib/statusbar.c",
    ],
    hdrs = [
        "include/progressbar/progressbar.h",
        "include/progressbar/statusbar.h",
    ],
    copts = [
        "-Wimplicit-function-declaration",
        "-std=c99",
        "-Wall",
        "-Wextra",
        "-pedantic",
    ],
    includes = ["include/progressbar"],
    linkopts = ["-lncurses"],
    visibility = ["//visibility:public"],
)
