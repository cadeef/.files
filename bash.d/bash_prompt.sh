# shellcheck shell=bash

prompt_command() {
    if [[ ${PWD} =~ ${HOME}/code ]]; then
        PROMPT_EMOJI="🔪"
        PROMPT_HOSTNAME=""
        PROMPT_PWD="${PWD/${HOME}\/code\//}"
    elif [[ ${OSFAMILY} == 'Darwin' || -n "${WSL_DISTRO_NAME-}" ]]; then
        PROMPT_EMOJI="⚡"
        PROMPT_HOSTNAME=""
        # FIXME: tilde needs to be escaped on macos, probably brew bash version (newer) related.
        # I'm too lazy to figure out why right now and the logic makes it convenient to override.
        PROMPT_PWD="${PWD/${HOME}/\~}"
    elif [[ $(hostname) =~ vm\.local$ ]]; then
        PROMPT_EMOJI="🌵"
        PROMPT_HOSTNAME="(${HOSTNAME})"
        PROMPT_PWD="${PWD/${HOME}/~}"
    else
        PROMPT_EMOJI="🎈"
        PROMPT_HOSTNAME="(${HOSTNAME})"
        PROMPT_PWD="${PWD/${HOME}/~}"
    fi

    # Call out running as root
    if [[ ${LOGNAME} == "root" ]]; then
        PROMPT_EMOJI="⛔️"
    fi

    case "${TERM}" in
        xterm* | rxvt*)
            PROMPT_WINDOW_TITLE="\[\033]0;${PROMPT_EMOJI} ${PROMPT_HOSTNAME}${PROMPT_PWD}\007\]"
            ;;
        *)
            PROMPT_WINDOW_TITLE=""
            ;;
    esac

    PS1="${PROMPT_WINDOW_TITLE}${PROMPT_EMOJI} ${PROMPT_HOSTNAME}[\[$(tput setaf 2)\]${PROMPT_PWD}\[$(tput sgr0)\]]--> "
}

# Load prompt with precmd from bash-preexec
precmd_functions+=(prompt_command)

prompt_command

# Load iterm shell integration (it uses PROMPT for tracking)
if [[ -f "${HOME}/.iterm2_shell_integration.bash" ]]; then
    # shellcheck disable=SC1091
    source "${HOME}/.iterm2_shell_integration.bash"
fi
