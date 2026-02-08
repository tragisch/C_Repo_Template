load("@rules_cc//cc:cc_library.bzl", "cc_library")
load("//tools:c_copts.bzl", "C_COPTS")

cc_library(
    name = "example_lib",
    srcs = [
        "src/example_lib.c",
    ],
    hdrs = ["include/example_lib.h"],
    copts = C_COPTS,
    includes = ["include"],
    visibility = ["//visibility:public"],
)
