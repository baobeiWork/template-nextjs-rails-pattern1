include make/common.mk
include make/backend.mk
include make/frontend.mk

.DEFAULT_GOAL := help

help:
	@echo "["
	@grep -H -E '^[a-zA-Z0-9_-]+:.*?# ' $(MAKEFILE_LIST) | awk -F ':|#' '\
	BEGIN { first = 1 } \
	{ \
		if (!first) print ","; \
		first = 0; \
		gsub(/^[[:space:]]+|[[:space:]]+$$/, "", $$3); \
		printf "  {\n"; \
		printf "    \"command\": \"%s\",\n", $$2; \
		printf "    \"description\": \"%s\",\n", $$4; \
		printf "    \"file\": \"%s\"\n", $$1; \
		printf "  }"; \
	}'; \
	echo "\n]"
