fe-reset: # frontendディレクトリをリセット（Package.json / yarn.lock 保持）
	find ./frontend -mindepth 1 ! \
		-name 'package.json' ! \
		-name 'yarn.lock' \
		-exec rm -rf {} +
	fe-switch-entrypoint initial