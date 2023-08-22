#!/usr/bin/env bash
eval "$(conda shell.bash hook)"

ROS_ENV_NAME=$1
ROS_DISTRO=$2

SCRIPT_DIR=$(dirname "$0")

if [ "$ROS_ENV_NAME" = "" ]; then
  ROS_ENV_NAME=robostackenv
  echo No name specified. Defaulting to '$ROS_ENV_NAME'
fi

if [ "$ROS_DISTRO" = "" ]; then
  ROS_DISTRO=humble
  echo No ROS distro specified. Defaulting to '$ROS_DISTRO'
fi

echo --------------------------
echo  Name:   $ROS_ENV_NAME
echo  Distro: ROS $ROS_DISTRO
echo --------------------------

echo Configuring channels

mamba create -n $ROS_ENV_NAME ros-$ROS_DISTRO-desktop python=3.10 -c robostack-staging -c conda-forge --no-channel-priority --override-channels

echo Installing pip and boa
mamba install pip boa -c conda-forge

conda activate $ROS_ENV_NAME

echo Configuring channels
# this adds the conda-forge channel to the new created environment configuration 
conda config --env --add channels conda-forge
# and the robostack channel
conda config --env --add channels robostack-staging
# remove the defaults channel just in case, this might return an error if it is not in the list which is ok
conda config --env --remove channels defaults

echo Installing compiler and build tools
# optionally, install some compiler packages if you want to e.g. build packages in a colcon_ws:
mamba install compilers cmake pkg-config make ninja colcon-common-extensions
mamba install mesa-libgl-devel-cos7-x86_64 mesa-dri-drivers-cos7-x86_64 libselinux-cos7-x86_64 libxdamage-cos7-x86_64 libxxf86vm-cos7-x86_64 libxext-cos7-x86_64 xorg-libxfixes

conda deactivate
conda activate $ROS_ENV_NAME

VINCA_REPO=$SCRIPT_DIR/../vinca
echo Pip installing local vinca repo: $VINCA_REPO

pip install "$VINCA_REPO"

ACTIVATE_SCRIPT=$SCRIPT_DIR/../activate-env.sh

echo "$(conda shell.bash hook)" > $ACTIVATE_SCRIPT
echo "conda activate $ROS_ENV_NAME" >> $ACTIVATE_SCRIPT
chmod +x $ACTIVATE_SCRIPT

echo
echo \"$ROS_ENV_NAME\" environment has been set up
echo
echo -------------------------------------------------------
echo Source $ACTIVATE_SCRIPT to activate the new environment
echo   e.g. ". activate-env.sh"
echo -------------------------------------------------------
