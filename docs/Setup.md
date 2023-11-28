# Install and Setup

1. To install the required tools run `setup/install-tools.sh` and follow the prompts. This will install,
    * Python3
    * Miniconda3
    * Mamba
    * Pip

   Resources are downloaded to `/tmp/emrobostack/`. This will be deleted on reboot.

2. Restart your shell to load the conda environment.
3. Run `setup/create-dev-env.sh` to create a conda environment configured for building ROS packages. You can override the default environment name (`emrobostack-dev`) by passing an argument to the script, e.g. `./setup/create-dev-env.sh my_env_name`

> This creates an environment with various dependencies for building packages via emscripten-forge and robostack. See [emrobostack-dev.yaml](../envs/emrobostack-dev.yaml) for the environment config. There are also some non-master dependencies installed with pip. These are
> * https://github.com/DerThorsten/boa.git@python_api
> * https://github.com/mbatc/vinca.git@mbatchelor/emscripten
> * https://github.com/DerThorsten/bitfurnace.git@emscripten_new

# Building RoboStack Packages Locally

## Build dependencies from emscripten-forge

Before building ROS2 packages with robostack first you will need to build some dependencies with emscripten-forge. Clone https://github.com/mbatc/emscripten-forge-recipes.git@ROS2Recipes and run `./build/emforge-deps.sh PATH_TO_EMFORGE_REPO` to build dependencies which are not ROS packages.

> This script specifically builds packages added to emscripten-forge to build ROS packages. These (at time of writing) are not available in the emscripten forge package repository.

## Build ROS2 Packages

Clone https://github.com/mbatc/ros-humble.git@emscripten and cd into the repo.
  1. Create a symbolic link to the `vinca_emscripten32.yaml` vinca file. You can use `ln vinca_emscripten32.yaml vinca.yaml` to do this.
  2. Run `vinca -m --platform=emscripten-32` to generate the recipes.
  4. `cd` into the `recipes` folder created by vinca.
  5. Run `boa build . --target-platform emscripten-32 -m ../.ci_support/conda_forge_pinnings.yaml -m ../conda_build_config.yaml`

Alternatively, you can use the scripts in the [build](../build/) folder to build packages.
  1. Run `build/recipes.sh PATH_TO_ROS_HUMBLE` to generate the recipes.
  2. Run `build/target.sh PATH_TO_ROS_HUMBLE` to build for emscripten.

# Commands

Below you can find all the commands you need to run to get ROS building from a fresh install of Linux

## Setup RoboStack WASM

```sh
# Install system dependencies
sudo apt-get update -y
sudo apt-get install curl -y
sudo apt-get install git -y
sudo apt-get install lbzip2 -y

# Clone required repositories
git clone https://github.com/mbatc/robostack-wasm.git
git clone -b mbatchelor/emscripten https://github.com/mbatc/ros-humble.git
git clone -b ROS2Recipes https://github.com/mbatc/emscripten-forge-
recipes.git

# Setup paths for Robostack-WASM makefile
cd robostack-wasm
echo -n ../ros-humble/ > .robostack-dir
echo -n ../emscripten-forge-recipes/ > .emforge-dir

# Install dependencies and create the ‘dev’ environment which we compile packages in
./setup/install-tools.sh

# Source bashrc so we don’t need to restart the terminal
. ~/.bashr
./setup/create-dev-env.sh

# Activate the new environment and select the emscripten-32 configuration for vinca
micromamba activate emrobostack-dev
ln ../ros-humble/vinca_emscripten32.yaml ../ros-humble/vinca.yaml
```

## Build ROS Packages with Boa
```sh
# Activate the build environment
micromamba activate emrobostack-dev

# Build additional dependencies from Emscripten Forge
make emforge

# Generate ROS package recipes using Vinca
make recipes-target

# Copy some additional recipes that need to be built.
cp -r ../ros-humble/additional_recipes/ros2-distro-mutex ../ros-
humble/recipes
cp -r ../ros-humble/additional_recipes/ros-humble-rmw-wasm-cpp ../ros-
humble/recipes
cp -r ../ros-humble/additional_recipes/ros-humble-wasm-cpp ../ros-
humble/recipes
cp -r ../ros-humble/additional_recipes/dynmsg ../ros-humble/recipes

# Build everything for emscripten-32
make build-target
```

## Install and Package WASM Environment

This example uses the config files in `milestones/rmw-wasm-cpp-example` to package a WASM environment. Feel free to take this and modify it for your needs.

```sh
# Create emscripten-32 environment which we can install WASM packages to
./setup/create-wasm-env.sh

# Activate the emscripten-32 environment and install some packages (from deps.yaml)
# Note that you can install any emscripten-32 packages you like.
micromamba activate emrobostack
micromamba install --file=milestones/rmw-wasm-cpp-example/deps.yaml

# Switch back to our dev environment
micromamba activate emrobostack-dev

# Pack the 'emrobostack' environment we just created.
# This also deploys a simple web-page that uses pyjs to load the environment.
./milestones/rmw-wasm-cpp-example/pack.sh emrobostack

# Host the packed environment/site on a local web server.
python -m http.server 8080 --bind 127.0.0.1 --directory milestones/rmw-wasm-cpp-example/dist
```
