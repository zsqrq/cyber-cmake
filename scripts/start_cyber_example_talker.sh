#!/bin/bash

script_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
production_root_path=$(dirname "$script_path")
source ${script_path}/setup.sh

sleep 1
${production_root_path}/bin/cyber/examples/cyber_example_talker 
