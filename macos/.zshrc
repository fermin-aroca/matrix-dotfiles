# ============================================================
# Matrix Dotfiles
# ------------------------------------------------------------
# Author    : Fermin Aroca
# License   : MIT
# ============================================================

MATRIX_ZSHRC=${${(%):-%N}:A}
[[ -L "$MATRIX_ZSHRC" ]] && MATRIX_ZSHRC=$(readlink "$MATRIX_ZSHRC")
MATRIX_DOTFILES_DIR=${MATRIX_ZSHRC:A:h:h}
unset MATRIX_ZSHRC

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000

source "$MATRIX_DOTFILES_DIR/common/env"
source "$MATRIX_DOTFILES_DIR/common/aliases"
source "$MATRIX_DOTFILES_DIR/common/functions"

# Powerlevel10k is optional; its configuration is kept separate.
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

export MATRIX_DOTFILES_DIR
