Cross compilation to WASM with emscripten and  Robostack

# Channels
  - https://repo.mamba.pm/emscripten-forge
  - robostack-staging
  - conda-forge

# Environment Setup

The build environment is created from the emscripten-forge [ci_env](https://github.com/emscripten-forge/recipes/blob/main/ci_env.yml) file with

```sh
wget https://github.com/emscripten-forge/recipes/blob/main/ci_env.yml
conda env create -f ci_env.yml -n emrobostack
```

