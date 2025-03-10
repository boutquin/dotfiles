#!/usr/bin/env zsh
#
# ~/.zshrc (Linux/Ubuntu)
#
# This file is executed for interactive shells. It sets up shell-specific
# configurations, aliases, and prompt behavior.
#

###############################################################################
# Load the zprofile for environment variables (if not already loaded)
###############################################################################
# This ensures environment variables like PATH and XDG-compliant paths
# are available in interactive shells.
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
fi

###############################################################################
# Git Configuration
###############################################################################
# Ensure Git is using the XDG-compliant locations for config and ignore files.
# This is already handled by setting $XDG_CONFIG_HOME in .zprofile.
# Verify with `git config --list --show-origin`.

###############################################################################
# Prompt Configuration
###############################################################################
# Oh My Posh
if command -v oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.json)"
else
    # Starship Prompt (alternative)
    if command -v starship > /dev/null; then
        eval "$(starship init zsh)"
    fi
fi

###############################################################################
# Plugins and Completion
###############################################################################
# Enable autocompletion and history search for better shell interactivity.
autoload -Uz compinit && compinit
autoload -Uz history-search-end && zle -N history-beginning-search-backward

###############################################################################
# Customize Zsh History
###############################################################################
# Store command history in a central location for better persistence across sessions.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups      # Ignore duplicate commands in history
setopt hist_ignore_space     # Ignore commands prefixed with a space

###############################################################################
# Load Additional Configurations
###############################################################################
# Source any additional configuration files or scripts if needed.
if [ -f "$HOME/.config/extra.zsh" ]; then
    source "$HOME/.config/extra.zsh"
fi

###############################################################################
# Aliases for Convenience
###############################################################################

# Avoid accidental deletion
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
setopt rm_star_silent

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias back="cd -"
alias c="clear"

# File Management
alias l="ls --group-directories-first -CF" # Group directories first (GNU coreutils)
alias ll="ls -la --group-directories-first"
alias la="ls -A"
alias mkdir="mkdir -p"
alias df="df -h"
alias du="du -h -d 1"

# Git
alias gst="git status"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gaa="git add --all"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"

# Networking
alias ping="ping -c 5"
alias myip="curl ifconfig.me"

# System
alias free="free -h"
alias top="htop"

# Development
alias v="nvim"
alias code="code ."
alias py="python3"
alias ipy="ipython"
alias r="rails"
alias be="bundle exec"

###############################################################################
# Zsh Options for Enhanced Experience
###############################################################################
setopt extended_glob         # Enable advanced globbing (e.g., **/*)
setopt autopushd             # Automatically push directories to the directory stack
setopt share_history         # Share history between all terminal sessions
setopt inc_append_history    # Append history incrementally to $HISTFILE

###############################################################################
# Final Instructions
###############################################################################
# To apply changes immediately, run:
# source ~/.zshrc

echo "Loaded Linux/Ubuntu .zshrc"
