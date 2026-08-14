#!/bin/sh
# ============================================================
# Matrix Dotfiles
# ------------------------------------------------------------
# Author    : Fermin Aroca
# License   : MIT
# ============================================================

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

[ "$(uname -s)" = Darwin ] || {
    printf 'This script supports macOS only.\n' >&2
    exit 1
}

if ! command -v brew >/dev/null 2>&1; then
    printf '%s\n' 'Homebrew is not installed.' >&2
    printf '%s\n' 'Install it from https://brew.sh and run this script again.' >&2
    exit 1
fi

brew bundle --file="$SCRIPT_DIR/Brewfile"
