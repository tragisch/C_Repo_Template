"""Unit tests for example_lib."""

load("@rules_cc//cc:defs.bzl", "cc_test")

cc_test(
    name = "test_example_lib",
    srcs = [
        "test_example_lib.c",
    ],
    deps = [
        "//app:example_lib",
        "@Unity",
    ],
)
