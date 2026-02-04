"""Example application target."""

load("//tools/build:cc_rules.bzl", "c_bin")

c_bin(
    name = "example_app",
    srcs = [
        "src/main.c",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//lib/example_lib",
    ],
)
