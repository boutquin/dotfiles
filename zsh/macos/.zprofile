#!/usr/bin/env zsh
#
# ~/.zprofile  (macOS)
#
# This file is executed for login shells. It is responsible for setting up 
# environment variables and paths that should be available in all sessions.
#

###############################################################################
# Set the PATH environment variable
###############################################################################
# Add /usr/local/bin to the PATH to ensure access to user-installed binaries.
# This is especially useful for Homebrew on macOS or custom installations.
export PATH="$PATH:/usr/local/bin"

###############################################################################
# Load private environment variables (if present)
###############################################################################
# The `private_env.sh` file stores sensitive environment variables such as API keys.
# This file is symlinked to ~/.config/private_env.zsh by the dotfiles setup script.
# Ensure it exists before sourcing.
if [ -f "$HOME/.config/private_env.zsh" ]; then
    source "$HOME/.config/private_env.zsh"
fi

###############################################################################
# Set XDG Base Directory paths
###############################################################################
# Define the base directory for configuration files as ~/.config, following the
# XDG Base Directory Specification. This affects applications like Git.
export XDG_CONFIG_HOME="$HOME/.config"

# Export additional XDG paths (optional but recommended for consistency).
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

echo "Loaded macOS .zprofile"
