#!/usr/bin/env bash
# ==============================================================================
# Script: setup-framework.sh
# Purpose: Initialize or scaffold an agent workspace at a mandatory target path,
#          configure Multi-Root Workspace, .git/info/exclude, Agent Skills,
#          and optional OneDrive sync with automatic cross-platform OS detection.
# ==============================================================================

set -euo pipefail

FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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

# ------------------------------------------------------------------------------
# Usage & Help Message
# ------------------------------------------------------------------------------
print_usage() {
    cat << EOF
==> [AFF-Copilot] Script de Inicialización de Workspace de Agente

Uso:
  $0 <ruta-workspace> [opciones]
  $0 --workspace <ruta-workspace> [opciones]

Parámetro Obligatorio:
  <ruta-workspace>             Ruta del directorio donde se creará o configurará
                               el workspace del agente. Puede ser absoluta,
                               relativa o '.' para el directorio actual.

Opciones:
  -w, --workspace <ruta>       Forma alternativa de especificar la ruta del workspace.
  --enable-onedrive [ruta]     Habilita la sincronización automática de documentación a OneDrive.
  --disable-onedrive           Deshabilita la sincronización con OneDrive.
  -h, --help                   Muestra este mensaje de ayuda.

Ejemplos:
  # Configurar en el directorio actual (si estás en el repo del framework):
  $0 .

  # Crear/scaffoldear un nuevo workspace de célula en otra carpeta:
  $0 /home/usuario/mi-celula-workspace

  # Configurar workspace con sincronización automática a OneDrive:
  $0 ../celula-pagos --enable-onedrive "~/OneDrive - MiEmpresa/Docs-Celula"
EOF
}

# ------------------------------------------------------------------------------
# Detect Default / Existing OneDrive Folder by OS
# ------------------------------------------------------------------------------
find_default_onedrive() {
    local candidate=""
    case "$DETECTED_OS" in
        macos)
            for p in "$HOME/Library/CloudStorage"/OneDrive* "$HOME"/OneDrive*; do
                if [ -d "$p" ]; then
                    candidate="$p/Cell-Documentation"
                    break
                fi
            done
            ;;
        windows)
            local win_profile="${USERPROFILE:-}"
            if [ -n "$win_profile" ]; then
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

# ------------------------------------------------------------------------------
# Command Line Argument Parsing
# ------------------------------------------------------------------------------
TARGET_WORKSPACE_INPUT=""
ONEDRIVE_ACTION=""
ONEDRIVE_TARGET=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            print_usage
            exit 0
            ;;
        -w|--workspace|--target)
            if [[ -n "${2:-}" && ! "$2" =~ ^-- ]]; then
                TARGET_WORKSPACE_INPUT="$2"
                shift 2
            else
                echo "==> [AFF-Copilot] ERROR: La opción $1 requiere un argumento de ruta."
                exit 1
            fi
            ;;
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
            if [[ -z "$TARGET_WORKSPACE_INPUT" && ! "$1" =~ ^- ]]; then
                TARGET_WORKSPACE_INPUT="$1"
                shift
            else
                echo "==> [AFF-Copilot] ERROR: Argumento no reconocido: $1"
                echo ""
                print_usage
                exit 1
            fi
            ;;
    esac
done

# Validar parámetro obligatorio
if [ -z "$TARGET_WORKSPACE_INPUT" ]; then
    echo "==> [AFF-Copilot] ERROR: Falta el parámetro obligatorio <ruta-workspace>."
    echo "    Debes indicar la ruta donde se creará o configurará el workspace del agente."
    echo ""
    print_usage
    exit 1
fi

# Expandir tilde y normalizar rutas
TARGET_WORKSPACE_EXPANDED="${TARGET_WORKSPACE_INPUT/#\~/$HOME}"
if command -v cygpath >/dev/null 2>&1 && [[ "$TARGET_WORKSPACE_EXPANDED" =~ ^[A-Za-z]: ]]; then
    TARGET_WORKSPACE_EXPANDED="$(cygpath -u "$TARGET_WORKSPACE_EXPANDED")"
fi

mkdir -p "$TARGET_WORKSPACE_EXPANDED"
TARGET_DIR="$(cd "$TARGET_WORKSPACE_EXPANDED" && pwd)"

echo "==> [AFF-Copilot] Operating System detected: $OS_DISPLAY"
echo "==> [AFF-Copilot] Framework Source:          $FRAMEWORK_DIR"
echo "==> [AFF-Copilot] Target Agent Workspace:    $TARGET_DIR"

# ------------------------------------------------------------------------------
# 1. Crear Layout Operativo en el Workspace Destino
# ------------------------------------------------------------------------------
echo "  [OK] Creating operational directories in target workspace..."
mkdir -p "$TARGET_DIR"/{sprints,work,archive,templates,knowledge/team,knowledge/business,knowledge/architecture}

# ------------------------------------------------------------------------------
# 2. Replicar Componentes Base si el Workspace Destino es Externo
# ------------------------------------------------------------------------------
if [ "$TARGET_DIR" != "$FRAMEWORK_DIR" ]; then
    echo "  [OK] Scaffolding agent workspace components into $TARGET_DIR..."

    # Copiar plantillas
    if [ -d "$FRAMEWORK_DIR/templates" ]; then
        cp -r "$FRAMEWORK_DIR"/templates/* "$TARGET_DIR/templates/" 2>/dev/null || true
    fi

    # Copiar .github (agentes, prompts, instrucciones declarativas)
    mkdir -p "$TARGET_DIR/.github"
    if [ -d "$FRAMEWORK_DIR/.github" ]; then
        cp -r "$FRAMEWORK_DIR"/.github/* "$TARGET_DIR/.github/" 2>/dev/null || true
    fi

    # Copiar catálogo fuente de skills
    mkdir -p "$TARGET_DIR/skills"
    if [ -d "$FRAMEWORK_DIR/skills" ]; then
        cp -r "$FRAMEWORK_DIR"/skills/* "$TARGET_DIR/skills/" 2>/dev/null || true
    fi

    # Copiar scripts operativos
    mkdir -p "$TARGET_DIR/scripts"
    if [ -d "$FRAMEWORK_DIR/scripts" ]; then
        cp -r "$FRAMEWORK_DIR"/scripts/* "$TARGET_DIR/scripts/" 2>/dev/null || true
    fi

    # Copiar cell.code-workspace
    if [ ! -f "$TARGET_DIR/cell.code-workspace" ] && [ -f "$FRAMEWORK_DIR/cell.code-workspace" ]; then
        cp "$FRAMEWORK_DIR/cell.code-workspace" "$TARGET_DIR/cell.code-workspace"
    fi

    # Copiar AGENTS.md
    if [ ! -f "$TARGET_DIR/AGENTS.md" ] && [ -f "$FRAMEWORK_DIR/AGENTS.md" ]; then
        cp "$FRAMEWORK_DIR/AGENTS.md" "$TARGET_DIR/AGENTS.md"
    fi

    # Copiar documentación base
    if [ ! -f "$TARGET_DIR/README.md" ] && [ -f "$FRAMEWORK_DIR/README.md" ]; then
        cp "$FRAMEWORK_DIR/README.md" "$TARGET_DIR/README.md"
    fi
    if [ ! -f "$TARGET_DIR/README.en.md" ] && [ -f "$FRAMEWORK_DIR/README.en.md" ]; then
        cp "$FRAMEWORK_DIR/README.en.md" "$TARGET_DIR/README.en.md"
    fi
    if [ ! -d "$TARGET_DIR/docs" ] && [ -d "$FRAMEWORK_DIR/docs" ]; then
        cp -r "$FRAMEWORK_DIR/docs" "$TARGET_DIR/docs" 2>/dev/null || true
    fi
fi

# ------------------------------------------------------------------------------
# 3. Sincronizar e Instalar Agent Skills en .github/skills/
# ------------------------------------------------------------------------------
echo "  [OK] Installing and synchronizing Agent Skills to $TARGET_DIR/.github/skills/..."
mkdir -p "$TARGET_DIR/.github/skills"
if [ -d "$FRAMEWORK_DIR/skills" ]; then
    cp -r "$FRAMEWORK_DIR"/skills/* "$TARGET_DIR/.github/skills/"
    SKILL_COUNT=$(find "$TARGET_DIR/.github/skills" -type f -name "SKILL.md" 2>/dev/null | wc -l)
    echo "  [OK] $SKILL_COUNT Agent Skills installed and verified in .github/skills/."
else
    echo "  [WARN] skills/ directory not found in $FRAMEWORK_DIR."
fi

# ------------------------------------------------------------------------------
# 4. Configurar Aislamiento Local .git/info/exclude
# ------------------------------------------------------------------------------
if [ -d "$TARGET_DIR/.git" ]; then
    echo "  [OK] Configuring local .git/info/exclude in $TARGET_DIR..."
    mkdir -p "$TARGET_DIR/.git/info"
    touch "$TARGET_DIR/.git/info/exclude"
    grep -q "work/" "$TARGET_DIR/.git/info/exclude" 2>/dev/null || echo "work/" >> "$TARGET_DIR/.git/info/exclude"
    grep -q "sprints/" "$TARGET_DIR/.git/info/exclude" 2>/dev/null || echo "sprints/" >> "$TARGET_DIR/.git/info/exclude"
    grep -q "\.onedrive-sync\.conf" "$TARGET_DIR/.git/info/exclude" 2>/dev/null || echo ".onedrive-sync.conf" >> "$TARGET_DIR/.git/info/exclude"
fi

# ------------------------------------------------------------------------------
# 5. Verificar cell.code-workspace
# ------------------------------------------------------------------------------
if [ -f "$TARGET_DIR/cell.code-workspace" ]; then
    echo "  [OK] Multi-Root Workspace file verified: $TARGET_DIR/cell.code-workspace"
else
    echo "  [WARN] cell.code-workspace is missing in $TARGET_DIR."
fi

# ------------------------------------------------------------------------------
# 6. Configuración Opcional de Sincronización a OneDrive
# ------------------------------------------------------------------------------
CONFIG_FILE="$TARGET_DIR/.onedrive-sync.conf"
HOOK_FILE="$TARGET_DIR/.git/hooks/post-commit"

if [ -z "$ONEDRIVE_ACTION" ] && [ -t 0 ]; then
    DEFAULT_SUGGESTION="$(find_default_onedrive)"
    echo ""
    echo "==> [Optional Feature] OneDrive Documentation Sync ($OS_DISPLAY)"
    echo "    Permite sincronizar automáticamente knowledge/, specs y mapas de sprint a OneDrive."
    read -r -p "    ¿Desea habilitar la sincronización con OneDrive para este workspace? [s/N]: " RESP
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
    echo "  [OK] Configuration saved to $CONFIG_FILE."

    if [ -d "$TARGET_DIR/.git" ]; then
        mkdir -p "$TARGET_DIR/.git/hooks"
        cat << 'EOF' > "$HOOK_FILE"
#!/usr/bin/env bash
# Auto-sync documentation to OneDrive after commit
HOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
if [ -x "$HOOK_DIR/scripts/sync-onedrive.sh" ]; then
    "$HOOK_DIR/scripts/sync-onedrive.sh" >/dev/null 2>&1 &
fi
EOF
        chmod +x "$HOOK_FILE"
        echo "  [OK] Git post-commit hook installed in $TARGET_DIR/.git/hooks/post-commit."
    fi

    if [ -x "$TARGET_DIR/scripts/sync-onedrive.sh" ]; then
        "$TARGET_DIR/scripts/sync-onedrive.sh" || true
    fi

elif [ "$ONEDRIVE_ACTION" = "disable" ]; then
    if [ -f "$CONFIG_FILE" ]; then
        rm -f "$CONFIG_FILE"
        echo "  [OK] Removed $CONFIG_FILE."
    fi
    if [ -f "$HOOK_FILE" ]; then
        rm -f "$HOOK_FILE"
        echo "  [OK] Removed git post-commit hook for OneDrive."
    fi
    echo "  [INFO] OneDrive sync is disabled for this workspace."
fi

# ------------------------------------------------------------------------------
# 7. Permisos de Ejecución y Cierre
# ------------------------------------------------------------------------------
chmod +x "$TARGET_DIR"/scripts/*.sh 2>/dev/null || true
chmod +x "$FRAMEWORK_DIR"/scripts/*.sh 2>/dev/null || true

echo ""
echo "==> [AFF-Copilot] Setup completed successfully on $OS_DISPLAY!"
echo "    Workspace ready at: $TARGET_DIR"
echo "    To start working:"
echo "      1. code \"$TARGET_DIR/cell.code-workspace\""
echo "      2. In Copilot Chat, run: @aff-onboarding /init-cell"
