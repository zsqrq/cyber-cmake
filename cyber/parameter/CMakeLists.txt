cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-parameter)

file(GLOB_RECURSE CYBER_PARAMETER_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_PARAMETER_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_PARAMETER_SRCS EXCLUDE REGEX "example/.*")
list(FILTER CYBER_PARAMETER_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_PARAMETER_SRCS}
    COMPONENT_NAME cyber_cmake_parameter
    PRIVATE_LIBS cyber-base
    PUBLIC_LIBS cyber-cmake-proto cyber-cmake-common cyber-cmake-scheduler
)