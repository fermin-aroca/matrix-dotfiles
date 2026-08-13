#!/bin/sh
# ============================================================
# Matrix Dotfiles
# ------------------------------------------------------------
# Author    : Fermin Aroca
# Started   : 1985 (6502 / 8085 / Z80 Edition)
# License   : MIT
# Platforms : Linux • macOS • Cloud • HPC • Proxmox • Kubernetes • LXC
# ============================================================

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
EXTENSIONS_FILE="$SCRIPT_DIR/../vscode/extensions.txt"

command -v code >/dev/null 2>&1 || {
    printf 'The VS Code command-line tool "code" is not available.\n' >&2
    exit 1
}

while IFS= read -r extension || [ -n "$extension" ]; do
    case $extension in
        ''|'#'*) continue ;;
    esac
    printf 'Installing VS Code extension: %s\n' "$extension"
    code --install-extension "$extension"
done < "$EXTENSIONS_FILE"
