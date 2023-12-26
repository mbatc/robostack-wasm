# robostack-wasm

This repo contains tools and documentation created while implementing a WebAssembly compile target for RoboStack.

The scripts depend on forks of [Vinca](https://github.com/RoboStack/vinca), [robostack](https://github.com/RoboStack/ros-humble), and [emscripten forge](https://github.com/emscripten-forge/recipes). 

To get started clone the dependencies,
  * `git clone https://github.com/mbatc/emscripten-forge-recipes -b fixes_tobi`
  * `git clone https://github.com/mbatc/ros-humble -b tobi_fixes`
  * `git clone https://github.com/mbatc/vinca.git -b fixes_tobi`

and create 3 files, `.emforge-dir`, `.robostack-dir`, and `.vinca-dir` containing the path to each repo. e.g.

```sh
echo -n PATH_TO_EMSCRIPTENT_FORGE_REPO > .emforge-dir
echo -n PATH_TO_ROBOSTACK_REPO > .robostack-dir
echo -n PATH_TO_VINCA_REPO > .vinca-dir
```

These are used in the [makefile](./makefile) to locate the repos.

Run `make help` to list helpful commands for generating recipes and building packages.

ROS2 packages I've built using these tools can be found in [robostack-wasm](https://repo.mamba.pm/robostack-wasm). 

# Docs

* [Setup](./docs/Setup.md)
* [Design](./docs/Design.md)
* [Issues](./docs/Issues.md)
* [Porting Conda Forge Packages](./docs/PortingCondaForgePackages.md)

# Project Milestones

## 1. Hello WASM

| Date | 30/04/2023 |
|-|-|
| Description | A basic c++ application which is cross-compiled to Web Assembly |
| Location | ./hello-wasm/ |

## 2. ROS Package

| Date | 12/05/2023 |
|-|-|
| Description | Cross compiled the rclcpp library to Web Assembly. |
| Location |./rclcpp-wasm/ |

## 3. JupyterLite build

- Just run `jupyter lite build --XeusPythonEnv.empack_config=empack_config.yaml` in the [./milestones/rmw-wasm-cpp-example](./milestones/rmw-wasm-cpp-example) folder
