#!/bin/bash -i

INITIAL_DIR=$(cd)

cd $1

vinca -m --platform=emscripten-wasm32

cd $INITIAL_DIR
