#!/usr/bin/env bash
# ==============================================================================
# Script: setup-framework.sh
# Purpose: Configure local Multi-Root Workspace, .git/info/exclude, Agent Skills
#          and optional OneDrive sync with automatic OS detection (Linux/macOS/Windows).
# ==============================================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$BASE_DIR"

# ------------------------------------------------------------------------------
# Operating System Detection
# ------------------------------------------------------------------------------
detect_os() {
    local u_name
    u_name="$(uname -s 2>/dev/null || echo "Unknown")"
    case "$u_name" in
        Darwin*)
            echo "macos"
            ;;
        Linux*)
            echo "linux"
            ;;
        CYGWIN*|MINGW*|MSYS*)
            echo "windows"
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

DETECTED_OS="$(detect_os)"

case "$DETECTED_OS" in
    macos)
        OS_DISPLAY="macOS (Darwin)"
        ;;
    linux)
        OS_DISPLAY="Linux"
        ;;
    windows)
        OS_DISPLAY="Windows (Git Bash / MSYS)"
        ;;
    *)
        OS_DISPLAY="Unknown OS ($DETECTED_OS)"
        ;;
esac

echo "==> [AFF-Copilot] Operating System detected: $OS_DISPLAY"
echo "==> [AFF-Copilot] Initializing Multi-Root Workspace layout..."

# ------------------------------------------------------------------------------
# Detect Default / Existing OneDrive Folder by OS
# ------------------------------------------------------------------------------
find_default_onedrive() {
    local candidate=""
    case "$DETECTED_OS" in
        macos)
            # macOS CloudStorage location or legacy Home folder
            for p in "$HOME/Library/CloudStorage"/OneDrive* "$HOME"/OneDrive*; do
                if [ -d "$p" ]; then
                    candidate="$p/Cell-Documentation"
                    break
                fi
            done
            ;;
        windows)
            # Git Bash / Windows paths
            local win_profile="${USERPROFILE:-}"
            if [ -n "$win_profile" ]; then
                # Convert C:\Users\... to /c/Users/... if cygpath exists
                if command -v cygpath >/dev/null 2>&1; then
                    win_profile="$(cygpath -u "$win_profile")"
                else
                    win_profile="$(echo "$win_profile" | sed -e 's|\\|/|g' -e 's|^\([A-Za-z]\):|/\L\1|')"
                fi
                for p in "$win_profile"/OneDrive* "$HOME"/OneDrive*; do
                    if [ -d "$p" ]; then
                        candidate="$p/Cell-Documentation"
                        break
                    fi
                done
            fi
            ;;
        linux)
            for p in "$HOME"/OneDrive* "$HOME"/onedrive*; do
                if [ -d "$p" ]; then
                    candidate="$p/Cell-Documentation"
                    break
                fi
            done
            ;;
    esac

    if [ -z "$candidate" ]; then
        candidate="$HOME/OneDrive/Cell-Documentation"
    fi
    echo "$candidate"
}

ONEDRIVE_ACTION=""
ONEDRIVE_TARGET=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --enable-onedrive)
            ONEDRIVE_ACTION="enable"
            if [[ -n "${2:-}" && ! "$2" =~ ^-- ]]; then
                ONEDRIVE_TARGET="$2"
                shift
            fi
            shift
            ;;
        --disable-onedrive)
            ONEDRIVE_ACTION="disable"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# 1. Create required directories
mkdir -p sprints work archive templates knowledge/{team,business,architecture}

# 2. Configure .git/info/exclude in local git repository
if [ -d ".git" ]; then
    echo "  [OK] Configuring local .git/info/exclude..."
    mkdir -p .git/info
    touch .git/info/exclude
    grep -q "work/" .git/info/exclude 2>/dev/null || echo "work/" >> .git/info/exclude
    grep -q "sprints/" .git/info/exclude 2>/dev/null || echo "sprints/" >> .git/info/exclude
    grep -q "\.onedrive-sync\.conf" .git/info/exclude 2>/dev/null || echo ".onedrive-sync.conf" >> .git/info/exclude
fi

# 3. Synchronize and install Agent Skills to .github/skills/
echo "  [OK] Installing and synchronizing Agent Skills to .github/skills/..."
mkdir -p .github/skills
if [ -d "skills" ]; then
    cp -r skills/* .github/skills/
    SKILL_COUNT=$(find .github/skills -type f -name "SKILL.md" 2>/dev/null | wc -l)
    echo "  [OK] $SKILL_COUNT Agent Skills installed and verified in .github/skills/."
else
    echo "  [WARN] skills/ directory not found in $BASE_DIR."
fi

# 4. Verify cell.code-workspace
if [ -f "cell.code-workspace" ]; then
    echo "  [OK] Multi-Root Workspace file verified: cell.code-workspace"
else
    echo "  [WARN] cell.code-workspace is missing."
fi

# 5. Optional OneDrive Documentation Synchronization Setup
CONFIG_FILE="$BASE_DIR/.onedrive-sync.conf"
HOOK_FILE="$BASE_DIR/.git/hooks/post-commit"

if [ -z "$ONEDRIVE_ACTION" ] && [ -t 0 ]; then
    DEFAULT_SUGGESTION="$(find_default_onedrive)"
    echo ""
    echo "==> [Optional Feature] OneDrive Documentation Sync ($OS_DISPLAY)"
    echo "    Permite sincronizar automáticamente knowledge/, specs y mapas de sprint a OneDrive."
    read -r -p "    ¿Desea habilitar la sincronización con OneDrive? [s/N]: " RESP
    if [[ "$RESP" =~ ^[sSyY]$ ]]; then
        ONEDRIVE_ACTION="enable"
        echo "    Ruta sugerida para $OS_DISPLAY: $DEFAULT_SUGGESTION"
        read -r -p "    Ingrese ruta destino [Enter para usar sugerida]: " USER_PATH
        ONEDRIVE_TARGET="${USER_PATH:-$DEFAULT_SUGGESTION}"
    else
        ONEDRIVE_ACTION="disable"
    fi
fi

if [ "$ONEDRIVE_ACTION" = "enable" ]; then
    DEFAULT_SUGGESTION="$(find_default_onedrive)"
    TARGET_PATH="${ONEDRIVE_TARGET:-$DEFAULT_SUGGESTION}"
    
    # Handle Windows backslashes in user path input
    TARGET_PATH="$(echo "$TARGET_PATH" | sed -e 's|\\|/|g')"
    if command -v cygpath >/dev/null 2>&1 && [[ "$TARGET_PATH" =~ ^[A-Za-z]: ]]; then
        TARGET_PATH="$(cygpath -u "$TARGET_PATH")"
    fi

    echo "  [OK] Enabling OneDrive documentation sync for $OS_DISPLAY..."
    cat << EOF > "$CONFIG_FILE"
# Auto-generated by setup-framework.sh
OS_TYPE="$DETECTED_OS"
ONEDRIVE_PATH="$TARGET_PATH"
EOF
    echo "  [OK] Configuration saved to .onedrive-sync.conf (excluded from git)."

    # Install post-commit hook
    if [ -d "$BASE_DIR/.git" ]; then
        mkdir -p "$BASE_DIR/.git/hooks"
        cat << 'EOF' > "$HOOK_FILE"
#!/usr/bin/env bash
# Auto-sync documentation to OneDrive after commit
HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
if [ -x "$HOOK_DIR/scripts/sync-onedrive.sh" ]; then
    "$HOOK_DIR/scripts/sync-onedrive.sh" >/dev/null 2>&1 &
fi
EOF
        chmod +x "$HOOK_FILE"
        echo "  [OK] Git post-commit hook installed: triggers sync-onedrive.sh in background."
    fi

    # Trigger initial test sync
    if [ -x "$BASE_DIR/scripts/sync-onedrive.sh" ]; then
        "$BASE_DIR/scripts/sync-onedrive.sh" || true
    fi

elif [ "$ONEDRIVE_ACTION" = "disable" ]; then
    if [ -f "$CONFIG_FILE" ]; then
        rm -f "$CONFIG_FILE"
        echo "  [OK] Removed .onedrive-sync.conf."
    fi
    if [ -f "$HOOK_FILE" ]; then
        rm -f "$HOOK_FILE"
        echo "  [OK] Removed git post-commit hook for OneDrive."
    fi
    echo "  [INFO] OneDrive sync is disabled."
fi

# Ensure all scripts have execute permissions
chmod +x scripts/*.sh 2>/dev/null || true

echo ""
echo "==> [AFF-Copilot] Setup completed successfully on $OS_DISPLAY."
echo "    Open cell.code-workspace in VS Code to activate Copilot agents and skills."
echo "    Run prompt /init-cell with agent @aff-onboarding to configure your cell context."
