mamba create -n robostack-wasm --platform=emscripten-32 \ 
    -c https://repo.mamba.pm/emscripten-forge \ 
    -c https://repo.mamba.pm/conda-forge \
    python ipython numpy jedi
