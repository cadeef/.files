# List commands
default:
  @just --list


# Control docker host
@docker status:
  -[[ {{status}} == "stop" ]] && limactl stop docker
  -[[ {{status}} == "start" ]] && limactl start docker


[no-cd]
# 1password-cli: run command with .env variables
op +command:
  op run --env-file .env --no-masking -- {{command}}
