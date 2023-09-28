#!/bin/bash -i

eval "$(micromamba shell hook --shell bash)"

SCRIPT_DIR=$(dirname "$0")

ROS_ENV_NAME=$1
if [ "$ROS_ENV_NAME" = "" ]; then
  ROS_ENV_NAME=emrobostack-dev
  echo No name specified. Defaulting to $ROS_ENV_NAME
fi

micromamba create \
    -f $SCRIPT_DIR/../envs/emrobostack-dev.yaml  \
    -n $ROS_ENV_NAME \
    -c https://repo.mamba.pm/emscripten-forge \
    -c conda-forge \
    -c robostack-staging -y

micromamba activate $ROS_ENV_NAME

# this adds the conda-forge channel to the new created environment configuration 
micromamba config append channels conda-forge --env
# and the robostack channel
micromamba config append channels robostack-staging --env
# and the emscripten forge channel
micromamba config append channels https://repo.mamba.pm/emscripten-forge --env
# remove the defaults channel just in case, this might return an error if it is not in the list which is ok
micromamba config remove channels defaults --env

micromamba install compilers cmake pkg-config make ninja colcon-common-extensions -y
micromamba install mesa-libgl-devel-cos7-x86_64 mesa-dri-drivers-cos7-x86_64 libselinux-cos7-x86_64 libxdamage-cos7-x86_64 libxxf86vm-cos7-x86_64 libxext-cos7-x86_64 xorg-libxfixes -y

echo Installing pip and boa
micromamba install pip -y

python -m pip install git+https://github.com/DerThorsten/boa.git@python_api --no-deps --ignore-installed

python -m pip install git+https://github.com/mbatc/vinca.git@mbatchelor/emscripten --ignore-installed

python -m pip install git+https://github.com/DerThorsten/bitfurnace.git@emscripten_new --no-deps --ignore-installed

playwright install

