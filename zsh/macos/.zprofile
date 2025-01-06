#!/usr/bin/env zsh
#
# ~/.zprofile  (macOS)
#
# This file is executed for login shells. It is responsible for setting up 
# environment variables and paths that should be available in all sessions.
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

###############################################################################
# rbenv init settings
###############################################################################
eval "$(rbenv init - --no-rehash zsh)"

echo "Loaded macOS .zprofile"
    
