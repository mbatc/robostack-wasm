if [ "$1" != "" ]; then
  export SPECIFIC_PACKAGE="--packages-select $1"
  echo $SPECIFIC_PACKAGE
fi

colcon build $SPECIFIC_PACKAGE --cmake-force-configure --cmake-args \
  -DCMAKE_TOOLCHAIN_FILE=~/emsdk/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake \
  -DCMAKE_FIND_DEBUG_MODE=ON \
  -DCMAKE_FIND_USE_CMAKE_PATH=TRUE \
  -DTHREADS_PREFER_PTHREAD_FLAG=TRUE \
  -DCMAKE_FIND_USE_CMAKE_ENVIRONMENT_PATH=TRUE \
  --debug-trycompile \
  -DCMAKE_CROSSCOMPILING_EMULATOR=/home/mbatc/emsdk/node/15.14.0_64bit/bin/node \
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON 
