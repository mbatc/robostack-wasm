#!/bin/bash -i

echo "Installing Python"
sudo apt-get install make
sudo apt-get install python3

echo "Installing micromamba"

SCRIPT_DIR=$(dirname "$0")

# download installers
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)

# source .bashrc so we can immediately use conda 
source ~/.bashrc

eval "$(micromamba shell hook --shell bash)"

# TODO: FIX THIS - THERE IS NO BASE ENV WITH MICROMAMBA!
# echo "Activating base environment"
# micromamba activate

# echo "Installing mamba and pip"
# micromamba install mamba pip make python git -c conda-forge -y

echo "Installing emsdk"

if [ ! -d "~/emsdk_enscripten_forge" ]; then
  git clone https://github.com/emscripten-core/emsdk.git ~/emsdk_enscripten_forge
fi

~/emsdk_enscripten_forge/setup_emsdk.sh 3.1.45 ~/emsdk

echo "source $HOME/emsdk/emsdk_env.sh" >> $HOME/.bashrc

echo -n $HOME/emsdk > $HOME/.emsdkdir
