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

> This script specifically builds packages added to emscripten-forge to build ROS packages. These (at time of writing) are note available in the emscripten forge package repository.

## Build ROS2 Packages

Clone https://github.com/mbatc/ros-humble.git@emscripten and cd into the repo.
  1. Create a symbolic link to the `vinca_emscripten32.yaml` vinca file. You can use `ln vinca_emscripten32.yaml vinca.yaml` to do this.
  2. Run `vinca -m --platform=emscripten-32` to generate the recipes.
  4. `cd` into the `recipes` folder created by vinca.
  5. Run `boa build . --target-platform emscripten-32 -m ../.ci_support/conda_forge_pinnings.yaml -m ../conda_build_config.yaml`

Alternatively, you can use the scripts in the [build](../build/) folder to build packages.
  1. Run `build/recipes.sh PATH_TO_ROS_HUMBLE` to generate the recipes.
  2. Run `build/target.sh PATH_TO_ROS_HUMBLE` to build for emscripten.

# Fix Common Build Issues

Below are some common build issues and the fixes/workarounds for these.

## `relocation R_WASM_MEMORY_ADDR_TLS_SLEB cannot be used`

**cause**: This often occurs when building an executable (using `add_executable`). To fix this, we need to add `-fPIC` to the compile flags. 
**fix**: Add the following to the CMakeLists.txt

```
if (EMSCRIPTEN)
  target_compile_options(<target_name> PUBLIC -fPIC)
endif()
```

where `target_name` is the name of the target failing to compile with this linker error.

## Executable extension is .js instead of .wasm

**cause**: emcmake defaults executable extensions to `.js`. This produces a linker warning. Although it is not an error, we expect executables to have a .wasm extension.
**fix**: Add the following to the CMakeLists.txt

```
set_target_properties(
  <target_name>
  PROPERTIES SUFFIX ".wasm"
)
```

where `target_name` is the name of the target failing to compile with this linker error.
