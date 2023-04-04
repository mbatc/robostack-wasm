ROS_ENV_NAME=robostackenv
ROS_DISTRO=humble
VINCA_CONFIG=vinca_linux_64.yaml

ROS_REPO=ros-$(ROS_DISTRO)

build: vinca ## Build the packagees using boa
	boa build "$(ROS_REPO)" -m "$(ROS_REPO)/.ci_support/conda_forge_pinnings.yaml" -m

build-m: vinca-m ## Build the packagees using boa (multiple)
	boa build  "$(ROS_REPO)/recipes/" -m "$(ROS_REPO)/.ci_support/conda_forge_pinnings.yaml" -m

vinca: vinca-select-platform ## Generate recipes using vinca
	vinca -d "$(ROS_REPO)"

vinca-m: vinca-select-platform ## Generate recipes using vinca (multiple)
	vinca -m -d "$(ROS_REPO)"

vinca-select-platform: ## Copy the platform specific vinca script
	rm -f "$(ROS_REPO)/vinca.yaml"
	cp "$(ROS_REPO)/$(VINCA_CONFIG)" "ros-$(ROS_DISTRO)/vinca.yaml"

install-tools: ## Install tools RoboStack depends on
	./scripts/install-tools.sh

setup-env: ## Create a conda environment for use with RoboStack
	bash ./scripts/setup-env.sh "$(ROS_ENV_NAME)" "$(ROS_DISTRO)"

clean-env: ## Remove the conda environment configured by 'setup-env'
	./scripts/clean-env.sh "$(ROS_ENV_NAME)"
	rm -f activate-env.sh


.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)