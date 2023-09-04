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
mainboard_path="${bazel_bin_path}/cyber/mainboard"
cyber_tool_path="${bazel_bin_path}/cyber/tools"
recorder_path="${cyber_tool_path}/cyber_recorder"
launch_path="${cyber_tool_path}/cyber_launch"
channel_path="${cyber_tool_path}/cyber_channel"
node_path="${cyber_tool_path}/cyber_node"
service_path="${cyber_tool_path}/cyber_service"
monitor_path="${cyber_tool_path}/cyber_monitor"

for entry in "${mainboard_path}" \
    "${recorder_path}" "${monitor_path}"  \
    "${channel_path}" "${node_path}" \
    "${service_path}" \
    "${launch_path}" ; do
    export PATH="${entry}":$PATH
done

export GLOG_alsologtostderr=1
export GLOG_colorlogtostderr=1
export GLOG_minloglevel=0
export sysmo_start=0
export CYBER_DOMAIN_ID=80
export CYBER_IP=127.0.0.1

echo "Setup path is : ${bazel_bin_path}"
sleep 1
gdb ${production_root_path}/bin/cyber/examples/cyber_example_talker 
