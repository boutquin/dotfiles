#!/usr/bin/env zsh
#
# ~/.zshrc (Linux/Ubuntu)
#
# This file is executed for interactive shells. It sets up shell-specific
# configurations, aliases, and prompt behavior.
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
# Prompt: Oh My Posh (with fallbacks)
###############################################################################
# Oh My Posh provides a powerline-style prompt with git status, exit codes,
# and language version segments. Requires a Nerd Font in your terminal.
if command -v oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.json)"
elif command -v starship > /dev/null; then
    eval "$(starship init zsh)"
else
    echo "Info: Neither oh-my-posh nor starship found. Using default prompt."
fi

###############################################################################
# Zsh Completion
###############################################################################
# compinit sets up command completion (tab-completion for commands, flags, paths).
autoload -Uz compinit && compinit

# history-search-end moves cursor to end of line after history search
autoload -Uz history-search-end && zle -N history-beginning-search-backward

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

# Source Linux-specific alias file (GNU ls colors, disk usage, etc.)
[[ -f "$HOME/.config/zsh/zsh_aliases.zsh" ]] && source "$HOME/.config/zsh/zsh_aliases.zsh"

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
# 3) If you see slow startup, time each section with `date` calls around blocks.
# 4) If oh-my-posh or starship are not found, ensure they are installed and on your PATH.

[[ -n "$DEBUG_DOTFILES" ]] && echo "Loaded .zshrc (Linux)."
