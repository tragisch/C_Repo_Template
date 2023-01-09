cc_binary(
    name = "main",
    srcs = ["main.c"],
    visibility = ["//visibility:public"],
    deps = [
        ":armstrong_numbers",
    ],
)

cc_library(
    name = "armstrong_numbers",
    srcs = ["armstrong_numbers.c"],
    hdrs = ["include/armstrong_numbers.h"],
    includes = ["include"],
    visibility = ["//visibility:public"],
)
