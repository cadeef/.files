# shellcheck shell=bash

# Ugly hack but consistent enough to keep me sane

# Shell check attempts to be helpful here but it gets in the way.

if [[ ${OSFAMILY} == 'Darwin' ]]; then
    # shellcheck disable=SC2089
    PROMPT_COMMAND="echo -ne \"\033]0;$1⚡ [${PWD}]\007\""
    # shellcheck disable=SC2090
    export PROMPT_COMMAND
    PS1="${WINDOW_TITLE}⚡ [\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
    export PS1
elif [[ $(hostname) =~ vm\.local$ ]]; then
    # shellcheck disable=SC2089
    PROMPT_COMMAND="echo -ne \"\033]0;$1🌵 (${HOSTNAME})[${PWD}]\007\""
    # shellcheck disable=SC2090
    export PROMPT_COMMAND
    PS1="🌵 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
    export PS1
else
    # shellcheck disable=SC2089
    PROMPT_COMMAND="echo -ne \"\033]0;$1🎈 (${HOSTNAME})[${PWD}]\007\""
    # shellcheck disable=SC2090
    export PROMPT_COMMAND
    PS1="🎈 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
    export PS1
fi
