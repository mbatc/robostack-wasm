#!/bin/bash -i

# Build for host platform first so we can install required dependencies
boa build "../ros-humble/recipes/" \
  -m "../ros-humble/.ci_support/conda_forge_pinnings.yaml" \
  -m "../ros-humble/conda_build_config.yaml"\
