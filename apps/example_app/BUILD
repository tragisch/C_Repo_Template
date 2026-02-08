load("@rules_cc//cc:cc_binary.bzl", "cc_binary")
load("//tools:c_copts.bzl", "C_COPTS")

cc_binary(
    name = "example_app",
    srcs = [
        "src/main.c",
    ],
    copts = C_COPTS,
    visibility = ["//visibility:public"],
    deps = [
        "//apps/example_lib",
    ],
)
