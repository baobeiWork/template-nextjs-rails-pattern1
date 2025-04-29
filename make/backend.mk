be-reset: ## backend ディレクトリをリセット [ Gemfile / Gemfile.lock 保持 ] ()
	find ./backend -mindepth 1 ! \
		-name 'Gemfile' ! \
		-name 'Gemfile.lock' \
		-exec rm -rf {} +

be-init: ## backend 初期構築 [ Rails new apiモード ] ()
	@echo "backend 初期化を実行します"
	docker exec $(DOCKER_BACKEND_CONTAINER) rails new initial-temp \
	--api \
	--database=mysql \
	--skip-javascript \
	--skip-hotwire \
	--skip-asset-pipeline \
	--force
	docker exec $(DOCKER_BACKEND_CONTAINER) rm -rf \
		initial-temp/.github \
		initial-temp/Dockerfile \
		initial-temp/README.md \
		initial-temp/test \
		initial-temp/app/assets \
		initial-temp/app/helpers \
		initial-temp/script \
		initial-temp/.kamal \
		initial-temp/.dockerignore \
		initial-temp/.gitattributes \
		initial-temp/.gitignore \
		initial-temp/Gemfile \
		initial-temp/Gemfile.lock
	docker exec $(DOCKER_BACKEND_CONTAINER) /bin/bash -c 'mv /backend/initial-temp/* backend/'
	docker exec $(DOCKER_BACKEND_CONTAINER) rmdir initial-temp
	docker exec $(DOCKER_BACKEND_CONTAINER) bundle install
	
	@echo "初期化完了しました"

be-switch-entrypoint: ## backend entrypoint.shを切り替え ()
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
