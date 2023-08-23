#!/usr/bin/env bash
eval "$(conda shell.bash hook)"

SCRIPT_DIR=$(dirname "$0")

ROS_ENV_NAME=$1
if [ "$ROS_ENV_NAME" = "" ]; then
  ROS_ENV_NAME=emrobostack-dev
  echo No name specified. Defaulting to $ROS_ENV_NAME
fi

conda env create \
    -f $SCRIPT_DIR/../envs/emrobostack-dev.yaml  \
    -n $ROS_ENV_NAME

conda activate $ROS_ENV_NAME

# and emscripten forge channel
conda config --env --add channels https://repo.mamba.pm/emscripten-forge
# this adds the conda-forge channel to the new created environment configuration 
conda config --env --add channels conda-forge
# and the robostack channel
conda config --env --add channels robostack-staging
# remove the defaults channel just in case, this might return an error if it is not in the list which is ok
conda config --env --remove channels defaults

mamba install compilers cmake pkg-config make ninja colcon-common-extensions
mamba install mesa-libgl-devel-cos7-x86_64 mesa-dri-drivers-cos7-x86_64 libselinux-cos7-x86_64 libxdamage-cos7-x86_64 libxxf86vm-cos7-x86_64 libxext-cos7-x86_64 xorg-libxfixes

echo Installing pip and boa
mamba install pip

python -m pip install git+https://github.com/DerThorsten/boa.git@python_api --no-deps --ignore-installed

python -m pip install git+https://github.com/mbatc/vinca.git@mbatchelor/emscripten  --no-deps--ignore-installed

python -m pip install git+https://github.com/DerThorsten/bitfurnace.git@emscripten_new --no-deps --ignore-installed

playwright install

git clone https://github.com/emscripten-core/emsdk.git ~/emsdk

~/emsdk/emsdk install latest

~/emsdk/emsdk activate latest

echo 'source "/home/mbatc/emsdk/emsdk_env.sh"' >> $HOME/.bashrc

echo '/home/mbatc/emsdk' > $HOME/.emsdkdir
