reset-be: ## backend ディレクトリをリセット [ Gemfile / Gemfile.lock 保持 ] ()
	find ./backend -mindepth 1 ! \
		-name 'Gemfile' ! \
		-name 'Gemfile.lock' \
		-exec rm -rf {} +

init-be: ## backend 初期構築 [ Rails new apiモード ] ()
	@echo "backend 初期化を実行します"
	docker exec $(DOCKER_BACKEND_CONTAINER) rails new . \
	--api \
	--database=mysql \
	--skip-javascript \
	--skip-hotwire \
	--skip-asset-pipeline \
	--force

	docker exec $(DOCKER_BACKEND_CONTAINER) bundle install

	docker exec $(DOCKER_BACKEND_CONTAINER) rm -rf \
		.github \
		Dockerfile \
		README.md \
		test \
		app/assets \
		app/helpers \
		script \
		.kamal \
		.dockerignore \
		.gitattributes \
		.gitignore

	@echo "初期化完了しました"

switch-entrypoint-be: ## backend entrypoint.shを切り替え ()
ifndef type
	$(error 切り替えるentrypoint typeが指定されていません: make be-switch-entrypoint type=initial または type=deploy)
endif
	@if [ "$(type)" = "initial" ]; then \
		src=infrastructure/docker/backend/shell/initial/entrypoint.sh; \
	elif [ "$(type)" = "deploy" ]; then \
		src=infrastructure/docker/backend/shell/deploy/entrypoint.sh; \
	else \
		echo "モードは initial または deploy のみ対応しています: type=$(type)"; \
		exit 1; \
	fi; \
	echo "entrypoint.sh を $(type) に切り替えます"; \
	docker cp $$src $$(docker-compose ps -q backend):/entrypoint.sh; \
	docker-compose exec backend chmod +x /entrypoint.sh; \
	echo "$(type) entrypoint に切り替えました"
