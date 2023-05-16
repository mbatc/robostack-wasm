
echo "Ignoring lots of files"

echo > module_paths.cmake

for f in $(find ${PWD}/install -name "*Config.cmake");
do
  export MODULE_NAME="$(basename ${f} Config.cmake)"
  export MODULE_PATH="$(dirname ${f})"
  echo $f
  echo "set(${MODULE_NAME}_DIR \"${MODULE_PATH}\")" >> module_paths.cmake
done
