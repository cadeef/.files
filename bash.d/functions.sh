# shellcheck shell=bash

_wants_help() {
    [[ ${1:-} == "-h" || ${1:-} == "--help" ]]
}

# Create a new directory and enter it
mkd() {
    if _wants_help "${1:-}"; then
        echo "Usage: mkd <directory>"
        echo "Create a directory and cd into it."
        return
    fi

    if [[ $# -ne 1 ]]; then
        echo "Usage: mkd <directory>"
        return 1
    fi

    mkdir -p "$1" && cd "$1" || echo "Failed to cd"
}

# All the dig info
digga() {
    if _wants_help "${1:-}"; then
        echo "Usage: digga <host>"
        echo "Show all available dig answer records for a host."
        return
    fi

    dig +nocmd "$1" any +multiline +noall +answer
}

# Add note to Notes.app
# Usage: `note 'title' 'body'` or `echo 'body' | note`
# Title is optional
note() {
    local title
    local body

    if _wants_help "${1:-}"; then
        echo "Usage: note [title] [body]"
        echo "       echo 'body' | note"
        echo "Create a note in Notes.app."
        return
    fi

    if [ -t 0 ]; then
        title="$1"
        body="$2"
    else
        title=$(cat)
    fi
    osascript > /dev/null << EOF
tell application "Notes"
    tell account "iCloud"
        tell folder "Notes"
            make new note with properties {name:"$title", body:"$title" & "<br><br>" & "$body"}
        end tell
    end tell
end tell
EOF
}

# Manually remove a downloaded app or file from the quarantine
unquarantine() {
    if _wants_help "${1:-}"; then
        echo "Usage: unquarantine <path> [path ...]"
        echo "Remove macOS download/quarantine extended attributes."
        return
    fi

    for attribute in com.apple.metadata:kMDItemDownloadedDate com.apple.metadata:kMDItemWhereFroms com.apple.quarantine; do
        xattr -r -d "$attribute" "$@"
    done
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
s() {
    local subl_binary

    if _wants_help "${1:-}"; then
        echo "Usage: s [path ...]"
        echo "Open paths in Sublime Text, or the current directory with no args."
        return
    fi

    if [[ -z "$WSL_DISTRO_NAME" ]]; then
        subl_binary="subl"
    else
        subl_binary="/mnt/c/Program Files/Sublime Text/subl.exe"
    fi

    if [[ $# -eq 0 ]]; then
        "$subl_binary" .
    else
        "$subl_binary" "$@"
    fi
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v() {
    if _wants_help "${1:-}"; then
        echo "Usage: v [path ...]"
        echo "Open paths in Vim, or the current directory with no args."
        return
    fi

    if [ $# -eq 0 ]; then
        vim .
    else
        vim "$@"
    fi
}

# `o` with no arguments opens current directory, otherwise opens the given
# location
o() {
    if _wants_help "${1:-}"; then
        echo "Usage: o [path ...]"
        echo "Open paths with the system opener, or the current directory with no args."
        return
    fi

    if [[ $# -eq 0 ]]; then
        open .
    else
        open "$@"
    fi
}

# Arbitrary window titles
title() {
    if _wants_help "${1:-}"; then
        echo "Usage: title [title]"
        echo "Set the terminal window title, or use the hostname with no args."
        return
    fi

    if [[ -z ${1} ]]; then
        printf "\[\033]0;%s\007\]" "$(hostname)"
    else
        printf "\[\033]0;%s\007\]" "${1}"
    fi
}

# ssk - remove line from ~/.ssh/known_hosts
ssk() {
    local host=${1}

    if _wants_help "${1:-}"; then
        echo "Usage: ssk <host>"
        echo "Remove a host from ~/.ssh/known_hosts."
        return
    fi

    ssh-keygen -R "${host}"
}

# superman - augment man
superman() {
    if _wants_help "${1:-}"; then
        echo "Usage: superman <command>"
        echo "Show help for Bash builtins or man pages for executable commands."
        return
    fi

    case $(type -t "${1}") in
        builtin)
            help -m "${1}" | bat -p -l man
            ;;
        file)
            /usr/bin/man "${1}"
            ;;
        # Turns out this is an awful idea since I alias practically everything...
        # alias)
        #     echo "Alias: ${1}"
        #     alias | grep "${1}="
        #     ;;
        *)
            echo "Docs not found for ${1}"
            ;;
    esac

}

# Overload `lima`` to start instances before connecting
# Additionally, allow the shorter `lima` to connect to any instance
lima() {
    local instance="${1:-default}"
    local status

    if _wants_help "${1:-}"; then
        echo "Usage: lima [instance]"
        echo "Start a Lima instance if needed, then connect to it."
        return
    fi

    status=$(limactl list --format json "${instance}" | jq -r '.status')

    # Bail if instance doesn't exist
    if [[ -z ${status} ]]; then
    	return 1
    fi

    # Start instance if it isn't running
    if [[ ${status} != "Running" ]]; then
    	echo "Instance (${instance}) isn't running, starting..."
        limactl start "${instance}"
    fi

    # Connect via ssh
    limactl shell "${instance}"
}

# Create a temporary python environment
# Accepts packages for install as arguments
mkp() {
    local temp_dir

    if _wants_help "${1:-}"; then
        echo "Usage: mkp [package ...]"
        echo "Create a temporary uv Python app and install optional packages."
        return
    fi

    temp_dir="$(mktemp -d)"
    # Change to temp_dir
    cd "${temp_dir}" || ( echo "Failed cd to ${temp_dir}" && return 1 )
    # Initialize environment
    uv init --app
    # Add dev dependencies
    uv add --dev ipython devtools
    # Add packages from $@
    if [ $# -gt 0 ]; then
        uv add "$@"
    fi
    # Print any relevant info
    echo "source ${temp_dir}/.venv/bin/activate"
}
