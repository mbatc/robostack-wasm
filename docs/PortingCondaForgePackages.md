# Porting Conda Forge Packages

Occasionally a ROS package will depend on a library provided by Conda Forge. In this situation we
will need to provide a Web Assembly version of the library. To do this, we can port the Conda
Forge recipe to Emscripten Forge and then build the package using Emscripten so that our recipes
can reference it as a dependency. The steps to port a package are,
1. Search the [Conda Forge GitHub](https://github.com/conda-forge) for an existing feedstock
repository which will contain the recipe.
2. Find the meta.yaml file and any build scripts/patches that it references. This is the build
recipe and is usually found in a recipe folder.
3. Conda forge recipes follow the Conda build recipe specification. This is slightly different to
the boa recipe specification which Emscripten forge uses. They both express the same
concepts however Boa uses a slightly different format.
4. Create a new folder in emscripten-forge-recipes/recipes/recipes_emscripten with the name
of the package you are building.
5. Copy the meta.yaml and associated files to this folder.
6. Convert the meta.yaml to follow the Boa recipe specification and rename it to recipe.yaml
a. As we only Emscripten packages on Linux you can remove any lines specific to
Windows and OSX from the recipe. These are prepended with [win] or [osx].
7. If there is an external build script this can be renamed to build.sh and placed next to the
recipe.yaml. Boa will automatically find and run this build script when building the package.
