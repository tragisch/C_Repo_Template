cc_library(
    name = "ptest",
    srcs = ["ptest.c"],
    hdrs = ["ptest.h"],
    includes = ["."],
    visibility = ["//visibility:public"],
)

cc_test(
    name = "test",
    timeout = "short",
    srcs = [
        "combinators.c",
        "core.c",
        "grammar.c",
        "regex.c",
        "test.c",
    ],
    deps = [
        ":ptest",
        "@mpc",
    ],
)
