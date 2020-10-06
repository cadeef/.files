# shellcheck shell=bash

pretty_code_name() {
    # FIXME: the bash regex implementation is weird and I can't be
    # bothered to figure out why adding \/? makes the entire path match.
    # just want to anchor the damn thing
    local dir=${1:-${PWD}}
    if [[ ${dir} =~ ^${HOME}\/code\/([[:alnum:]\.\-\_]+)\/ ]]; then
        echo "${BASH_REMATCH[1]}"

    elif [[ ${dir} =~ ^${HOME}\/code\/([[:alnum:]\.\-\_]+) ]]; then
        echo "${BASH_REMATCH[1]}"
    fi
}

# bash is dumb
is_tty() {
    if [[ -t 1 ]]; then
        return 0
    else
        return 1
    fi
}

is_in_path() {
    if hash "${1}" &> /dev/null; then
        return 0
    else
        return 1
    fi
}
