#!/usr/bin/env bash
# ==============================================================================
# Script: sync-onedrive.sh
# Purpose: Synchronize workspace documentation and deliverables to OneDrive
#          Supports Linux, macOS, and Windows with automatic tool adaptation.
# ==============================================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$BASE_DIR/.onedrive-sync.conf"

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

DRY_RUN=false
STATUS_ONLY=false

for arg in "$@"; do
    case "$arg" in
        --dry-run)
            DRY_RUN=true
            ;;
        --status)
            STATUS_ONLY=true
            ;;
    esac
done

# 1. Check if OneDrive sync is configured
if [ -f "$CONFIG_FILE" ]; then
    # shellcheck source=/dev/null
    source "$CONFIG_FILE"
fi

TARGET_DIR="${ONEDRIVE_PATH:-}"

if [ -z "$TARGET_DIR" ]; then
    if [ "$STATUS_ONLY" = true ]; then
        echo "==> [OneDrive Sync] OS: $DETECTED_OS | Status: DISABLED (no ONEDRIVE_PATH configured)"
        exit 0
    fi
    # Silent exit when called from git hooks if not configured
    exit 0
fi

# Expand tilde if present
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"

# Normalize Windows paths if needed
if command -v cygpath >/dev/null 2>&1 && [[ "$TARGET_DIR" =~ ^[A-Za-z]: ]]; then
    TARGET_DIR="$(cygpath -u "$TARGET_DIR")"
fi

if [ "$STATUS_ONLY" = true ]; then
    echo "==> [OneDrive Sync] OS: $DETECTED_OS | Status: ENABLED"
    echo "    Source:      $BASE_DIR"
    echo "    Destination: $TARGET_DIR"
    if [ -d "$TARGET_DIR" ]; then
        echo "    Path status: OK (Directory exists)"
    else
        echo "    Path status: WARN (Directory does not exist yet)"
    fi
    exit 0
fi

# 2. Ensure target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "==> [OneDrive Sync] Target directory does not exist: $TARGET_DIR"
    echo "    Creating destination directory..."
    mkdir -p "$TARGET_DIR" 2>/dev/null || {
        echo "==> [OneDrive Sync] ERROR: Cannot create $TARGET_DIR. Check permissions." >&2
        exit 0
    }
fi

echo "==> [OneDrive Sync] ($DETECTED_OS) Synchronizing documentation..."
echo "    Destination: $TARGET_DIR"

# 3. Synchronize using rsync (preferred) or cp fallback
DOC_ITEMS=("knowledge" "work" "sprints" "templates")

if command -v rsync >/dev/null 2>&1; then
    RSYNC_OPTS=(-av --update --delete-after)
    if [ "$DRY_RUN" = true ]; then
        RSYNC_OPTS+=(--dry-run)
        echo "    [MODE: DRY-RUN]"
    fi

    for item in "${DOC_ITEMS[@]}"; do
        if [ -d "$BASE_DIR/$item" ]; then
            mkdir -p "$TARGET_DIR/$item"
            rsync "${RSYNC_OPTS[@]}" \
                --exclude=".*" \
                --exclude="node_modules" \
                --exclude="target" \
                --exclude="build" \
                --exclude="dist" \
                --exclude="*.class" \
                --exclude="*.jar" \
                --exclude="*.log" \
                "$BASE_DIR/$item/" "$TARGET_DIR/$item/"
        fi
    done
else
    # Fallback for systems without rsync (e.g. minimal Git Bash on Windows)
    echo "    [NOTE] rsync not found; using cp fallback."
    if [ "$DRY_RUN" = false ]; then
        for item in "${DOC_ITEMS[@]}"; do
            if [ -d "$BASE_DIR/$item" ]; then
                mkdir -p "$TARGET_DIR/$item"
                cp -p -R "$BASE_DIR/$item"/* "$TARGET_DIR/$item/" 2>/dev/null || true
            fi
        done
    else
        echo "    [DRY-RUN] Would copy items: ${DOC_ITEMS[*]}"
    fi
fi

# 4. Sync root documentation files
ROOT_FILES=("cell.config.yaml" "AGENTS.md" "README.md")
if [ "$DRY_RUN" = false ]; then
    for file in "${ROOT_FILES[@]}"; do
        if [ -f "$BASE_DIR/$file" ]; then
            cp -p "$BASE_DIR/$file" "$TARGET_DIR/$file" 2>/dev/null || true
        fi
    done
    date -u +"%Y-%m-%dT%H:%M:%SZ" > "$TARGET_DIR/.last-sync-timestamp" 2>/dev/null || true
fi

echo "==> [OneDrive Sync] Sync completed successfully on $DETECTED_OS."
exit 0
