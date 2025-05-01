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

all-init: ## backendコンテナ・frontendコンテナの初期化を実行
	@$(MAKE) init-be
	@$(MAKE) init-fe

readme-template:
	cp document/.template/TEMPLATE_README.md README.md

readme-project:
	cp document/.template/PROJECT_README.md README.md

stop: ## コンテナすべて停止	
	docker stop ${DOCKER_BACKEND_CONTAINER} 
	docker stop ${DOCKER_FRONTEND_CONTAINER} 
	docker stop ${DOCKER_MYSQL_CONTAINER} 
	docker stop ${DOCKER_REDIS_CONTAINER} 

restart: ## コンテナすべて再起動	
	docker restart ${DOCKER_BACKEND_CONTAINER} 
	docker restart ${DOCKER_FRONTEND_CONTAINER} 
	docker restart ${DOCKER_MYSQL_CONTAINER} 
	docker restart ${DOCKER_REDIS_CONTAINER} 

be-login: ## backendコンテナにログイン
	docker exec -it ${DOCKER_BACKEND_CONTAINER} /bin/bash 

fe-login: ## frontendコンテナにログイン
	docker exec -it ${DOCKER_FRONTEND_CONTAINER} /bin/bash 

mysql-login: ## MySQLコンテナにログイン
	docker exec -it ${DOCKER_MYSQL_CONTAINER} /bin/bash 

redis-login: ## Redisコンテナにログイン
	docker exec -it ${DOCKER_REDIS_CONTAINER} /bin/bash 

be-stop: ## backendコンテナ停止
	docker stop ${DOCKER_BACKEND_CONTAINER} 

fe-stop: ## frontendコンテナ停止
	docker stop ${DOCKER_FRONTEND_CONTAINER} 

mysql-stop: ## mysqlコンテナ停止
	docker stop ${DOCKER_MYSQL_CONTAINER} 

redis-stop: ## redisコンテナ停止
	docker stop ${DOCKER_REDIS_CONTAINER} 

be-restart: ## backendコンテナ再起動
	docker restart ${DOCKER_BACKEND_CONTAINER} 

fe-restart: ## frontendコンテナ再起動
	docker restart ${DOCKER_FRONTEND_CONTAINER} 

mysql-restart: ## mysqlコンテナ再起動
	docker restart ${DOCKER_MYSQL_CONTAINER} 

redis-restart: ## redisコンテナ再起動
	docker restart ${DOCKER_REDIS_CONTAINER} 

be-down: ## backendコンテナ削除
	docker stop ${DOCKER_BACKEND_CONTAINER} 
	docker rm   ${DOCKER_BACKEND_CONTAINER} 

fe-down: ## frontendコンテナ削除
	docker stop ${DOCKER_FRONTEND_CONTAINER} 
	docker rm   ${DOCKER_FRONTEND_CONTAINER} 

mysql-down: ## mysqlコンテナ削除
	docker stop ${DOCKER_MYSQL_CONTAINER} 
	docker rm   ${DOCKER_MYSQL_CONTAINER} 

redis-down: ## redisコンテナ削除
	docker stop ${DOCKER_REDIS_CONTAINER} 
	docker rm   ${DOCKER_REDIS_CONTAINER} 



