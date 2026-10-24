#!/usr/bin/env bash
# ==============================================================================
# Script: install-dependencies.sh
# Purpose: Check developer tools, VS Code CLI, and linters for AFF-Copilot
# Operating System: macOS / Linux / Git Bash on Windows
# ==============================================================================

set -euo pipefail

echo "==> [AFF-Copilot] Checking developer workstation tools..."

check_cmd() {
    local cmd="$1"
    local desc="$2"
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "  [OK] $cmd found: $(command -v "$cmd")"
    else
        echo "  [WARN] $cmd missing. $desc"
    fi
}

check_cmd "git" "Required for version control"
check_cmd "code" "Install VS Code and run 'Install code command in PATH'"
check_cmd "mvn" "Required for Java/Kotlin backend services"
check_cmd "node" "Required for Angular/Web frontend portal"
check_cmd "npm" "Installed with Node.js"

echo "==> [AFF-Copilot] Checking VS Code Copilot extension..."
if command -v code >/dev/null 2>&1; then
    if code --list-extensions 2>/dev/null | grep -i "github.copilot" >/dev/null; then
        echo "  [OK] GitHub Copilot extension installed in VS Code."
    else
        echo "  [WARN] GitHub Copilot extension not detected in VS Code."
        echo "         Install via: code --install-extension GitHub.copilot"
    fi
fi

chmod +x scripts/*.sh 2>/dev/null || true
echo "==> [AFF-Copilot] Tool check completed."
