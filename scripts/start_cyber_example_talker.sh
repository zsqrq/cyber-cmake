#!/bin/bash

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
production_root_path=$(dirname "$script_path")

CYBER_PATH=${production_root_path}/share/
PATH=${production_root_path}/bin:${production_root_path}/bin/cyber/tools:$PATH
PYTHONPATH=$production_root_path/lib/python@Python_VERSION@/site-packages:$PYTHONPATH
LIBRARY_PATH=$production_root_path/lib:$LIBRARY_PATH
LD_LIBRARY_PATH=$production_root_path/lib:$LD_LIBRARY_PATH
CMAKE_PREFIX_PATH=$production_root_path:$CMAKE_PREFIX_PATH

export PATH CYBER_PATH LD_LIBRARY_PATH LIBRARY_PATH CMAKE_PREFIX_PATH PYTHONPATH

bazel_bin_path="${production_root_path}/bin"

sleep 1
${production_root_path}/bin/cyber_example_talker 

# echo "Setup path is : ${production_root_path}"