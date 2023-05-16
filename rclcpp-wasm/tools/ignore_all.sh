echo "Ignoring lots of files"

for f in $(find ./src -name "CMakeLists.txt");
do
  
  touch $(dirname "${f}")/COLCON_IGNORE
  echo $f;
done
