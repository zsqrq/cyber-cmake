#！/bin/bash
set -e
START_TIME=$(date --date='0 days ago' "+%Y-%m-%d %H:%M:%S")
script_path=$(dirname $(readlink -f $0))
PROJECT_FOLDER=$(pwd)
PROJECT_NAME=${PROJECT_FOLDER##*/}
BUILD_PLATFORM=$1
BUILD_TYPE=$2
echo -e "\033[36m Start Building Project at time : $START_TIME \033[0m \n"

function help() {
    echo -e "Usage : \n
    bash $0 [options] [arguments] \n"
    echo -e "options : \n"
    echo -e "[-h or --help] : Display the help message \n"
    echo -e "arguments 1 : \n
    Building platform for this project \n"
    echo -e "arguments 2 : \n
    Building type for this project \n"
    echo -e "
    Example : \n
      1) bash scripts/build.sh x86 debug \n
      2) bash scripts/build.sh x86 release \n
      3) bash scripts/build.sh aarch64 debug \n
      3) bash scripts/build.sh aarch64 release \n
    "
}

function build() {
    echo -e "\033[36m ....... Start Compileing Project $PROJECT_NAME .......\033[0m \n"
    build_path=$PROJECT_FOLDER/build/$BUILD_PLATFORM
    install_path=$build_path/cyber
    echo -e "\033[36m ....... Install Path is  $install_path .......\033[0m \n"
    if [ ! -e $build_path ]; then
        mkdir -p $build_path
    else
        echo -e "\033[36m Build Directory : $build_path already exits \033[0m \n"
    fi

    cmake -S $PROJECT_FOLDER \
          -B $build_path \
          -DCMAKE_TOOLCHAIN_FILE=$toolchain_cmake \
          -DCMAKE_BUILD_TYPE=Debug \
          -DCMAKE_INSTALL_PREFIX=$install_path \
          -DCOMPILE_PLATFOM=$BUILD_PLATFORM

    cmake --build $build_path -- -j20 VERBOSE=1
    cmake --build $build_path --target install
}

function main() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
      help
      exit 0
    fi
    if [ $BUILD_PLATFORM == 'x86' ]; then
        echo -e "\033[36m Building System On X86_64 Platform \033[0m \n"
        toolchain_cmake=$script_path/../platform/toolchain_x86_64.cmake
        if [ -e $toolchain_cmake ]; then
            echo -e "\033[36m Building tool chain configuration cmake file found \033[0m \n"
        fi
    fi
    build
}
main "$@"