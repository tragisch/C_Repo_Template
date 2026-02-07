load("@rules_cc//cc:cc_binary.bzl", "cc_binary")

cc_binary(
    name = "example_app",
    srcs = [
        "src/main.c",
    ],
    visibility = ["//visibility:public"],
    deps = [
        "//app/example_lib",
    ],
)
