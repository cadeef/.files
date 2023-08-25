#!/usr/bin/env bash

set -euo pipefail

create_symlink_if_not_exist() {
    source="${1}"
    target="${2}"

    if [[ ! -L ${target} ]]; then
        ln -s "${source}" "${target}" && \
        echo "Created symlink: ${source} -> ${target}"
    fi
}

# MacOS-specific
if [[ $(uname) == 'Darwin' ]]; then
    # Application Support (Local Config)
    create_symlink_if_not_exist "${HOME}/Library/Application Support", "${HOME}/as"
    # iCloud
    create_symlink_if_not_exist "${HOME}/Library/Mobile Documents/com~apple~CloudDocs" "${HOME}/icloud"
fi
