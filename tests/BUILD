load("//:tools/unity_test.bzl", "unity_test")

unity_test(
    name = "test_armstrong_numbers",
    srcs = ["test_armstrong_numbers.c"],
    my_config = ["my_config.yml"],
    deps = [
        "//src:armstrong_numbers",
    ],
)
