
INITIAL_DIR=$(cd)
FORGE_PATH="$1"
SPECIFIC_PACKAGE="$2"

if [ "$FORGE_PATH" == "" ]; then
  FORGE_PATH=.
fi

cd "$FORGE_PATH"

if [ "$SPECIFIC_PACKAGE" == ""]; then
  DEPS_LIST=(
    "pcre"
    "cppcheck"
    "gtest"
    "yaml-cpp"
    "uncrustify"
    "benchmark"
  )

  for dep in ${DEPS_LIST[@]}; do
    python "builder.py" build explicit "recipes/recipes_emscripten/${dep}" --emscripten-32
  done
else
  echo Building specific package: $SPECIFIC_PACKAGE
  python "builder.py" build explicit "recipes/recipes_emscripten/${SPECIFIC_PACKAGE}" --emscripten-32
fi


cd "$INITIAL_DIR"
