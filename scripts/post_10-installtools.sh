#!/usr/bin/env bash

# Install miscellaneous tools

set -euo pipefail

# MacOS-specific
if [[ $(uname) == 'Darwin' ]]; then
    # Get that brew action going to install/upgrade from ~/.Brewfile
    brew bundle install --global
fi
