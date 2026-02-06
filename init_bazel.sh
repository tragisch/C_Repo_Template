#!/usr/bin/env bash
#
# Quick init wrapper - convenience script from repository root
# Usage: bash init_bazel.sh
#

cd "$(dirname "$0")" || exit 1
exec bash tools/setup/init_bazel_env.sh "$@"
