#!/bin/bash -i

eval "$(micromamba shell hook --shell bash)"

SCRIPT_DIR=$(dirname "$0")

ROS_ENV_NAME=$1
if [ "$ROS_ENV_NAME" = "" ]; then
  ROS_ENV_NAME=emrobostack
  echo No name specified. Defaulting to $ROS_ENV_NAME
fi

SRC_ROS_ENV_NAME=$2
if [ "$SRC_ROS_ENV_NAME" = "" ]; then
  SRC_ROS_ENV_NAME=$ROS_ENV_NAME-dev
  echo No source environment specified. Defaulting to $SRC_ROS_ENV_NAME
fi

micromamba create \
    --platform=emscripten-32 \
    -f $SCRIPT_DIR/../envs/emrobostack.yaml  \
    -n $ROS_ENV_NAME \
    -c https://repo.mamba.pm/emscripten-forge \
    -c https://repo.mamba.pm/conda-forge -y

micromamba activate $ROS_ENV_NAME

# this adds the conda-forge channel to the new created environment configuration
micromamba config append channels https://repo.mamba.pm/emscripten-forge --env
# add the local conda-bld that contains the emscripten-32 packages
micromamba config append channels $MAMBA_ROOT_PREFIX/envs/$SRC_ROS_ENV_NAME/conda-bld --env
# this adds the conda-forge channel to the new created environment configuration
micromamba config append channels conda-forge --env
# and the robostack channel
micromamba config append channels robostack-staging --env
# remove the defaults channel just in case, this might return an error if it is not in the list which is ok
micromamba config remove channels defaults --env
