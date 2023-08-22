#!/usr/bin/env bash
eval "$(conda shell.bash hook)"

ENV_NAME=$1

conda deactivate
conda deactivate
conda remove -n $ENV_NAME --all
