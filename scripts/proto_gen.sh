#!/bin/bash

set -e
script_path=$(dirname $(readlink -f $0))
build_path=${script_path}/../build
root_path=${script_path}/..

function generate_source_file() {
    which protoc >/dev/null
    if [ $? -ne 0 ]; then
        echo -e "\033[31m Your System Does Not Has [protobuf] tool please install first \033[0m \n"
        exit 1
    fi
    local cpp_output_dir="$1"
    if [ ! -d "${cpp_output_dir}" ]; then
        echo -e " C++ source File Output Folder Does Not Exits "
        exit 1
    fi
    local python_output_dir="${cpp_output_dir}"
    local import_dir="$2"
    if [ ! -d "${import_dir}" ]; then
        echo -e "\033[31m Proto Import Directory Does Not Exits \033[0m \n"
        exit 1
    fi
    local file_path="$3"
    if [ ! -f "${file_path}" ]; then
        echo -e "\033[31m Proto Files Does Not Exits \033[0m \n"
        exit 3
    fi
    protoc --cpp_out "${cpp_output_dir}" --python_out="${python_output_dir}" -I "${import_dir}" "${file_path}"
    return $?
}

function generate_all_protos() {
    local proto_in_path=$1
    if [ ! -d ${proto_in_path} ]; then
        echo -e "\033[31m Proto Path: [${proto_in_path}] Does Not Exits \033[0m \n"
        exit 1
    fi
    cd ${proto_in_path}

    local import_dir=$2
    local output_dir=$3
    if [ ! -d ${proto_in_path} ]; then
        echo -e "\033[31m Proto Path: [${proto_in_path}] Does Not Exits \033[0m \n"
        exit 1
    fi
    for protofile in $(find -name "*.proto")
    do
        if [ ! -f ${protofile} ]; then
            echo -e "\033[31m Proto file: [${protofile}] Does Not Exits \033[0m \n"
            exit 1
        fi
        generate_source_file "${output_dir}" "${import_dir}" "${proto_in_path}/${protofile}"
        if [ $? -ne 0 ]; then
            echo -e "\033[31m Failed to generate protofiles : [${protofile}] \033[0m \n"
            continue
        fi
    done
    cd ->/dev/null
}

function main() {
    local output_dir="$1"
    CYBER_PROTO_PATH="${root_path}/cyber/proto"
    CYBER_EXAMPLE_PROTO_PATH="${root_path}/cyber/examples/proto"
    CYBER_MODULE_PROTO_PATH="${root_path}/modules/common_msgs"
    mkdir -p "${output_dir}"
    generate_all_protos "${CYBER_PROTO_PATH}" "${root_path}" "${output_dir}"
    generate_all_protos "${CYBER_EXAMPLE_PROTO_PATH}" "${root_path}" "${output_dir}"
    generate_all_protos "${CYBER_MODULE_PROTO_PATH}" "${root_path}" "${output_dir}"
}

main "$@"
exit $?