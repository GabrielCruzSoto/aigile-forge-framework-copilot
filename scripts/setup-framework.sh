#!/usr/bin/env bash
# ==============================================================================
# Script: setup-framework.sh
# Purpose: Configure local Multi-Root Workspace and .git/info/exclude
#          Ensures zero footprint on Bitbucket Enterprise Server during Phase 0/1.
# ==============================================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$BASE_DIR"

echo "==> [AFF-M] Initializing Multi-Root Workspace layout..."

# 1. Create required directories
mkdir -p sprints work archive templates knowledge/architecture

# 2. Configure .git/info/exclude in local git repository
if [ -d ".git" ]; then
    echo "  [OK] Configuring local .git/info/exclude..."
    mkdir -p .git/info
    touch .git/info/exclude
    grep -q "work/" .git/info/exclude 2>/dev/null || echo "work/" >> .git/info/exclude
    grep -q "sprints/" .git/info/exclude 2>/dev/null || echo "sprints/" >> .git/info/exclude
fi

# 3. Verify the-last-of-code.code-workspace
if [ -f "the-last-of-code.code-workspace" ]; then
    echo "  [OK] Multi-Root Workspace file verified: the-last-of-code.code-workspace"
else
    echo "  [WARN] the-last-of-code.code-workspace is missing."
fi

echo "==> [AFF-M] Setup completed successfully."
echo "    Open the-last-of-code.code-workspace in VS Code to activate Copilot agents."
