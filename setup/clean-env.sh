#!/bin/bash -i

eval "$(micromamba shell hook --shell bash)"

ENV_NAME=$1

micromamba deactivate
micromamba deactivate
micromamba remove -n $ENV_NAME --all
