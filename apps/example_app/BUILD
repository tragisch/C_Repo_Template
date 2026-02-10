load("@rules_cc//cc:cc_binary.bzl", "cc_binary")
load("//tools:c_copts.bzl", "C_COPTS")
load("//tools/license:license_report.bzl", "generate_sbom", "license_report", "license_summary")

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

license_report(
    name = "example_app_licenses",
    deps = [":example_app"],
)

license_summary(
    name = "example_app_license_summary",
    license_json = ":example_app_licenses",
)

generate_sbom(
    name = "example_app_sbom",
    deps = [":example_app"],
)
