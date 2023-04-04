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

# Building RoboStack Packages Locally

To build robostack packages locally you will need to do some setup in the `ros-humble` repo. These are,
  1. Move the vinca file you're interested in to `vinca.yaml`. You can use `cp vinca_windows_64.yaml vinca.yaml`, or create a symbolic link to the target vinca config file.
  2. Remove/comment the channel entry in the `vinca.yaml`'s `skip_existing` array. Also change `skip_all_deps` to `true` so we don't rebuild every dependency for every package.
  3. Run `vinca -m` to generate the recipes.
  4. `cd` into the `recipes` folder created by vinca.
  5. Run `boa build . -m ../.ci_support/conda_forge_pinnings.yaml -m ../conda_build_config.yaml`