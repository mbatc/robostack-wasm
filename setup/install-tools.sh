#!/bin/bash -i

echo Installing Python
sudo apt-get install make
sudo apt-get install python3

echo Installing micromamba

SCRIPT_DIR=$(dirname "$0")

# download installers
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)

# cd /tmp/emrobostack
# curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-installer.sh
# chmod +x Miniconda3-latest-Linux-x86_64.sh
# 
# bash Miniconda3-installer.sh

# ~/miniconda3/bin/conda init bash

# source .bashrc so we can immediately use conda 
source ~/.bashrc

eval "$(micromamba shell hook --shell bash)"

echo Installing mamba
micromamba install mamba -c conda-forge -y

echo Installing pip
micromamba install pip -y

if [ ! -d "~/emsdk" ]; then
  git clone https://github.com/emscripten-core/emsdk.git ~/emsdk
fi

~/emsdk/emsdk install 3.1.27
~/emsdk/emsdk activate 3.1.27

echo "source $HOME/emsdk/emsdk_env.sh" >> $HOME/.bashrc

echo -n $HOME/emsdk > $HOME/.emsdkdir
