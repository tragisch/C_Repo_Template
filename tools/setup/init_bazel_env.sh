#!/usr/bin/env bash
#
# Initialize Bazel macOS Development Environment
# 
# This script sets up:
# - Bazel cache directories (repository, build, repo-contents)
# - Distribution mirror (optional, for offline builds)
# - Development dependencies validation
# - Optional direnv integration
# - Environment variable configuration
#
# Usage:
#   bash tools/setup/init_bazel_env.sh
#   source tools/setup/init_bazel_env.sh (to export variables)
#
# This script is designed to run on macOS with Bazel 9+

set -euo pipefail

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directory configuration
BAZEL_HOME="${HOME}/.bazel"
REPO_CACHE="${BAZEL_HOME}/repo-cache"
REPO_CONTENTS_CACHE="${BAZEL_HOME}/repo-contents-cache"
DIST_DIR="${BAZEL_HOME}/distdir"
BUILD_CACHE="${BAZEL_HOME}/build-cache"

# Flag for verbose output
VERBOSE=${VERBOSE:-false}

echo -e "${YELLOW}Bazel macOS Environment Initialization${NC}"
echo "======================================="
echo ""

# Function to check command availability
check_command() {
    local cmd=$1
    local friendly_name=${2:-$cmd}
    if command -v "${cmd}" >/dev/null 2>&1; then
        echo -e "  ✓ ${cmd} (${friendly_name})"
        return 0
    else
        echo -e "  ${YELLOW}○${NC} ${cmd} (${friendly_name}) - optional"
        return 1
    fi
}

# Function to check command availability (required)
check_command_required() {
    local cmd=$1
    local friendly_name=${2:-$cmd}
    if command -v "${cmd}" >/dev/null 2>&1; then
        echo -e "  ✓ ${cmd} (${friendly_name})"
        return 0
    else
        echo -e "  ${RED}✗${NC} ${cmd} (${friendly_name}) - REQUIRED"
        return 1
    fi
}

# Validate dependencies
echo -e "${GREEN}Checking dependencies...${NC}"
has_errors=false

if ! check_command_required bazel "Bazel 9+"; then
    echo -e "${YELLOW}  → Install from: https://bazel.build/install${NC}"
    has_errors=true
fi

if [[ "$(uname)" == "Darwin" ]]; then
    if ! check_command_required xcode-select "Xcode Command Line Tools"; then
        echo -e "${YELLOW}  → Run: xcode-select --install${NC}"
        has_errors=true
    fi
fi

# Optional dependencies
check_command lcov "lcov (for HTML coverage reports)"
check_command direnv "direnv (for automatic environment loading)"

if [[ "${has_errors}" == true ]]; then
    echo -e "${RED}Please install required dependencies first.${NC}"
    exit 1
fi

echo ""

# Create directories
echo -e "${GREEN}Creating cache directories...${NC}"
mkdir -p "${REPO_CACHE}" && echo "  ✓ ${REPO_CACHE}"
mkdir -p "${REPO_CONTENTS_CACHE}" && echo "  ✓ ${REPO_CONTENTS_CACHE}"
mkdir -p "${DIST_DIR}" && echo "  ✓ ${DIST_DIR}"
mkdir -p "${BUILD_CACHE}" && echo "  ✓ ${BUILD_CACHE}"

# Create .gitignore for caches (optional, if in project)
if [[ -d ".git" ]]; then
    echo ""
    echo -e "${GREEN}Updating .gitignore for Bazel caches...${NC}"
    
    if ! grep -q "bazel-" .gitignore 2>/dev/null; then
        cat >> .gitignore << 'EOF'

# Bazel outputs (workspace symlinks)
/bazel-*
EOF
        echo "  ✓ Added Bazel patterns to .gitignore"
    else
        echo "  • Bazel patterns already in .gitignore"
    fi
fi

# Set permissions
chmod 755 "${REPO_CACHE}" "${REPO_CONTENTS_CACHE}" "${DIST_DIR}" "${BUILD_CACHE}"

# Export variables for sourcing
export BAZEL_REPO_CACHE="${REPO_CACHE}"
export BAZEL_REPO_CONTENTS_CACHE="${REPO_CONTENTS_CACHE}"
export BAZEL_DIST_DIR="${DIST_DIR}"
export BAZEL_BUILD_CACHE="${BUILD_CACHE}"

echo ""
echo -e "${GREEN}Directories initialized successfully!${NC}"
echo ""
echo "Configuration:"
echo "  Repository Cache:       ${REPO_CACHE}"
echo "  Repo-Contents Cache:    ${REPO_CONTENTS_CACHE}"
echo "  Distribution Mirror:    ${DIST_DIR}"
echo "  Build Cache:            ${BUILD_CACHE}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. ✓ Cache directories are configured in .bazelrc"
echo "  2. Build the complete toolchain:"
echo "     bazel build //..."
echo "  3. Build developer tools (optional):"
echo "     bazel run //tools:bazel_env"
echo "     direnv allow (if using direnv)"
echo "  4. Run tests and coverage:"
echo "     bazel test //..."
echo "     bazel coverage //... && bazel run //:coverage_html"
echo ""
echo -e "${BLUE}For offline builds:${NC}"
echo "  - Add dependencies to: ${DIST_DIR}"
echo "  - Uncomment in .bazelrc: common --distdir=~/.bazel/distdir"
echo ""
echo -e "${BLUE}Useful commands:${NC}"
echo "  - Refresh compile_commands.json:"
echo "    bazel run //:refresh_compile_commands"
echo "  - Generate HTML coverage reports:"
echo "    bazel run //:coverage_html"
echo "  - Debug configuration:"
echo "    bazel build --config=debug //..."
echo "  - Optimized build:"
echo "    bazel build --config=opt //..."
echo ""
