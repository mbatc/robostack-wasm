
This document is used to document some of the thought behind decisions made when modify Robostack/Vinca and Emscripten Forge.

# Vinca

# build_ament_cmake.sh.in

This is the build script template that builds C/C++ packages that use CMake as the build system. The changes here focussed on selecting the correct arguments for the CMake and build script template to correctly build ROS packages with emscripten.

The changes for emscripten are mostly enclose in an `if [[ $target_platform =~ emscripten.* ]]` block. The variable `EXTRA_CMAKE_ARGS` is used to select different arguments for emscripten vs other platforms. Unfortunately when building with emscripten there are some substantive differences between its toolchain and native C/C++ toolchains making it hard to unify these build processes. This separation is a reasonable solution for now, until emscripten matures and comes more inline with native toolchains.

## __vinca_shared_lib_patch.cmake

The build script writes an additional cmake file to be included all projects when build. This script makes some modifications to variables to fix some issues encountered with building shared libraries.

The issues which this fixes are described in these github issues,
* [SHARED / dynamic library with CMake](https://github.com/emscripten-core/emscripten/issues/15276)
* [dynamic linking fails with cmake](https://github.com/emscripten-core/emscripten/issues/16157)

There is also this [pull request](https://github.com/emscripten-core/emscripten/pull/16281) open in emscripten-core which aims to resolve these problems. We should be able to remove this fix once the pull request is merged and released.

The variables which are modified by the include file are:

* **GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS**: This is set to TRUE to force cmake to allow building shared libraries. Specifically this prevents the following warning from being produced,
  ```
  ADD_LIBRARY called with SHARED option but the target platform does not
  support dynamic linking.  Building a STATIC library instead.  This may lead
  to problems.
  ```
  Building shared libraries with emscripten is experimental so normally building static libraries is prefered. with emscripten as shared libraries are experimental. 
* **CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS**: "-s SIDE_MODULE=1" is added. This passes the SIDE_MODULE argument to the linker so that we correctly build shared objects as side modules.
* **CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS**: Same as **CMAKE_SHARED_LIBRARY_CREATE_C_FLAGS** except for the C++ compiler/linker.
* **CMAKE_STRIP**: This is set to FALSE to prevent the strip executable from running on the build binaries. This stops debugging and symbol information from being removed, as well as stops dead code elimination. You can find a brief description of what the strip process does [here](https://en.wikipedia.org/wiki/Strip_(Unix)).

  It may be worth considering adding something analogous to `
set(CMAKE_STRIP "${EMSCRIPTEN_ROOT_PATH}/emstrip${EMCC_SUFFIX}" CACHE FILEPATH "Emscripten strip")` so that we use emscriptens `strip` implementation, instead of disabling it alltogether.
* **CMAKE_EXE_LINKER_FLAGS**: This variable is cleared. Without this change it contains "-sSIDE_MODULE=1", causing executables to be compiled as side modules. When compiled as a side module the javascript glu code is not generated. This change fixes that.
