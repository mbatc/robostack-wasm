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
    "cppcheck"
    "gtest"
    "yaml-cpp"
    "uncrustify"
    "benchmark"
    "spdlog"
    "yaml"
  )
  
  for dep in ${DEPS_LIST[@]}; do
    echo Building Package: ${dep}
    python "builder.py" build explicit "recipes/recipes_emscripten/${dep}" --emscripten-32
  done
else
  echo Building specific package: ${SPECIFIC_PACKAGE}
  python "builder.py" build explicit "recipes/recipes_emscripten/${SPECIFIC_PACKAGE}" --emscripten-32
fi


cd "$INITIAL_DIR"
