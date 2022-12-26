filegroup(
    name = "TestRunnerGenerator",
    srcs = ["auto/generate_test_runner.rb"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "HelperScripts",
    srcs = glob(["auto/*.rb"]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "TypeSanitizer",
    srcs = ["auto/type_sanitizer.rb"],
    visibility = ["//visibility:public"],
)

cc_library(
    name = "unity",
    srcs = ["Unity-master/src/unit.c"],
    hdrs = ["Unity-master/src/*.h"],
    visibility = ["//visibility:public"],
)
