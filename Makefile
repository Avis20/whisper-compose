BASE_DOCKER_COMPOSE = -f docker-compose.yaml
ENV_FILE = ./.docker.env
LOCAL_ENV_FILE = ./.env

.PHONY: create_env
create_env: ## Just touching env files
	touch $(ENV_FILE)
	touch $(LOCAL_ENV_FILE)

.PHONY: run
run: create_env ## run services
# make up service=media-backend
	@docker compose run transcribe bash start.sh $(file) $(model) $(device)

.PHONY: up
up: create_env ## up services
# make up service=media-backend
	@docker compose --env-file $(ENV_FILE) $(BASE_DOCKER_COMPOSE) up $(service) -d

.PHONY: config
config: create_env ## show compose config
# make up service=media-backend
	@docker compose --env-file $(ENV_FILE) $(BASE_DOCKER_COMPOSE) config

.PHONY: logs
logs: ## tail logs services
# make logs service=media-backend
	@docker compose --env-file $(ENV_FILE) $(BASE_DOCKER_COMPOSE) logs $(service) -f

.PHONY: down
down: ## down services
	@docker compose --env-file $(ENV_FILE) $(BASE_DOCKER_COMPOSE) down

.PHONY: build
build: create_env ## build services
# make build service=media-backend
	@docker compose --env-file $(ENV_FILE) $(BASE_DOCKER_COMPOSE) build $(service)

.PHONY: restart
restart: down up ## restart services

.PHONY: uninstall
uninstall: create_env ## uninstall all services
	@docker compose --env-file $(ENV_FILE) $(BASE_DOCKER_COMPOSE) down --remove-orphans --volumes

.PHONY: help
help: ## Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
