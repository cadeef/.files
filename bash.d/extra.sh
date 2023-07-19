# shellcheck shell=bash

# Add RVM support
# Disabled to speed up loading, left for easy re-enabling should I need it in the future
# [ -d ${HOME}/.rvm ] && source "$HOME/.rvm/scripts/rvm"

# WSL-related jazz
if [[ -n "${WSL_DISTRO_NAME-}" ]]; then
	# Make ssh-agent usable by re-using the same socket across sessions
	ssh_agent_sock="/tmp/ssh-agent-wsl.sock"
	# Fire up the agent; errors if the socket is already in use by another instance
	ssh-agent -a "${ssh_agent_sock}" &> /dev/null
	export SSH_AUTH_SOCK="${ssh_agent_sock}"
fi
