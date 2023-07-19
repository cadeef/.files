#!/usr/bin/env bash

# Install miscellaneous tools

set -euo pipefail

# Setup Brew if it isn't installed
if ! hash brew &>/dev/null; then
    echo "Installing brew..."
    # Not safe, blah blah blah
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install terminal-specific tools
brew bundle install --file "${HOME}/.Brewfiles/.Brewfile.terminal"

# MacOS-specific
if [[ $(uname) == 'Darwin' ]]; then
    brew bundle install --file "${HOME}/.Brewfiles/.Brewfile.dev"

    # Install virtualbox if for some reason we are on a non-arm system
    if [[ $(uname -p) != "arm" ]]; then
        brew install --cask virtualbox
    fi
fi

# Install pipx-based tools (pipx installed by brew ☝️)
pipx_tools=(cade-task)

if hash pipx &>/dev/null; then
    pipx_installed=$(pipx list --short | awk '{print $1}')

    for tool in "${pipx_tools[@]}"; do
        if [[ ! "${pipx_installed[*]}" =~ ${tool} ]]; then
            pipx install "${tool}"
        fi
    done

    # Upgrade installed packages
    pipx upgrade-all
else
    echo "WARNING: pipx not found, tools not installed: ${pipx_tools[*]} "
fi
