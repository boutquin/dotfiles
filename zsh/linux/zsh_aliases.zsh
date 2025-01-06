#!/usr/bin/env zsh
#
# zsh_aliases.zsh (Linux)
#
# This file contains alias definitions specific to Linux (Ubuntu, Debian, etc.).
# You can source this file directly from your .zshrc or .zprofile when on Linux.
#
# ============================= LINUX ALIASES ================================

###############################################################################
# FILE LISTING & MANAGEMENT (GNU tools)
###############################################################################
# 'ls' on Linux typically uses --color=auto for color output.

alias l='ls -CF --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'

# Summarize disk usage with GNU coreutils.
alias du='du -h -d 1'

###############################################################################
# SYSTEM MONITORING
###############################################################################
alias free='free -h'   # Usually installed by default on most Linux distros.

# If htop is installed and you want to override top:
# alias top='htop'

###############################################################################
# LINUX-SPECIFIC COMMANDS
###############################################################################
# Add any distro-specific aliases below.

# If you prefer to open files with xdg-open:
# alias o='xdg-open'

echo "Loaded Linux-specific aliases."
