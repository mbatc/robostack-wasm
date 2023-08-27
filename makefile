ROBOSTACK_DIR := $(shell cat .robostack-dir)
VINCA_DIR := $(shell cat .vinca-dir)
EMFORGE_DIR := $(shell cat .emforge-dir)

build-host: ## Build the packages for the host platform using boa
	./build/host.sh $(ROBOSTACK_DIR)

build-target: ## Build the packages for the target platform (emscripten-32) using boa
	./build/target.sh $(ROBOSTACK_DIR)

recipes-host: ## Generate recipes for the host platform using Vinca.
	./build/recipes-host.sh $(ROBOSTACK_DIR)

recipes-target: ## Generate ROS2 recipes for the target platform using Vinca.
	./build/recipes.sh $(ROBOSTACK_DIR)

emforge: ## Build additional ROS2 dependencies that from emscripten forge.
	./build/emforge-deps.sh $(EMFORGE_DIR)

install-vinca:
	python -m pip install $(VINCA_DIR)/

install-tools: ## Install tools RoboStack depends on
	./scripts/install-tools.sh

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)