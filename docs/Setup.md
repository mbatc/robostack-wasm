# Install and Setup

1. To install the required tools run `setup/install-tools.sh` and follow the prompts. This will install,
    * Python3
    * Miniconda3
    * Mamba
    * Pip
    * Boa (non-master, https://github.com/DerThorsten/boa.git@python_api)
    * Vinca (non-master, https://github.com/mbatc/vinca.git@mbatchelor/emscripten)

   Resources are downloaded to `/tmp/emrobostack/`. This will be deleted on reboot.

2. Restart your shell to load the conda environment.
3. Run `setup/create-dev-env.sh` to create a conda environment configured for building ROS packages. You can override the default environment name (`emrobostack-dev`) by passing an argument to the script, e.g. `./setup/create-dev-env.sh myrobostackenv`

# Building RoboStack Packages Locally

## Build dependencies from emscripten-forge

Before building ROS2 packages with robostack first you will need to build some dependencies with emscripten-forge. Clone https://github.com/mbatc/emscripten-forge-recipes.git@ROS2Recipes and run `./build/emforge-deps.sh PATH_TO_EMFORGE_REPO` to build dependencies which are not ROS packages.

> This script specifically builds packages added to emscripten-forge to build ROS packages. These (at time of writing) are note available in the emscripten forge package repository.

## Build ROS2 Packages

Clone https://github.com/mbatc/ros-humble.git@emscripten and cd into the repo.
  1. Create a symbolic link to the `vinca_emscripten32.yaml` vinca file. You can use `sym vinca_windows_64.yaml vinca.yaml`, or create a symbolic link to the target vinca config file.
  2. Remove/comment the channel entry in the `vinca.yaml`'s `skip_existing` array. Also change `skip_all_deps` to `true` so we don't rebuild every dependency for every package.
  3. Run `vinca -m` to generate the recipes.
  4. `cd` into the `recipes` folder created by vinca.
  5. Run `boa build . -m ../.ci_support/conda_forge_pinnings.yaml -m ../conda_build_config.yaml`