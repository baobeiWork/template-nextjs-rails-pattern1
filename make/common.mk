include .env

# fallback for shell
SYSTEM_NAME ?= $(shell grep ^SYSTEM_NAME .env | cut -d '=' -f2 | tr -d '"')

DOCKER_BACKEND_CONTAINER := $(SYSTEM_NAME)_backend
DOCKER_FRONTEND_CONTAINER := $(SYSTEM_NAME)_frontend
DOCKER_MYSQL_CONTAINER := $(SYSTEM_NAME)_mysql
DOCKER_REDIS_CONTAINER := $(SYSTEM_NAME)_redis

build: ## docker-compose buildを実行
	docker-compose build --no-cache

up: ## docker-compose upを実行
	docker-compose up -d

show: ## コンテナ一覧の確認
	docker ps -a 

be-login: ## backendコンテナにログイン
	docker exec -it ${DOCKER_BACKEND_CONTAINER} /bin/bash 

fe-login: ## frontendコンテナにログイン
	docker exec -it ${DOCKER_FRONTEND_CONTAINER} /bin/bash 

mysql-login: ## MySQLコンテナにログイン
	docker exec -it ${DOCKER_MYSQL_CONTAINER} /bin/bash 

redis-login: ## Redisコンテナにログイン
	docker exec -it ${DOCKER_REDIS_CONTAINER} /bin/bash 

init-all: ## backendコンテナ・frontendコンテナの初期化を実行
	@$(MAKE) init-be
	@$(MAKE) init-fe

