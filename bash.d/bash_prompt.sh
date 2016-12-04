# Ugly hack but consistent enough to keep me sane

if [[ ${OSFAMILY} == 'Darwin' ]]; then
    export PS1="⚡ [\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
elif [[ $(hostname) =~ 'vm.local' ]]; then
    export PS1="🌵 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
else
    export PS1="🎈 (\H)[\[$(tput setaf 2)\]\w\[$(tput sgr0)\]]--> "
fi
