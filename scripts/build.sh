#！/bin/bash
set -e
START_TIME=$(date --date='0 days ago' "+%Y-%m-%d %H:%M:%S")
script_path=$(dirname $(readlink -f $0))
INSTALL_PREFIX="$script_path/../third_party"
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
function download() {
  URL=$1
  LIB_NAME=$2
  DOWNLOAD_PATH="$script_path/../third_party/$LIB_NAME/"
  if [ -e $DOWNLOAD_PATH ]
  then
    echo ""
  else
    echo "############### Install $LIB_NAME $URL ################"
    git clone $URL "$DOWNLOAD_PATH"
  fi
}
function install_fast_rtps() {
    echo -e "\033[36m ############### Build Fast-DDS. ################ \033[0m \n"
    local INSTALL_PATH="$script_path/../third_party/"
    if [[ "${ARCH}" == "x86_64" ]]; then
        PKG_NAME="fast-rtps-1.5.0-1.prebuilt.x86_64.tar.gz"
    else # aarch64
        PKG_NAME="fast-rtps-1.5.0-1.prebuilt.aarch64.tar.gz"
    fi
    DOWNLOAD_LINK="https://apollo-system.cdn.bcebos.com/archive/6.0/${PKG_NAME}"
    if [ -e $INSTALL_PATH/fast-rtps-1.5.0-1 ]
    then
      echo ""
    else
      wget -t 10 $DOWNLOAD_LINK -P $INSTALL_PATH
      pushd $INSTALL_PATH
      tar -zxf ${PKG_NAME}
 #    cp -r fast-rtps-1.5.0-1/* ../install
      rm -rf fast-rtps-1.5.0-1.prebuilt.x86_64.tar.gz
      popd
    fi

}
function install_gfamily() {
  echo "############### Build Google Libs. ################"
  download "https://github.com/gflags/gflags.git" "gflags"
  download "https://github.com/google/glog.git" "glog"
  download "https://github.com/google/googletest.git" "googletest"
#  download "https://github.com/protocolbuffers/protobuf.git" "protobuf"

  # gflags
  pushd "$script_path/../third_party/gflags/"
  git checkout v2.2.0
  mkdir -p build && cd build
  CXXFLAGS="-fPIC" cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DBUILD_SHARED_LIBS=ON ..
  make install -j$(nproc)
  rm -rf $script_path/../third_party/gflags
  popd

  # glog
  pushd "$script_path/../third_party/glog/"
  git checkout v0.4.0
  mkdir -p build && cd build
  if [ "$ARCH" == "x86_64" ]; then
    CXXFLAGS="-fPIC" cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DBUILD_SHARED_LIBS=ON ..
  elif [ "$ARCH" == "aarch64" ]; then
    CXXFLAGS="-fPIC" cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DBUILD_SHARED_LIBS=ON ..
  else
      echo "not support $ARCH"
  fi
  make install -j$(nproc)
  rm -rf $script_path/../third_party/glog
  popd

  # googletest
  pushd "$script_path/../third_party/googletest/"
  git checkout release-1.10.0
  mkdir -p build && cd build
  CXXFLAGS="-fPIC" cmake -DCMAKE_CXX_FLAGS="-w" -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX -DBUILD_SHARED_LIBS=ON ..
  make install -j$(nproc)
  rm -rf $script_path/../third_party/googletest
  popd

  # protobuf
#  pushd "$CURRENT_PATH/../third_party/protobuf/"
#  git checkout v3.14.0
#  cd cmake && mkdir -p build && cd build
#  cmake -Dprotobuf_BUILD_SHARED_LIBS=ON -Dprotobuf_BUILD_TESTS=OFF -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX ..
#  make install -j$(nproc)
#  popd
}

function build() {
    echo -e "\033[36m ....... Start Compileing Project $PROJECT_NAME .......\033[0m \n"
    build_path=$PROJECT_FOLDER/build/$BUILD_PLATFORM
    install_path=$build_path/../../production
    bash ${script_path}/proto_gen.sh "${build_path}"
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

    cmake --build $build_path -- -j8 VERBOSE=1
    cmake --build $build_path --target install
}

function main() {
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        help
        exit 0
    fi
    if [ $BUILD_PLATFORM == 'x86' ]; then
        echo -e "\033[36m Building System On X86_64 Platform \033[0m \n"
        ARCH='x86_64'
        toolchain_cmake=$script_path/../platform/toolchain_x86_64.cmake
        if [ -e $toolchain_cmake ]; then
            echo -e "\033[36m Building tool chain configuration cmake file found \033[0m \n"
        fi
    fi
#    install_fast_rtps
#    install_gfamily
    build
    sudo rm -rf $PROJECT_FOLDER/build
}
main "$@"
