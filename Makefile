
DOCKER = docker
DOCKER_BUILD = $(DOCKER) build

DOCKER_COMPOSE_FILE = docker-compose.yml
DOCKER_COMPOSE = docker-compose -f $(DOCKER_COMPOSE_FILE)

DOCKER_IMAGE = selfae/magento

default: help

#################################
Docker:

## Down containers and remove orphans
down:
	$(DOCKER_COMPOSE) down --remove-orphans

## Display docker logs
log:
	$(DOCKER_COMPOSE) logs -f

## Build and start containers
up:
	$(DOCKER_COMPOSE) up --build -d

## down and up dockers
reset: down up

login:
	$(DOCKER) login

build: login build_php_cli

build_php_cli:
	$(DOCKER_BUILD) \
        -t $(DOCKER_IMAGE):cli-latest\
        ./php-cli
	$(DOCKER) push $(DOCKER_IMAGE):cli-latest

# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)
TARGET_MAX_CHAR_NUM=25

help:
	@echo "Magento docker helper: ${GREEN}$(MICRO_SERVICE_NAME)${RESET}"
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
		isTopic = match(lastLine, /^###/); \
        if (isTopic) { printf "\n%s\n", $$1; } \
	} { lastLine = $$0 }' $(MAKEFILE_LIST)
