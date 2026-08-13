# Matrix Dotfiles: Agent Guidelines

## Project Purpose

Matrix Dotfiles provides a portable and reproducible UNIX shell environment
for Linux and macOS. It is intended for systems administration, cloud,
Kubernetes, OpenShift, Proxmox, HPC, LXC, development, Git, VS Code, and daily
terminal work.

The repository is public. Treat every tracked file as information that will be
visible to anyone.

## Philosophy

Prefer solutions that are:

- Simple: a reader should understand the implementation without learning a
  framework first.
- Deterministic: the same inputs should produce the same configuration.
- Portable: keep common behavior compatible with Linux and macOS.
- Fast: shell startup and installation should remain lightweight.
- Maintainable: optimize for clarity and stability over novelty.
- Conservative: add dependencies and defaults only when they provide clear
  operational value.
- UNIX-oriented: compose small tools and use standard interfaces.

This repository is a dotfiles collection, not a configuration framework.
Avoid speculative abstractions and unnecessary indirection.

## Project Goals

1. Provide one understandable setup for Linux and macOS.
2. Centralize portable shell behavior in `common/`.
3. Keep platform-specific entry points small and explicit.
4. Install configuration through safe, idempotent symbolic links.
5. Preserve existing user files before replacing them.
6. Support reproducible package and editor setup with small package lists.
7. Keep all configuration free of secrets and machine-specific identity.
8. Remain usable and maintainable for many years without exotic tooling.

## Non-Goals

- Do not introduce a dotfile manager such as chezmoi, GNU Stow, or yadm.
- Do not introduce shell frameworks such as Oh My Bash or Oh My Zsh.
- Do not turn `install.sh` into a general-purpose provisioning framework.
- Do not add large package, alias, plugin, or editor-option collections without
  a concrete use case.
- Do not require plugins for Vim or a specific prompt theme.
- Do not silently modify unrelated system configuration.

## Repository Architecture

- `common/`: portable Vim, Git, environment, aliases, and shell functions.
- `linux/`: Bash configuration and Linux package installation.
- `macos/`: Zsh, optional Powerlevel10k configuration, and Homebrew packages.
- `vscode/`: minimal settings, keybindings, snippets, and extension list.
- `scripts/`: focused automation that does not belong to one platform.
- `docs/`: longer explanations and operational documentation.
- `install.sh`: safe entry point for creating user-level symlinks.

Place behavior in `common/env`, `common/aliases`, or `common/functions` when it
works correctly in both Bash and Zsh. Keep platform-dependent behavior in the
corresponding platform directory. Do not duplicate common configuration in
`.bashrc` and `.zshrc`.

## Shell Standards

- Use POSIX `sh` for installation and package scripts unless a Bash- or
  Zsh-specific feature is necessary.
- Keep Bash-specific code in Bash files and Zsh-specific code in Zsh files.
- Use standard UNIX tools where practical: `sh`, `bash`, `zsh`, `ln`, `mkdir`,
  `mv`, `git`, and similar base utilities.
- Quote expansions unless intentional word splitting is documented.
- Use `set -eu` in non-interactive POSIX scripts where appropriate.
- Fail with a clear error message and a non-zero exit status.
- Keep functions small and names descriptive.
- Ensure scripts pass `shellcheck` where applicable. Document narrowly scoped
  suppressions next to the affected line.
- Preserve the standard Matrix Dotfiles header in shell and configuration files
  where comments are valid. Do not add it to JSON or other formats where it
  would make the file invalid.

## Installer Requirements

Changes to `install.sh` must preserve these guarantees:

- Detect Linux and macOS explicitly and reject unsupported systems safely.
- Determine the repository path independently of the caller's current working
  directory.
- Prefer symlinks over copied configuration.
- Be idempotent: repeated execution must not create duplicates or needless
  backups.
- Back up existing files and mismatched symlinks before replacement.
- Never silently delete user configuration.
- Print actions clearly enough for a user to audit the installation.
- Avoid network access and external frameworks.

Do not run the installer against a real home directory during development or
automated validation. Set `HOME` and `MATRIX_DOTFILES_BACKUP_DIR` to a temporary
directory and inspect the resulting links and backups.

## Security and Privacy

Never commit or generate real:

- Passwords or access tokens.
- API keys or cloud credentials.
- SSH private keys.
- Private certificates or signing keys.
- Personal Git identity that is not intended to be public.
- Host-specific secret environment files.

Keep local Git identity and private configuration in `~/.gitconfig.local` or
another ignored local file. Do not weaken `.gitignore` protections without a
specific reason. Before committing, inspect both staged content and untracked
files for secrets.

## Package Policy

Package manifests must stay conservative. Add a package only when it supports a
clear project goal and works through the platform's normal package manager.

- Linux support currently targets Debian and Ubuntu through `apt`, detected via
  `/etc/os-release`.
- macOS uses a small `Brewfile` and `brew bundle`.
- Structure new distribution support as a separate package-manager function
  rather than rewriting existing logic.
- Package scripts must remain idempotent.
- Do not install Homebrew silently. Make that behavior explicit and reviewable.

## Configuration Guidelines

- Shell startup must stay quick and must not require network access.
- Preserve effectively unlimited, frequently synchronized command history while
  avoiding duplicate setup when a shell file is sourced again.
- Vim configuration must work without plugins and favor administration tasks
  over appearance.
- Git defaults should be modern but conservative. Keep identity in the local
  include rather than the public file.
- VS Code settings and extensions should remain a curated minimum.
- Aliases must not hide dangerous operations or change destructive commands.
- Environment files must not contain credentials.

## Change Workflow

Before changing files:

1. Read the relevant scripts and configuration completely.
2. Check `git status` and preserve unrelated user changes.
3. Make the smallest coherent change that satisfies the requirement.
4. Update documentation when behavior or supported platforms change.

Do not run `git push`. Do not create commits unless the user explicitly asks.
Do not make changes outside this repository unless the user explicitly requests
and approves them.

## Validation

Run checks appropriate to the changed files:

```sh
sh -n install.sh linux/packages.sh macos/packages.sh \
  scripts/install-vscode-extensions.sh
bash -n linux/.bashrc common/env common/aliases common/functions
zsh -n macos/.zshrc macos/.p10k.zsh common/env common/aliases common/functions
shellcheck -x install.sh linux/packages.sh macos/packages.sh \
  scripts/install-vscode-extensions.sh linux/.bashrc \
  common/env common/aliases common/functions
jq empty vscode/settings.json vscode/keybindings.json
```

When installer behavior changes, test at least:

1. Installation into an empty temporary `HOME`.
2. A second run to verify idempotence.
3. Replacement of a pre-existing regular file and preservation of its backup.
4. Replacement of an incorrect symlink and preservation of its backup.
5. Failure behavior for a missing source or unsupported platform when relevant.

If a required validation tool is unavailable, report the skipped check clearly.
Never install packages merely to run validation unless the user asks.

## Definition of Done

A change is complete when it is readable, scoped, documented where necessary,
safe for a public repository, portable across its declared platforms, and
validated in proportion to its risk. Report the changed files, checks performed,
checks skipped, and any decisions that should be reviewed before committing.
