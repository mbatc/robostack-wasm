#!/usr/bin/env bash

echo Installing Python
sudo apt-get install python3

echo Installing Miniconda

SCRIPT_DIR=$(dirname "$0")

mkdir -p /tmp/emrobostack

# download installers
cd /tmp/emrobostack
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o Miniconda3-installer.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-installer.sh

~/miniconda3/bin/conda init bash

# source .bashrc so we can immediately use conda 
. ~/.bashrc

echo Installing mamba
conda install mamba -c conda-forge

echo Installing pip and boa
mamba install pip

python -m pip install git+https://github.com/DerThorsten/boa.git@python_api --ignore-installed
python -m pip install git+https://github.com/mbatc/vinca.git@mbatchelor/emscripten --ignore-installed
