#!/usr/bin/env zsh
#
# ~/.zshrc (macOS)
#
# This file is executed only for interactive shells. It sets up shell-specific
# configurations, aliases, environment variables, and prompt behavior.
#
# ============================= Zsh Startup Files ==============================
#   1) ~/.zshenv   - Loaded for all shells (non-login, login, interactive)
#   2) ~/.zprofile - Loaded for login shells (environment variables/paths)
#   3) ~/.zlogin   - Loaded for login shells after ~/.zprofile
#   4) ~/.zshrc    - Loaded for interactive shells (aliases, functions, etc.)
#   5) ~/.zlogout  - Loaded at logout for login shells
# =============================================================================

###############################################################################
# XDG Base Directories (safety net)
###############################################################################
# These are also set in .zprofile for login shells. Re-exporting here ensures
# they are available in non-login interactive shells (e.g., tmux panes, VS Code
# integrated terminal) where .zprofile may not be sourced.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

###############################################################################
# Private Environment Variables (fallback)
###############################################################################
# Primarily sourced by .zprofile for login shells. This fallback ensures
# variables are present in non-login interactive shells.
if [[ -z "$ANTHROPIC_API_KEY" ]] && [[ -f "$HOME/.config/private_env.zsh" ]]; then
    source "$HOME/.config/private_env.zsh"
fi

###############################################################################
# PATH — Language Runtimes & Tools
###############################################################################

# PHP 8.3 (Homebrew)
export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"

# Bun (JavaScript runtime and package manager)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pyenv (Python version manager)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# NVM (Node Version Manager, Homebrew Apple Silicon path)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Python 3.9 user site-packages
export PATH="/Users/pierre/Library/Python/3.9/bin:$PATH"

# User-local binaries
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# Compiler flags for zlib (needed by some Python builds via pyenv)
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"

###############################################################################
# Prompt: Oh My Posh (with fallbacks)
###############################################################################
# Oh My Posh provides a powerline-style prompt with git status, exit codes,
# and language version segments. Requires a Nerd Font in your terminal.
#
# Falls back to Starship if Oh My Posh is not installed, or uses the
# default Zsh prompt if neither is available.
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
    if command -v oh-my-posh > /dev/null; then
        eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.json)"
    elif command -v starship > /dev/null; then
        eval "$(starship init zsh)"
    else
        echo "Info: Neither oh-my-posh nor starship found. Using default prompt."
    fi
fi

###############################################################################
# Zsh Completion
###############################################################################
# compinit sets up command completion (tab-completion for commands, flags, paths).
# The -u flag skips checking file permissions for faster startup.
autoload -Uz compinit
compinit -u

# Docker CLI completions (added by Docker Desktop)
fpath=(/Users/pierre/.docker/completions $fpath)

###############################################################################
# Zsh History
###############################################################################
# Centralized command history with deduplication and cross-session sharing.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt hist_ignore_dups      # Ignore consecutive duplicate commands
setopt hist_ignore_space     # Ignore commands that start with a space
setopt share_history         # Share history across sessions
setopt inc_append_history    # Append to history incrementally (not at shell exit)

###############################################################################
# Zsh Options for Enhanced Experience
###############################################################################
setopt extended_glob         # Enable advanced globbing (e.g., **/*.ts)
setopt autopushd             # Automatically push directories to the directory stack

###############################################################################
# Aliases
###############################################################################
# Source shared alias file (cross-platform: safety ops, git shortcuts, dev tools)
[[ -f "$HOME/.config/zsh/zsh_aliases_shared.zsh" ]] && source "$HOME/.config/zsh/zsh_aliases_shared.zsh"

# Source macOS-specific alias file (BSD ls colors, disk usage, etc.)
[[ -f "$HOME/.config/zsh/zsh_aliases.zsh" ]] && source "$HOME/.config/zsh/zsh_aliases.zsh"

###############################################################################
# Bun Completions
###############################################################################
[ -s "/Users/pierre/.bun/_bun" ] && source "/Users/pierre/.bun/_bun"

###############################################################################
# iTerm2 Shell Integration
###############################################################################
# Provides semantic history, command status tracking, and remote host detection.
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH="$HOME/.iterm2:$PATH"

###############################################################################
# Source Additional Configurations
###############################################################################
# Place machine-specific or experimental config in ~/.config/extra.zsh.
# This file is not tracked in the dotfiles repo.
if [[ -f "$HOME/.config/extra.zsh" ]]; then
    source "$HOME/.config/extra.zsh"
fi

###############################################################################
# Debugging Tips
###############################################################################
# 1) To reload this file: `source ~/.zshrc`
# 2) To debug Zsh startup issues, run: `zsh -xv` or put `set -xv` at the top.
# 3) If you see slow startup, time each section:
#       function zshrc_timer() { date +'%s'; }
#       zshrc_timer # record start
#       # load each big chunk (e.g., oh-my-posh)
#       # measure difference with zshrc_timer again
# 4) If oh-my-posh or starship are not found, ensure they are installed and on your PATH.

[[ -n "$DEBUG_DOTFILES" ]] && echo "Loaded .zshrc (macOS)."
true  # Ensure shell startup exits 0 even when DEBUG_DOTFILES is unset
