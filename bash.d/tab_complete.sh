# shellcheck shell=bash

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[[ -r "${HOME}/.ssh/config" ]] && complete -o "default" -o "nospace" -W "$(grep "^Host" "${HOME}/.ssh/config" | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Loading completion files for all programs installed by brew takes forever and I really only care about
# completions for a few programs, only load those. Yes, this could be way prettier. Meh.

# Only care if this happens on a laptop
if [[ $OSFAMILY == 'Darwin' ]]; then

    progs_to_complete=(brew brew-services doctl gh git-completion.bash rg.bash)

    # Disable auto-loading from complete.d
    export BASH_COMPLETION_DIR="duh"
    export BASH_COMPLETION_COMPAT_DIR="$BASH_COMPLETION_DIR"

    # Load up helper functions
    # shellcheck disable=SC1091
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

    # Load
    for prog in "${progs_to_complete[@]}"; do
        # shellcheck disable=SC1090
        [[ -r "/usr/local/etc/bash_completion.d/${prog}" ]] && . "/usr/local/etc/bash_completion.d/${prog}"

    done

fi
