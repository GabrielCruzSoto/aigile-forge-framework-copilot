#!/usr/bin/env bash
# ==============================================================================
# Script: sync-onedrive.sh
# Purpose: Synchronize workspace documentation and deliverables to OneDrive
#          Excludes .git, binaries, build artifacts and code repos.
# ==============================================================================

set -euo pipefail

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_FILE="$BASE_DIR/.onedrive-sync.conf"

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
        echo "==> [OneDrive Sync] Status: DISABLED (no ONEDRIVE_PATH configured in .onedrive-sync.conf)"
        exit 0
    fi
    # Silent exit when called from git hooks if not configured
    exit 0
fi

# Expand tilde if present
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"

if [ "$STATUS_ONLY" = true ]; then
    echo "==> [OneDrive Sync] Status: ENABLED"
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

echo "==> [OneDrive Sync] Synchronizing documentation to OneDrive..."
echo "    Destination: $TARGET_DIR"

# 3. Synchronize using rsync with documentation-only filters
RSYNC_OPTS=(-av --update --delete-after)

if [ "$DRY_RUN" = true ]; then
    RSYNC_OPTS+=(--dry-run)
    echo "    [MODE: DRY-RUN]"
fi

# List of documentation directories to sync
DOC_ITEMS=("knowledge" "work" "sprints" "templates")

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

# Sync root markdown/yaml documentation files
ROOT_FILES=("cell.config.yaml" "AGENTS.md" "README.md")
for file in "${ROOT_FILES[@]}"; do
    if [ -f "$BASE_DIR/$file" ]; then
        cp -p "$BASE_DIR/$file" "$TARGET_DIR/$file" 2>/dev/null || true
    fi
done

# Record sync timestamp
date -u +"%Y-%m-%dT%H:%M:%SZ" > "$TARGET_DIR/.last-sync-timestamp" 2>/dev/null || true

echo "==> [OneDrive Sync] Sync completed successfully."
exit 0
