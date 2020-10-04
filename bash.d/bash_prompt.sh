# shellcheck shell=bash

# Shellcheck attempts to be helpful here but gets in the way, yes I know it's bad.

if [[ ${OSFAMILY} == 'Darwin' ]]; then
    # shellcheck disable=SC2089
    PROMPT_COMMAND="echo -ne \"\033]0;$1⚡ [${PWD}]\007\""
    PS1="${WINDOW_TITLE}⚡ [\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
elif [[ $(hostname) =~ vm\.local$ ]]; then
    # shellcheck disable=SC2089
    PROMPT_COMMAND="echo -ne \"\033]0;$1🌵 (${HOSTNAME})[${PWD}]\007\""
    PS1="🌵 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
else
    # shellcheck disable=SC2089
    PROMPT_COMMAND="echo -ne \"\033]0;$1🎈 (${HOSTNAME})[${PWD}]\007\""
    PS1="🎈 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
fi

# Override if we are in my code directory
if [[ ${PWD} =~ ${HOME}/code ]]; then
    # shellcheck disable=SC2089
    PROMPT_COMMAND="echo -ne \"\033]0;$1🔪 [${PWD/${HOME}\/code\//}]\007\""

fi

# shellcheck disable=SC2090
export PS1 PROMPT_COMMAND
