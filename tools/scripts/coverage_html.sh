#!/usr/bin/env bash
set -euo pipefail

resolve_bazelcov_from_manifest() {
  local manifest="$1"
  local runfiles_bash

  runfiles_bash="$(awk '$1=="bazel_tools/tools/bash/runfiles/runfiles.bash" {print $2; exit}' "${manifest}")"
  if [[ -n "${runfiles_bash}" && -f "${runfiles_bash}" ]]; then
    # shellcheck source=/dev/null
    source "${runfiles_bash}"
    BAZELCOV="$(rlocation "phst_bazelcov/bazelcov")"
    return 0
  fi

  BAZELCOV="$(awk '$1=="phst_bazelcov/bazelcov" || $1=="phst_bazelcov+/bazelcov_/bazelcov" {print $2; exit}' "${manifest}")"
}

# Resolve runfiles.
if [[ -n "${RUNFILES_DIR:-}" && -f "${RUNFILES_DIR}/bazel_tools/tools/bash/runfiles/runfiles.bash" ]]; then
  # shellcheck source=/dev/null
  source "${RUNFILES_DIR}/bazel_tools/tools/bash/runfiles/runfiles.bash"
  BAZELCOV="$(rlocation "phst_bazelcov/bazelcov")"
elif [[ -n "${RUNFILES_MANIFEST_FILE:-}" && -f "${RUNFILES_MANIFEST_FILE}" ]]; then
  resolve_bazelcov_from_manifest "${RUNFILES_MANIFEST_FILE}"
else
  SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
  if [[ -f "${SCRIPT_PATH}.runfiles_manifest" ]]; then
    resolve_bazelcov_from_manifest "${SCRIPT_PATH}.runfiles_manifest"
  elif [[ -f "${SCRIPT_PATH}.runfiles/MANIFEST" ]]; then
    resolve_bazelcov_from_manifest "${SCRIPT_PATH}.runfiles/MANIFEST"
  else
    echo "Runfiles not found; cannot locate phst_bazelcov." >&2
    exit 1
  fi
fi

if [[ -z "${BAZELCOV}" || ! -x "${BAZELCOV}" ]]; then
  echo "bazelcov binary not found in runfiles." >&2
  exit 1
fi

# Default output directory.
OUTPUT_DIR="docs/coverage"

exec "${BAZELCOV}" -output "${OUTPUT_DIR}" "$@"
