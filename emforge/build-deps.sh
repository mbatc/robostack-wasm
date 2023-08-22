
DEPS_LIST=(
  "pcre"
  "cppcheck"
  "gtest"
  "yaml-cpp"
  "uncrustify"
)

for dep in ${DEPS_LIST[@]}; do
  python builder.py build explicit recipes/recipes_emscripten/${dep} --emscripten-32
done
