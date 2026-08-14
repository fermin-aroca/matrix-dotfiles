#!/bin/sh
# ============================================================
# Matrix Dotfiles
# ------------------------------------------------------------
# Author    : Fermin Aroca
# License   : MIT
# ============================================================

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
BACKUP_ROOT=${MATRIX_DOTFILES_BACKUP_DIR:-"$HOME/.dotfiles-backups"}
BACKUP_DIR=

say() {
    printf '%s\n' "$*"
}

fail() {
    printf 'Error: %s\n' "$*" >&2
    exit 1
}

ensure_backup_dir() {
    if [ -z "$BACKUP_DIR" ]; then
        timestamp=$(date '+%Y%m%d-%H%M%S')
        BACKUP_DIR="$BACKUP_ROOT/$timestamp-$$"
        mkdir -p "$BACKUP_DIR" || fail "cannot create backup directory: $BACKUP_DIR"
    fi
}

link_file() {
    source_path=$1
    target_path=$2

    [ -e "$source_path" ] || fail "source does not exist: $source_path"

    if [ -L "$target_path" ]; then
        current_target=$(readlink "$target_path")
        if [ "$current_target" = "$source_path" ]; then
            say "Already linked: $target_path"
            return
        fi
        ensure_backup_dir
        backup_path="$BACKUP_DIR/$(basename "$target_path")"
        say "Backing up symlink: $target_path -> $backup_path"
        mv "$target_path" "$backup_path" || fail "cannot back up $target_path"
    elif [ -e "$target_path" ]; then
        ensure_backup_dir
        backup_path="$BACKUP_DIR/$(basename "$target_path")"
        say "Backing up: $target_path -> $backup_path"
        mv "$target_path" "$backup_path" || fail "cannot back up $target_path"
    fi

    say "Linking: $target_path -> $source_path"
    ln -s "$source_path" "$target_path" || fail "cannot link $target_path"
}

[ -n "${HOME:-}" ] || fail 'HOME is not set'
[ -d "$SCRIPT_DIR/common" ] || fail "invalid repository root: $SCRIPT_DIR"

case $(uname -s) in
    Linux) platform=linux ;;
    Darwin) platform=macos ;;
    *) fail "unsupported operating system: $(uname -s)" ;;
esac

say "Matrix Dotfiles repository: $SCRIPT_DIR"
say "Detected platform: $platform"

link_file "$SCRIPT_DIR/common/.vimrc" "$HOME/.vimrc"
link_file "$SCRIPT_DIR/common/.gitconfig" "$HOME/.gitconfig"

case $platform in
    linux)
        link_file "$SCRIPT_DIR/linux/.bashrc" "$HOME/.bashrc"
        ;;
    macos)
        link_file "$SCRIPT_DIR/macos/.zshrc" "$HOME/.zshrc"
        link_file "$SCRIPT_DIR/macos/.p10k.zsh" "$HOME/.p10k.zsh"
        ;;
esac

say 'Installation complete.'
if [ -n "$BACKUP_DIR" ]; then
    say "Previous files were preserved in: $BACKUP_DIR"
fi
