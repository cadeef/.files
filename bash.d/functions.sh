# shellcheck shell=bash

# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$@" || echo "Failed to cd"
}

# All the dig info
digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

# Add note to Notes.app
# Usage: `note 'title' 'body'` or `echo 'body' | note`
# Title is optional
note() {
    local title
    local body
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
    for attribute in com.apple.metadata:kMDItemDownloadedDate com.apple.metadata:kMDItemWhereFroms com.apple.quarantine; do
        xattr -r -d "$attribute" "$@"
    done
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
s() {
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
    if [ $# -eq 0 ]; then
        vim .
    else
        vim "$@"
    fi
}

# `o` with no arguments opens current directory, otherwise opens the given
# location
o() {
    if [[ $# -eq 0 ]]; then
        open .
    else
        open "$@"
    fi
}

# Arbitrary window titles
title() {
    if [[ -z ${1} ]]; then
        printf "\[\033]0;%s\007\]" "$(hostname)"
    else
        printf "\[\033]0;%s\007\]" "${1}"
    fi
}

# ssk - remove line from ~/.ssh/known_hosts
ssk() {
    local host=${1}
    ssh-keygen -R "${host}"
}

# superman - augment man
superman() {
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
