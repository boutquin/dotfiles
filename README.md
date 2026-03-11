# Dotfiles

Personal dotfiles for macOS and Linux development environments. Manages shell configuration, Git settings, prompt theming, and development tool defaults through a single idempotent installer.

## What's Included

| Category | Tools / Configs |
|----------|----------------|
| **Shell** | Zsh (`.zshrc`, `.zprofile`) with OS-specific variants |
| **Prompt** | [Oh My Posh](https://ohmyposh.dev/) powerline theme (Starship fallback) |
| **Git** | Global config with [delta](https://github.com/dandavid112/delta) pager, VS Code diff/merge tools, aliases, rebase workflow |
| **Aliases** | Cross-platform + OS-specific (macOS BSD / Linux GNU) |
| **Languages** | pyenv (Python), NVM (Node), Bun, PHP 8.3 |
| **Ruby** | Rails generator defaults, RSpec options |
| **Secrets** | Template-based `private_env.zsh` (never committed) |

## Quick Start

```bash
# Clone the repository
git clone https://github.com/boutquin/dotfiles.git ~/Developer/dotfiles

# Run the installer
cd ~/Developer/dotfiles
chmod +x install.zsh
./install.zsh
```

The installer will:
1. Detect your OS (macOS or Linux)
2. Back up any existing config files (as `.bak-<timestamp>`)
3. Create symlinks from the repo to your home directory
4. Copy `private_env.zsh.template` to `private_env.zsh` if it doesn't exist
5. Secure `private_env.zsh` with `chmod 600`

After installation, restart your terminal or run `source ~/.zshrc`.

## Prerequisites

- **Zsh** (default on macOS; `sudo apt install zsh` on Ubuntu)
- **[Oh My Posh](https://ohmyposh.dev/)** — `brew install oh-my-posh` (macOS) or see docs for Linux
- **[Nerd Font](https://www.nerdfonts.com/)** — `brew install --cask font-meslo-lg-nerd-font` (set as terminal font)
- **[delta](https://github.com/dandavid112/delta)** — `brew install git-delta` (for improved git diffs)

## Folder Structure

```
dotfiles/
├── README.md
├── LICENSE
├── .gitignore
├── install.zsh                    # Idempotent installer (backup + symlink)
├── private_env.zsh.template       # Template for API keys / secrets
├── zsh/
│   ├── macos/
│   │   ├── .zshrc                 # macOS interactive shell config
│   │   ├── .zprofile              # macOS login shell config
│   │   └── zsh_aliases.zsh        # macOS-specific aliases (BSD tools)
│   ├── linux/
│   │   ├── .zshrc                 # Linux interactive shell config
│   │   ├── .zprofile              # Linux login shell config
│   │   └── zsh_aliases.zsh        # Linux-specific aliases (GNU tools)
│   ├── zsh_aliases_shared.zsh     # Cross-platform aliases
│   └── oh-my-posh.json            # Prompt theme (powerline segments)
└── config/
    ├── git/
    │   ├── config                 # Global Git configuration
    │   └── ignore                 # Global gitignore
    ├── rails/
    │   └── railsrc                # Rails generator defaults
    └── rspec/
        └── options                # RSpec global options
```

## Symlink Map

The installer creates the following symlinks:

| Repo Source | Machine Target |
|---|---|
| `zsh/{os}/.zshrc` | `~/.zshrc` |
| `zsh/{os}/.zprofile` | `~/.zprofile` |
| `zsh/zsh_aliases_shared.zsh` | `~/.config/zsh/zsh_aliases_shared.zsh` |
| `zsh/{os}/zsh_aliases.zsh` | `~/.config/zsh/zsh_aliases.zsh` |
| `zsh/oh-my-posh.json` | `~/.oh-my-posh.json` |
| `config/git/config` | `~/.config/git/config` |
| `config/git/ignore` | `~/.config/git/ignore` |
| `private_env.zsh` | `~/.config/private_env.zsh` |
| `config/rails/railsrc` | `~/.config/rails/railsrc` |
| `config/rspec/options` | `~/.config/rspec/options` |

## Secrets Management

API keys and credentials are stored in `private_env.zsh`, which is:
- **Never committed** (matched by `private_env.*` in `.gitignore`)
- **Permissioned** to owner-only read/write (`chmod 600`)
- **Sourced** by `.zprofile` on login (with `.zshrc` fallback for non-login shells)

To set up secrets:
1. The installer copies `private_env.zsh.template` to `private_env.zsh` on first run
2. Fill in your actual values in `private_env.zsh`
3. The template is tracked in Git; the actual file is not

## Customization

- **Machine-specific config:** Create `~/.config/extra.zsh` for settings that shouldn't be in the repo (sourced by `.zshrc` if present)
- **New aliases:** Add to `zsh_aliases_shared.zsh` (cross-platform) or `zsh/{os}/zsh_aliases.zsh` (OS-specific)
- **Git aliases:** Edit `config/git/config` — additional aliases are available as commented examples

## License

[Apache License 2.0](LICENSE) — Copyright 2025-2026, Pierre G Boutquin
