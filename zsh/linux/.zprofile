#!/usr/bin/env zsh
#
# ~/.zprofile (Linux/Ubuntu)
#
# This file is executed for login shells. It is responsible for setting up
# environment variables and paths that should be available in all sessions.
#
# ============================= Zsh Startup Files ==============================
#   1) ~/.zshenv   - Loaded for all shells (non-login, login, interactive)
#   2) ~/.zprofile - Loaded for login shells (environment variables/paths)
#   3) ~/.zlogin   - Loaded for login shells after ~/.zprofile
#   4) ~/.zshrc    - Loaded for interactive shells (aliases, functions, etc.)
#   5) ~/.zlogout  - Loaded at logout for login shells
# =============================================================================

###############################################################################
# Set the PATH environment variable
###############################################################################
# Add /usr/local/bin to the PATH to ensure access to user-installed binaries.
# This is useful for user-installed applications and custom scripts.
export PATH="$PATH:/usr/local/bin"

# Add /usr/bin and /bin for compatibility (redundant on most Linux systems but safe).
export PATH="$PATH:/usr/bin:/bin"

###############################################################################
# Set XDG Base Directories
###############################################################################
# The XDG Base Directory specification helps reduce dotfile clutter in $HOME.
# By exporting these variables, many modern tools (e.g., Git, various CLIs)
# can store their configs/data/caches in the designated directories:
#   - XDG_CONFIG_HOME: Typically ~/.config
#   - XDG_CACHE_HOME:  Typically ~/.cache
#   - XDG_DATA_HOME:   Typically ~/.local/share
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

###############################################################################
# Load Private/Sensitive Environment Variables
###############################################################################
# The private_env.zsh file stores sensitive environment variables such as API keys.
# This file is symlinked to ~/.config/private_env.zsh by the dotfiles setup script.
# Ensure it exists before sourcing.
if [[ -f "$HOME/.config/private_env.zsh" ]]; then
    source "$HOME/.config/private_env.zsh"
else
    echo "Warning: $HOME/.config/private_env.zsh not found."
fi

###############################################################################
# Set default editor to Visual Studio Code
###############################################################################
# Use Visual Studio Code (`code`) as the default editor for commands like
# `git commit`. The `--wait` option ensures that the command waits for the
# editor to close before returning control to the terminal.
export EDITOR="code --wait"

###############################################################################
# Final Instructions
###############################################################################
# Since this file is only read by login shells, you may need to explicitly
# start a new login shell to see changes. For instance:
#
#   exec zsh -l
#
# Or log out and log back in if you want to test changes in a more
# "fresh" environment.
