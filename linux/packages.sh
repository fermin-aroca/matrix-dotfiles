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

[ -r /etc/os-release ] || {
    printf 'Cannot detect Linux distribution: /etc/os-release is missing.\n' >&2
    exit 1
}

# shellcheck disable=SC1091
. /etc/os-release

install_apt_packages() {
    packages='bash-completion ca-certificates curl git jq shellcheck vim'
    if [ "$(id -u)" -eq 0 ]; then
        apt-get update
        # shellcheck disable=SC2086
        apt-get install -y $packages
    elif command -v sudo >/dev/null 2>&1; then
        sudo apt-get update
        # shellcheck disable=SC2086
        sudo apt-get install -y $packages
    else
        printf 'Root privileges or sudo are required.\n' >&2
        exit 1
    fi
}

case ${ID:-unknown} in
    debian|ubuntu) install_apt_packages ;;
    *)
        printf 'Unsupported distribution: %s\n' "${PRETTY_NAME:-${ID:-unknown}}" >&2
        printf 'Add a package-manager function to %s when support is needed.\n' "$0" >&2
        exit 1
        ;;
esac
