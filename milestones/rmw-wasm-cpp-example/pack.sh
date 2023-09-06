WASM_ENV=$1

rm -r -f ./dist
mkdir ./dist

curl https://raw.githubusercontent.com/emscripten-forge/recipes/main/empack_config.yaml --output empack_config.yaml

empack pack env \
    --env-prefix "$MAMBA_ROOT_PREFIX/envs/$WASM_ENV" \
    --config empack_config.yaml \
    --outdir dist

cp -a $MAMBA_ROOT_PREFIX/envs/$WASM_ENV/lib_js/pyjs/. dist
cp -a ./src/. dist
