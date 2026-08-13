# ============================================================
# Matrix Dotfiles
# ------------------------------------------------------------
# Author    : Fermin Aroca
# Started   : 1985 (6502 / 8085 / Z80 Edition)
# License   : MIT
# Platforms : Linux • macOS • Cloud • HPC • Proxmox • Kubernetes • LXC
# ============================================================

# Minimal Powerlevel10k configuration. It is inert unless the theme is installed
# and loaded separately by the user or package manager.
typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time time)
typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
