
SCRIPT_DIR=$(dirname "$0")

ROS_ENV_NAME=$1
if [ "$ROS_ENV_NAME" = "" ]; then
  ROS_ENV_NAME=emrobostack
  echo No name specified. Defaulting to $ROS_ENV_NAME
fi

./micromamba create \
    --platform=emscripten-32 \
    -f $SCRIPT_DIR/../envs/emrobostack.yaml  \
    -n $ROS_ENV_NAME \
    -c https://repo.mamba.pm/emscripten-forge \
    -c https://repo.mamba.pm/conda-forge

./micromamba activate $ROS_ENV_NAME

# this adds the conda-forge channel to the new created environment configuration 
./micromamba config --env --add channels conda-forge
# and the robostack channel
./micromamba config --env --add channels robostack-staging
# remove the defaults channel just in case, this might return an error if it is not in the list which is ok
./micromamba config --env --remove channels defaults
