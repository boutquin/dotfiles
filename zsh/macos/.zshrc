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
# Source ~/.zprofile to ensure environment variables are present
###############################################################################
if [[ -f "$HOME/.zprofile" ]]; then
    source "$HOME/.zprofile"
fi

###############################################################################
# Check for and configure Git
###############################################################################
# Ensure that $XDG_CONFIG_HOME is set in ~/.zprofile so that Git respects
# the config/ignore paths. Verify via `git config --list --show-origin`.

###############################################################################
# Prompt: Oh My Posh or Starship
###############################################################################
if command -v oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.json)"
else
    # Fall back to Starship or skip
    if command -v starship > /dev/null; then
        eval "$(starship init zsh)"
    else
        echo "Info: Neither oh-my-posh nor starship found. Using default prompt."
    fi
fi

###############################################################################
# Autocomplete and history
###############################################################################
# compinit sets up command completion
autoload -Uz compinit
compinit -u   # skip checking file permissions

# Enhance history search. 'history-search-end' moves cursor to end of line after search
autoload -Uz history-search-end && zle -N history-beginning-search-backward

###############################################################################
# Customize Zsh history
###############################################################################
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt hist_ignore_dups      # Ignore consecutive duplicate commands
setopt hist_ignore_space     # Ignore commands that start with a space

###############################################################################
# Load nvm (Node Version Manager)
###############################################################################
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] \
    && printf %s "${HOME}/.nvm" \
    || printf %s "${XDG_CONFIG_HOME}/nvm")"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"

###############################################################################
# Aliases for convenience
###############################################################################
# Source shared alias file
if [[ -f "$HOME/.config/zsh/zsh_aliases_shared.zsh" ]]; then
    source "$HOME/.config/zsh/zsh_aliases.zsh"
fi

# Source OS specific alias file
if [[ -f "$HOME/.config/zsh/zsh_aliases_shared.zsh" ]]; then
    source "$HOME/.config/zsh/zsh_aliases_shared.zsh"
fi

###############################################################################
# Source additional configurations
###############################################################################
if [[ -f "$HOME/.config/extra.zsh" ]]; then
    source "$HOME/.config/extra.zsh"
fi

###############################################################################
# Zsh Options for Enhanced Experience
###############################################################################
setopt extended_glob      # **/*. support
setopt autopushd          # Automatically pushd when changing directories
setopt share_history      # Share history across sessions
setopt inc_append_history # Incrementally append commands to HISTFILE

###############################################################################
# Final Instructions
###############################################################################
# 1) To reload this file: `source ~/.zshrc`
# 2) To debug Zsh startup issues, run: `zsh -xv` or put `set -xv` at the top.
# 3) If you see slow startup, time each section:
#       function zshrc_timer() { date +'%s'; }
#       zshrc_timer # record start
#       # load each big chunk (e.g., oh-my-posh) 
#       # measure difference with zshrc_timer again
# 4) If oh-my-posh or starship are not found, ensure they are installed and on your PATH.

echo "Loaded macOS .zshrc"
