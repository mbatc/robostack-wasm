#!/bin/bash -i

export INITIAL_DIR=$(cd)
export FORGE_PATH="$1"
export SPECIFIC_PACKAGE="$2"

if [ "$FORGE_PATH" == "" ]; then
  FORGE_PATH=.
fi

echo Emscripten Forge: $FORGE_PATH

cd "$FORGE_PATH"

if [ "$SPECIFIC_PACKAGE" == "" ]; then
  echo "Build all"
  DEPS_LIST=(
    "pcre"
    "fmt"
    "cppcheck"
    "gtest"
    "yaml-cpp"
    "uncrustify"
    "benchmark"
    "spdlog"
    "yaml"
    "console_bridge"
  )

  for dep in ${DEPS_LIST[@]}; do
    echo Building Package: ${dep}
    python "builder.py" build explicit "recipes/recipes_emscripten/${dep}" --emscripten-wasm32
  done
else
  echo Building specific package: ${SPECIFIC_PACKAGE}
  python "builder.py" build explicit "recipes/recipes_emscripten/${SPECIFIC_PACKAGE}" --emscripten-wasm32
fi


cd "$INITIAL_DIR"
