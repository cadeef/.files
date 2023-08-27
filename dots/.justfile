# List commands
default:
  @just --list


# Control docker host: start|stop
@docker status:
  -[[ {{status}} == "stop" ]] && limactl stop docker
  -[[ {{status}} == "start" ]] && limactl start docker


# 1password-cli: run command with .env variables
[no-cd]
op +command:
  op run --env-file .env --no-masking -- {{command}}

# Generate and initialize template repo; types: python|base
[no-cd]
cookiecutter type:
  # Create repository
  cookiecutter https://github.com/cadeef/cookiecutter-{{type}}.git
