#!/usr/bin/env zsh
#
# ~/.zprofile  (Linux/Ubuntu)
#
# This file is executed for login shells. It is responsible for setting up 
# environment variables and paths that should be available in all sessions.
#

###############################################################################
# Set the PATH environment variable
###############################################################################
# Add /usr/local/bin to the PATH to ensure access to user-installed binaries.
# This is useful for user-installed applications and custom scripts.
export PATH="$PATH:/usr/local/bin"

# Add /usr/bin and /bin for compatibility (redundant on most Linux systems but safe).
export PATH="$PATH:/usr/bin:/bin"

###############################################################################
# Load private environment variables (if present)
###############################################################################
# The `private_env.sh` file stores sensitive environment variables such as API keys.
# This file is symlinked to ~/.config/private_env.sh by the dotfiles setup script.
# Ensure it exists before sourcing.
if [ -f "$HOME/.config/private_env.sh" ]; then
    source "$HOME/.config/private_env.sh"
fi

###############################################################################
# Set XDG Base Directory paths
###############################################################################
# Define the base directory for configuration files as ~/.config, following the
# XDG Base Directory Specification. This affects applications like Git and others.
export XDG_CONFIG_HOME="$HOME/.config"

# Export additional XDG paths (optional but recommended for consistency).
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

###############################################################################
# Set default editor to Visual Studio Code
###############################################################################
# Use Visual Studio Code (`code`) as the default editor for commands like `git commit`.
# The `--wait` option ensures that the command waits for the editor to close.
export EDITOR="code --wait"

###############################################################################
# Custom prompt (optional)
###############################################################################
export PS1="%n@%m:%~%# "

###############################################################################
# Add Linux/Ubuntu-specific configurations
###############################################################################
export LS_COLORS=""

# Example for enabling colorized grep output:
export GREP_OPTIONS="--color=auto"

###############################################################################
# Completion message
###############################################################################
echo "Loaded Linux/Ubuntu .zprofile"
