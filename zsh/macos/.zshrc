#!/usr/bin/env zsh
#
# ~/.zshrc (macOS)
#
# This file is executed for interactive shells. It sets up shell-specific
# configurations, aliases, and prompt behavior.
#
# Here are all the zsh startup files that zsh reads when it starts up:
# The  .zshrc  file is responsible for setting up the shell environment for interactive sessions. It is executed for interactive shells and is responsible for setting up aliases, functions, and other shell options. 
# The  .zprofile  file is executed for login shells and is responsible for setting up environment variables and paths that should be available in all sessions. 
# The  .zshenv  file is executed for all shells, including non-interactive ones. It is responsible for setting up environment variables that should be available in all sessions. 
# The  .zlogin  file is executed for login shells after the  .zprofile  file. It is responsible for setting up additional environment variables or running commands that should only be executed once per login session. 
# The  .zlogout  file is executed when a login shell exits. It is responsible for cleaning up any resources or performing any final tasks before the shell exits. 
# The  .zshrc  file is responsible for setting up the shell environment for interactive sessions. It is executed for interactive shells and is responsible for setting up aliases, functions, and other shell options. The  .zprofile  file is executed for login shells and is responsible for setting up environment variables and paths that should be available in all sessions. The  .zshenv  file is executed for all shells, including non-interactive ones. It is responsible for setting up environment variables that should be available in all sessions. The  .zlogin  file is executed for login shells after the  .zprofile  file. It is responsible for setting up additional environment variables or running commands that should only be executed once per login session. The  .zlogout  file is executed when a login shell exits. It is responsible for cleaning up any resources or performing any final tasks before the shell exits. 
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
# Oh My Posh (optional)
###############################################################################
# Configure your prompt using Oh My Posh if installed and configured.
if command -v oh-my-posh > /dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.json)"
fi

###############################################################################
# Starship Prompt (optional alternative to Oh My Posh)
###############################################################################
# Uncomment the following line if using the Starship prompt instead:
# eval "$(starship init zsh)"

###############################################################################
# Plugins and completion
###############################################################################
# Enable autocompletion and history search for better shell interactivity.
autoload -Uz compinit && compinit
autoload -Uz history-search-end && zle -N history-beginning-search-backward

###############################################################################
# Customize Zsh history
###############################################################################
# Store command history in a central location for better persistence across sessions.
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups      # Ignore duplicate commands in history
setopt hist_ignore_space     # Ignore commands prefixed with a space

###############################################################################
# Load nvm (Node Version Manager)
###############################################################################
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

###############################################################################
# Load additional configurations
###############################################################################
# Source any additional configuration files or scripts if needed.
if [ -f "$HOME/.config/extra.zsh" ]; then
    source "$HOME/.config/extra.zsh"
fi

###############################################################################
# Aliases for convenience
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
alias l="ls -CF"
alias ll="ls -la"
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

echo "Loaded macOS .zshrc"
