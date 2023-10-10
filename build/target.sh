#!/bin/bash -i

ROBOSTACK_DIR=$1

boa build "$ROBOSTACK_DIR/recipes/" \
  --target-platform emscripten-32 \
  -m "$ROBOSTACK_DIR/.ci_support/conda_forge_pinnings.yaml" \
  -m "$ROBOSTACK_DIR/conda_build_config.yaml"
