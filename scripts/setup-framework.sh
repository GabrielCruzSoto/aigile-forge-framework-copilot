#!/usr/bin/env bash
# ==============================================================================
# Script: setup-framework.sh
# Purpose: Configure local Multi-Root Workspace and .git/info/exclude
#          Ensures zero footprint on remote repositories during Phase 0/1.
# ==============================================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$BASE_DIR"

echo "==> [AFF-Copilot] Initializing Multi-Root Workspace layout..."

# 1. Create required directories
mkdir -p sprints work archive templates knowledge/{team,business,architecture}

# 2. Configure .git/info/exclude in local git repository
if [ -d ".git" ]; then
    echo "  [OK] Configuring local .git/info/exclude..."
    mkdir -p .git/info
    touch .git/info/exclude
    grep -q "work/" .git/info/exclude 2>/dev/null || echo "work/" >> .git/info/exclude
    grep -q "sprints/" .git/info/exclude 2>/dev/null || echo "sprints/" >> .git/info/exclude
fi

# 3. Verify cell.code-workspace
if [ -f "cell.code-workspace" ]; then
    echo "  [OK] Multi-Root Workspace file verified: cell.code-workspace"
else
    echo "  [WARN] cell.code-workspace is missing."
fi

echo "==> [AFF-Copilot] Setup completed successfully."
echo "    Open cell.code-workspace in VS Code to activate Copilot agents."
echo "    Run prompt /init-cell with agent @aff-onboarding to configure your cell context."
