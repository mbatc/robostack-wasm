import os
import shutil

def find_files(directory, test):
  ret = []
  for root, _, files in os.walk(directory):
    for file in files:
      if test(file):
        ret.append(os.path.join(root, file))
  return ret

def get_cmake_package_info(file):
  package_suffixes = [ "Config.cmake" ]
  for suffix in package_suffixes:
    if file.endswith(suffix):
      return file[0:-len(suffix)], os.path.dirname(file)
  return None, None

def discover_built_cmake_packages(root_dir):
  remaining = [ root_dir ]
  ret = {}
  while len(remaining) > 0:
    current = remaining.pop()
    for root, subdirs, files in os.walk(current):
      for file in files:
        name, path = get_cmake_package_info(file)
        if name is None or path is None:
          continue

        if name not in ret:
          ret[name] = os.path.join(root, path)
          print("Discovered package {}: {}".format(name, path))

  return ret

if __name__ == "__main__":
  packages = discover_built_cmake_packages("install")
  print(len(packages), " cmake packages have been discovered")
  print(packages)
  
  module_paths_file = os.path.abspath("module_paths.cmake")
  
  with open(module_paths_file, 'w') as module_paths:
    module_paths.writelines(
      [
        "set({}_DIR \"{}\")\n".format(package, os.path.abspath(packages[package]))
        for package in packages
      ]
    )

  cmake_files = find_files("src", lambda a : os.path.basename(a) == "CMakeLists.txt")
  print("Injecting dependencies paths into CMakeLists.txt found in src/")
  print("Found", len(cmake_files), "cmake projects")
  print(cmake_files)
  
  for cmake_config in cmake_files:
    content = None
    with open(cmake_config + ".bak" if os.path.exists(cmake_config + ".bak") else cmake_config, 'r') as f:
      content = f.readlines()

    content = [ line for line in content if line.find("include(\"/home/mbatc/dev/ros2_cc_ws/module_paths.cmake\")") == -1 ]

    # Determine which packages are set in the file
    included = {}
    sets     = {}
    included_line_map = [None]*len(content)
    sets_line_map     = [None]*len(content)
    for i, line in enumerate(content):
      if line.find("find_package(") != -1:
        for package in packages.keys():
          if package in included:
            continue

          if line.find("find_package({} ".format(package)) != -1:
             #print(cmake_config, "uses", package)
            included[package]    = i
            included_line_map[i] = package

      if line.find("set(") != -1:
        for package in packages.keys():
          if package not in included:
            continue

          if line.find("set({}_DIR ".format(package)) != -1:
            # print(cmake_config, "sets", "{}_DIR".format(package))
            sets[package]    = i
            sets_line_map[i] = package

    # Remove any previous "set(...)" for modules to make sure paths are updated
    # for ln, set_package in reversed(list(enumerate(sets_line_map))):
    #   if set_package is not None:
    #     content.pop(ln)
    #     included_line_map.pop(ln)

    # Generate "set(<module>_DIR PATH)" lines
    # ln = 0
    # for package in included_line_map:
    #   if package is not None:
    #     new_line = "set({}_DIR \"{}\")\n".format(package, os.path.abspath(packages[package]))
    #     print("Adding", new_line)
    #     content.insert(0, new_line)
    #     ln = ln + 1
    #   ln = ln + 1

    content.insert(0, "include(\"{}\")\n\n".format(module_paths_file))

    out_file = cmake_config
    # print('Writing modified CMakeLists.txt to {}'.format(out_file))

    if not os.path.exists(cmake_config + ".bak"):
      shutil.copy(cmake_config, cmake_config + ".bak")

    with open(out_file, 'w') as f:
      f.writelines(content)
