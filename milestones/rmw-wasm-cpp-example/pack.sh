WASM_ENV=$1

SCRIPT_DIR=$(dirname "$0")

rm -r -f $SCRIPT_DIR/dist
mkdir $SCRIPT_DIR/dist

curl https://raw.githubusercontent.com/emscripten-forge/recipes/main/empack_config.yaml --output $SCRIPT_DIR/empack_config.yaml

empack pack env \
    --env-prefix "$MAMBA_ROOT_PREFIX/envs/$WASM_ENV" \
    --config $SCRIPT_DIR/empack_config.yaml \
    --outdir $SCRIPT_DIR/dist

cp -a $MAMBA_ROOT_PREFIX/envs/$WASM_ENV/lib_js/pyjs/. $SCRIPT_DIR/dist
cp -a $SCRIPT_DIR/src/. $SCRIPT_DIR/dist

cp $SCRIPT_DIR/pyjs_runtime_browser.js $SCRIPT_DIR/dist/pyjs_runtime_browser.js

