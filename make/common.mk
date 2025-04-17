include .env

# fallback for shell
SYSTEM_NAME ?= $(shell grep ^SYSTEM_NAME .env | cut -d '=' -f2 | tr -d '"')

DOCKER_BACKEND_CONTAINER := $(SYSTEM_NAME)_backend
DOCKER_FRONTEND_CONTAINER := $(SYSTEM_NAME)_frontend


build: ## docker-compose buildを実行
	docker-compose build --no-cache

up: ## docker-compose upを実行
	docker-compose up -d

show: ## コンテナ一覧の確認
	docker ps -a 

init-all: ## backendコンテナ・frontendコンテナの初期化を実行
	@$(MAKE) init-be
	@$(MAKE) init-fe

