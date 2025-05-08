fe-reset: ## frontendディレクトリをリセット（package.json / yarn.lock / node_modules 保持）
	-find ./frontend \
		-mindepth 1 ! \
		-name 'package.json' ! \
		-name 'yarn.lock' \
		-exec rm -rf {} +

fe-init: ## frontend 初期構築 [ yarn install + ディレクトリセットアップ ] ()
	@echo "frontend 初期化を実行します"
	docker exec $(DOCKER_FRONTEND_CONTAINER) yarn install
	docker exec $(DOCKER_FRONTEND_CONTAINER) yarn create next-app initial-temp \
		--typescript \
		--eslint \
		--no-tailwind \
		--src-dir \
		--app \
		--import-alias "@/*" \
		--turbopack

	docker exec $(DOCKER_FRONTEND_CONTAINER) rm -rf \
		/frontend/initial-temp/.gitignore \
		/frontend/initial-temp/README.md \
		/frontend/initial-temp/node_modules \
		/frontend/initial-temp/package.json \
		/frontend/initial-temp/yarn.lock \
		/frontend/node_modules

	docker exec $(DOCKER_FRONTEND_CONTAINER) /bin/bash -c 'mv /frontend/initial-temp/* /frontend/'
	docker exec $(DOCKER_FRONTEND_CONTAINER) rmdir /frontend/initial-temp
	docker exec $(DOCKER_FRONTEND_CONTAINER) /bin/bash -c '\
		mkdir -p /frontend/src/components/{ui,common,layout} && \
		mkdir -p /frontend/src/hooks && \
		mkdir -p /frontend/src/lib && \
		mkdir -p /frontend/src/styles && \
		mkdir -p /frontend/src/types \
	'
	docker exec $(DOCKER_FRONTEND_CONTAINER) yarn install

	@echo "frontend 初期化完了しました"

fe-update-entrypoint: ## frontend entrypoint.shを切り替え (基本的には初期構築時のみ利用)
ifndef type
	$(error 切り替えるentrypoint typeが指定されていません: make be-switch-entrypoint type=initial または type=deploy)
endif
	@if [ "$(type)" = "initial" ]; then \
		src=infrastructure/shell/frontend/initial/entrypoint.sh; \
	elif [ "$(type)" = "deploy" ]; then \
		src=infrastructure/shell/frontend/deploy/entrypoint.sh; \
	else \
		echo "モードは initial または deploy のみ対応しています: type=$(type)"; \
		exit 1; \
	fi; \
	echo "entrypoint.sh を $(type) に切り替えます"; \
	cp -a $$src infrastructure/shell/frontend/entrypoint.sh;  \
	docker cp $$src $$(docker-compose ps -q frontend):/usr/bin/entrypoint.sh; \
	docker-compose exec frontend chmod +x /usr/bin/entrypoint.sh; \
	echo "$(type) entrypoint に切り替えました。frontendコンテナを再起動してください。"