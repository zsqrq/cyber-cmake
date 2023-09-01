cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-proto)

file(GLOB PROTO_SRCS "${CMAKE_BINARY_DIR}/cyber/proto/*.cc"
    "${CMAKE_BINARY_DIR}/cyber/modules/**/*.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${PROTO_SRCS}
    PUBLIC_LIBS protobuf ${DEPENCENCY_LIBS} glog gflags
)



