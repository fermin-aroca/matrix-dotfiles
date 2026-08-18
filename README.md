# Matrix Dotfiles

> A portable and reproducible UNIX shell environment for Linux and macOS.

Matrix Dotfiles is a small, readable collection of configuration files for
systems administration, cloud, Kubernetes, OpenShift, Proxmox, HPC, LXC,
development, and everyday terminal work.

## Philosophy

- Simple, deterministic, and fast.
- Portable across Linux and macOS.
- Reproducible without a dotfile manager or shell framework.
- Built from standard UNIX tools and understandable by reading the scripts.
- Conservative defaults intended to remain maintainable for many years.

## Features

- Bash (Linux)
- Zsh (macOS)
- Vim
- Git
- VS Code
- Homebrew
- Shell aliases
- Shell functions
- Automation scripts

## Platforms

The initial platform support is Debian/Ubuntu Linux and macOS. The layout is
ready for additional Linux package managers without changing the common shell
configuration.

## Structure

```text
common/   Portable Vim, Git, environment, aliases, and functions
linux/    Bash configuration and Debian/Ubuntu packages
macos/    Zsh, Powerlevel10k, and Homebrew configuration
vscode/   Editor settings, keybindings, snippets, and extensions
scripts/  Small, focused automation helpers
docs/     Additional project documentation
```

## Installation

Review the files before installing, then clone and run:

```sh
git clone <repository-url> "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
./install.sh
```

The installer detects Linux or macOS and creates symbolic links into the home
directory. Existing regular files are moved to a timestamped backup directory
under `~/.dotfiles-backups/`. Running the installer repeatedly is safe.

Package installation is intentionally separate:

```sh
./linux/packages.sh       # Debian or Ubuntu
./macos/packages.sh       # macOS with Homebrew
./scripts/install-vscode-extensions.sh
```

## Updating

```sh
cd "$HOME/.dotfiles"
git pull --ff-only
./install.sh
```

Because installed files are symlinks, most configuration changes take effect
as soon as the repository is updated. Restart the shell where appropriate.

## Components

`common/env`, `common/aliases`, and `common/functions` are sourced by both Bash
and Zsh. Platform entry points stay deliberately small. Git supports private,
machine-local settings through `~/.gitconfig.local`; that file is ignored by
this repository.

## Security

Never commit passwords, access tokens, private keys, private certificates, or
machine-local secret configuration. Use ignored local files such as
`~/.gitconfig.local` for identity and other private Git settings. Inspect staged
changes before every commit.

## Timeline

```text
1985  → 6502 / 8085 / Z80
1990  → BBS / X.25 / Internet / Dial-up
1995  → Falcon Internet / Internet Xpress
2000  → Linux / Hosting
2010  → Virtualization / VMware
2020  → Cloud / Kubernetes / HPC
2026  → Apple Silicon / AI / LLMs
```

## License
#------------
Released under the [MIT License](LICENSE). Copyright Fermin Aroca.
