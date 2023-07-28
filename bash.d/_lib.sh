# shellcheck shell=bash

# bash is dumb
is_tty() {
    if [[ -t 1 ]]; then
        return 0
    else
        return 1
    fi
}

# Check if a given tool is in PATH
is_in_path() {
    if hash "${1}" &> /dev/null; then
        return 0
    else
        return 1
    fi
}
