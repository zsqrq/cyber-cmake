cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-proto)

# message(FATAL_ERROR "PROTO_SRCS libs : ${CMAKE_BINARY_DIR}")
file(GLOB PROTO_SRCS 
    "${CMAKE_BINARY_DIR}/cyber/proto/*.cc"
    "${CMAKE_BINARY_DIR}/cyber/examples/proto/*.cc"
    "${CMAKE_BINARY_DIR}/modules/common_msgs/**/*.cc"
    )
# message(FATAL_ERROR "PROTO_SRCS libs : ${PROTO_SRCS}")
cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${PROTO_SRCS}
    PUBLIC_LIBS protobuf ${DEPENCENCY_LIBS} glog gflags 
)



