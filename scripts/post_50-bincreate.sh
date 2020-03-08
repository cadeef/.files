#!/usr/bin/env bash

set -euo pipefail

bin_dir="$HOME/bin"

if [[ ! -d $bin_dir ]]; then
    mkdir "$bin_dir"
fi

# MacOS-specific
if [[ $(uname) == 'Darwin' ]]; then
    # Setup subl, CLI Sublime Text
    if [[ -f "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" && ! -L "$bin_dir/subl" ]]; then
        ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "$bin_dir/subl" ||
            echo "Failed to symlink subl!"
    fi
fi
