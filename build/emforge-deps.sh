
FORGE_PATH=$1

if [ "$FORGE_PATH" = "" ]; then
  FORGE_PATH=.
fi

DEPS_LIST=(
  "pcre"
  "cppcheck"
  "gtest"
  "yaml-cpp"
  "uncrustify"
)

for dep in ${DEPS_LIST[@]}; do
  python "$FORGE_PATH/builder.py" build explicit "$FORGE_PATH/recipes/recipes_emscripten/${dep}" --emscripten-32
done
