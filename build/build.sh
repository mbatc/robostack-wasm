#!/usr/bin/env bash

# Then build for target platform
boa build "../ros-humble/recipes/" \
  --target-platform emscripten-32 \
  -m "../ros-humble/.ci_support/conda_forge_pinnings.yaml" \
  -m "../ros-humble/conda_build_config.yaml"