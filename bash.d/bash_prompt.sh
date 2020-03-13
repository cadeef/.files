# shellcheck shell=bash

# Ugly hack but consistent enough to keep me sane

if [[ ${OSFAMILY} == 'Darwin' ]]; then
    PS1="⚡ [\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
    export PS1
elif [[ $(hostname) =~ vm\.local$ ]]; then
    PS1="🌵 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
    export PS1
else
    PS1="🎈 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
    export PS1
fi
