ENV_NAME=$1
DISTRO=$2

SCRIPT_DIR=$(dirname "$0")

if [$ENV_NAME = ""]; then
  ENV_NAME=robostackenv
  echo No name specified. Defaulting to '$ENV_NAME'
fi

if [$DISTRO = ""]; then
  DISTRO=humble
  echo No ROS distro specified. Defaulting to '$DISTRO'
fi

echo --------------------------
echo  Name:   $ENV_NAME
echo  Distro: ROS $DISTRO
echo --------------------------

echo Configuring channels

mamba create -n $ENV_NAME ros-$DISTRO-desktop python=3.10 -c robostack-staging -c conda-forge --no-channel-priority --override-channels

conda activate $ENV_NAME

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
conda activate $ENV_NAME

VINCA_REPO=$SCRIPT_DIR/../vinca
echo Pip installing local vinca repo: $VINCA_REPO

pip install "$VINCA_REPO" --no-deps
