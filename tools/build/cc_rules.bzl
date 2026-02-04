"""
Helper macros for building C/C++ targets in this project.
These macros provide consistent compiler flags, deps, and best practices.
"""

load("@rules_cc//cc:defs.bzl", "cc_binary", "cc_library", "cc_test")

####################################
# Default Compiler Flags
####################################

_DEFAULT_COPTS = [
    "-Wall",
    "-Wextra",
    "-Wpedantic",
    "-Wno-unknown-pragmas",
    "-Wno-unused-parameter",
    "-std=c11",
]

_DEFAULT_LINKOPTS = [
    "-lm",  # Link math library
]

_DEBUG_COPTS = [
    "-g",
    "-O0",
    "-fno-omit-frame-pointer",
]

####################################
# C Library
####################################

def c_lib(
        name,
        srcs = [],
        hdrs = [],
        include_prefix = None,
        strip_include_prefix = None,
        deps = [],
        visibility = None,
        alwayslink = False,
        textual_hdrs = [],
        **kwargs):
    """
    Convenience macro for cc_library with C-friendly defaults.

    Args:
        name: Library target name
        srcs: Source files (.c)
        hdrs: Header files (.h)
        include_prefix: Include path prefix
        strip_include_prefix: Strip prefix from includes
        deps: Dependencies (other cc_library targets)
        visibility: Visibility of the target
        alwayslink: Force linking of all symbols
        textual_hdrs: Textual header files
        **kwargs: Additional arguments passed to cc_library
    """
    cc_library(
        name = name,
        srcs = srcs,
        hdrs = hdrs,
        include_prefix = include_prefix,
        strip_include_prefix = strip_include_prefix,
        deps = deps,
        copts = _DEFAULT_COPTS + kwargs.pop("copts", []),
        linkopts = _DEFAULT_LINKOPTS + kwargs.pop("linkopts", []),
        visibility = visibility,
        alwayslink = alwayslink,
        textual_hdrs = textual_hdrs,
        **kwargs
    )

####################################
# C Executable
####################################

def c_bin(
        name,
        srcs = [],
        deps = [],
        visibility = None,
        use_stdlib = False,
        **kwargs):
    """
    Convenience macro for cc_binary with C-friendly defaults.

    Args:
        name: Binary target name
        srcs: Source files (.c)
        deps: Dependencies
        visibility: Visibility of the target
        use_stdlib: Whether to use C++ stdlib (default: False)
        **kwargs: Additional arguments passed to cc_binary
    """
    copts = _DEFAULT_COPTS + kwargs.pop("copts", [])
    linkopts = _DEFAULT_LINKOPTS + kwargs.pop("linkopts", [])

    # Add C++ stdlib options if requested
    if use_stdlib:
        copts.append("-stdlib=libc++")
        linkopts.append("-stdlib=libc++")

    cc_binary(
        name = name,
        srcs = srcs,
        deps = deps,
        copts = copts,
        linkopts = linkopts,
        visibility = visibility,
        **kwargs
    )

####################################
# C Unit Test (with Unity framework)
####################################

def c_test(
        name,
        srcs = [],
        deps = [],
        visibility = None,
        size = "small",
        timeout = None,
        **kwargs):
    """
    Convenience macro for C unit tests using Unity framework.

    Args:
        name: Test target name
        srcs: Test source files (.c)
        deps: Dependencies (will include @Unity automatically)
        visibility: Visibility of the target
        size: Test size (small, medium, large)
        timeout: Test timeout
        **kwargs: Additional arguments passed to cc_test
    """
    copts = _DEFAULT_COPTS + _DEBUG_COPTS + kwargs.pop("copts", [])
    linkopts = _DEFAULT_LINKOPTS + kwargs.pop("linkopts", [])

    test_deps = deps + ["@Unity"]

    cc_test(
        name = name,
        srcs = srcs,
        deps = test_deps,
        copts = copts,
        linkopts = linkopts,
        visibility = visibility,
        size = size,
        timeout = timeout,
        **kwargs
    )

####################################
# C Library with Tests
####################################

def c_lib_with_tests(
        name,
        srcs = [],
        hdrs = [],
        deps = [],
        test_srcs = [],
        visibility = None,
        **kwargs):
    """
    Convenience macro for creating a library and its tests together.

    Creates two targets:
      - {name}: The library
      - {name}_test: The corresponding test suite

    Args:
        name: Base target name
        srcs: Source files for the library
        hdrs: Header files for the library
        deps: Dependencies
        test_srcs: Test source files
        visibility: Visibility of the library
        **kwargs: Additional arguments
    """

    # Create library
    c_lib(
        name = name,
        srcs = srcs,
        hdrs = hdrs,
        deps = deps,
        visibility = visibility,
        **kwargs
    )

    # Create test if test sources provided
    if test_srcs:
        c_test(
            name = name + "_test",
            srcs = test_srcs,
            deps = [":" + name],
        )
