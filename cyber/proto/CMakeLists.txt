cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-proto)

file(GLOB PROTO_SRCS 
    "${CMAKE_BINARY_DIR}/cyber/proto/*.cc"
    "${CMAKE_BINARY_DIR}/cyber/examples/proto/*.cc"
    "${CMAKE_BINARY_DIR}/modules/common_msgs/**/*.cc"
    )

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${PROTO_SRCS}
    PUBLIC_LIBS protobuf ${DEPENCENCY_LIBS} glog gflags 
)
file(WRITE ${CMAKE_BINARY_DIR}/${CYBER_PYTHON_PROTOBUF_PATH}/__init__.py "import os\n")
file(APPEND ${CMAKE_BINARY_DIR}/${CYBER_PYTHON_PROTOBUF_PATH}/__init__.py "import sys\n")
file(APPEND ${CMAKE_BINARY_DIR}/${CYBER_PYTHON_PROTOBUF_PATH}/__init__.py "sys.path.insert(0, os.path.abspath(os.path.dirname(__file__)))\n")

install(DIRECTORY ${CMAKE_BINARY_DIR}/cyber/proto/ ${CMAKE_BINARY_DIR}/${CYBER_PYTHON_PROTOBUF_PATH}/ 
    DESTINATION ${CYBER_PYTHON_PROTOBUF_PATH}
    FILES_MATCHING PATTERN "*.py"
)




