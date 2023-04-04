# Install and Setup

1. To install the required tools run `scripts/install-tools.sh` and follow the prompts. This will install,
    * Python3
    * Miniconda3
    * Mamba
    * Pip
    * Boa

   Resources are downloaded to a `downloads` folder in the root of the repo. You can safely remove this folder once setup is complete.

2. Restart your shell to load the conda environment.
3. Run `scripts/setup-env.sh` to create a conda environment configured to work with RoboStack. The first argument is the name of the new environment and the seconds argument is the ROS distro to use, e.g. `./scripts/setup-env.sh myrobostackenv humble`
    > The default name is "robostackenv" and the default distro is ROS "humble"
