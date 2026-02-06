"""Example application target."""

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library")

cc_binary(
    name = "example_app",
    srcs = [
        "example_app/src/main.c",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":example_lib",
    ],
)

cc_library(
    name = "example_lib",
    srcs = [
        "example_app/src/example_lib.c",
    ],
    hdrs = ["example_app/include/example_lib.h"],
    strip_include_prefix = "example_app/include",
    visibility = ["//visibility:public"],
)
