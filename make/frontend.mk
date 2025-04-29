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
	docker exec $(DOCKER_FRONTEND_CONTAINER) yarn install

	@echo "frontend 初期化完了しました"
