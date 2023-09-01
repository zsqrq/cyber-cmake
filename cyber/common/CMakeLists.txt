cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-common)
set(CYBER_COMMON_SRCS
    "${CMAKE_CURRENT_SOURCE_DIR}/file.cc"
    "${CMAKE_CURRENT_SOURCE_DIR}/global_data.cc"
    )
link_directories(${CMAKE_SOURCE_DIR}/third_party/lib)
file(GLOB_RECURSE CYBER_COMMON_HDRS "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_COMMON_SRCS}
    COMPONENT_NAME cyber_cmake_common
    PRIVATE_LIBS cyber-base
    PUBLIC_LIBS cyber-cmake-proto ${DEPENCENCY_LIBS} glog gflags
)

