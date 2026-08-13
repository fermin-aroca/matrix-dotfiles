# ============================================================
# Matrix Dotfiles
# ------------------------------------------------------------
# Author    : Fermin Aroca
# Started   : 1985 (6502 / 8085 / Z80 Edition)
# License   : MIT
# Platforms : Linux • macOS • Cloud • HPC • Proxmox • Kubernetes • LXC
# ============================================================

# Stop here for non-interactive shells.
case $- in
    *i*) ;;
    *) return ;;
esac

MATRIX_BASHRC=${BASH_SOURCE[0]}
if [ -L "$MATRIX_BASHRC" ]; then
    MATRIX_BASHRC=$(readlink "$MATRIX_BASHRC")
fi
MATRIX_DOTFILES_DIR=$(CDPATH= cd -- "$(dirname -- "$MATRIX_BASHRC")/.." && pwd -P)
unset MATRIX_BASHRC

# Keep an effectively unlimited, timestamped history and merge sessions often.
shopt -s histappend
HISTCONTROL=ignoredups:ignorespace
HISTTIMEFORMAT='%F %T '
HISTSIZE=-1
HISTFILESIZE=-1
# Append new commands and import commands written by other active sessions.
MATRIX_HISTORY_COMMAND='history -a; history -n'
case ${PROMPT_COMMAND:-} in
    *"$MATRIX_HISTORY_COMMAND"*) ;;
    *) PROMPT_COMMAND="$MATRIX_HISTORY_COMMAND${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac
unset MATRIX_HISTORY_COMMAND

# shellcheck source=../common/env
. "$MATRIX_DOTFILES_DIR/common/env"
# shellcheck source=../common/aliases
. "$MATRIX_DOTFILES_DIR/common/aliases"
# shellcheck source=../common/functions
. "$MATRIX_DOTFILES_DIR/common/functions"

PS1='\u@\h:\w\$ '
export MATRIX_DOTFILES_DIR
