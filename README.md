# robostack-wasm

This repo contains tools and documentation created while implementing a WebAssembly compile target for RoboStack.

The scripts depend on forks of [Vinca](https://github.com/RoboStack/vinca), [robostack](https://github.com/RoboStack/ros-humble), and [emscripten forge](https://github.com/emscripten-forge/recipes). 

To get started clone the dependencies,
  * https://github.com/mbatc/emscripten-forge-recipes@ROS2Recipes
  * https://github.com/mbatc/ros-humble@mbatchelor/emscripten
  * https://github.com/mbatc/vinca.git@emscripten

and create 3 files, `.emforge-dir`, `.robostack-dir`, and `.vinca-dir` containing the path to each repo. e.g.

```sh
echo -n PATH_TO_EMSCRIPTENT_FORGE_REPO > .robostack-dir
echo -n PATH_TO_ROBOSTACK_REPO > .robostack-dir
echo -n PATH_TO_VINCA_REPO > .robostack-dir
```

These are used in the [makefile](./makefile) to locate the repos.

Run `make help` to list helpful commands for generating recipes and building packages.

> The [makefile](./makefile) depends on a  files which contain the path to the emscripten-forge, robostack flavour, and vinca repos respectively.

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
