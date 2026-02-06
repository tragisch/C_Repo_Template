#!/usr/bin/env bash
#
# Initialize Bazel directories for macOS with persistent caches
# 
# This script creates the directory structure needed for:
# - Repository cache (survives 'bazel clean --expunge')
# - Distribution mirror (optional, for offline builds)
# - Build cache
#
# Usage:
#   bash tools/setup/init_bazel_env.sh
#   source tools/setup/init_bazel_env.sh (optional, to export variables)
#

set -euo pipefail

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Directory configuration
BAZEL_HOME="${HOME}/.bazel"
REPO_CACHE="${BAZEL_HOME}/repo-cache"
DIST_DIR="${BAZEL_HOME}/distdir"
BUILD_CACHE="${BAZEL_HOME}/build-cache"

echo -e "${YELLOW}Bazel macOS Environment Initialization${NC}"
echo "======================================="
echo ""

# Create directories
echo -e "${GREEN}Creating directories...${NC}"
mkdir -p "${REPO_CACHE}" && echo "  ✓ ${REPO_CACHE}"
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
chmod 755 "${REPO_CACHE}" "${DIST_DIR}" "${BUILD_CACHE}"

# Export variables for sourcing
export BAZEL_REPO_CACHE="${REPO_CACHE}"
export BAZEL_DIST_DIR="${DIST_DIR}"
export BAZEL_BUILD_CACHE="${BUILD_CACHE}"

echo ""
echo -e "${GREEN}Directories initialized successfully!${NC}"
echo ""
echo "Configuration:"
echo "  Repository Cache: ${REPO_CACHE}"
echo "  Distribution Dir: ${DIST_DIR}"
echo "  Build Cache:      ${BUILD_CACHE}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. The .bazelrc already references these directories"
echo "  2. For offline builds, add dependencies to: ${DIST_DIR}"
echo "  3. Run: bazel query //... to populate caches"
echo "  4. Run: bazel clean --expunge (caches will survive)"
echo ""
