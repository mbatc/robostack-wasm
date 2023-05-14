Here I've just documented various issues I've encountered throughout this project.

# Emscripten Forge

## Outdated Local build Documentation

The setup guide I was following for emscripten forged had the following issues.

### Pip Install Incorrect Branch Name
___
* The branch name used when installing the boa python package is incorrect. The command given is,
```
python -m pip install git+https://github.com/DerThorsten/boa.git@postcb --no-deps --ignore-installed
```

This results in an import error when attempting to run Builder.py. The branch that needs to be installed is `python_api`. Therefor the command should instead be,

```
python -m pip install git+https://github.com/DerThorsten/boa.git@python_api --no-deps --ignore-installed
```

### Version Mismatch in .emsdkdir
___

The version used when piping the install location to .emsdkdir is hardcoded. You may need to double check that the directory is correct for the version of emsdk you are using.

For example, my file contained `/home/mbatc/.cache/empack/emsdk-3.1.2` when it should have instead been `/home/mbatc/.cache/empack/emsdk-3.1.27`

