cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-time)

file(GLOB_RECURSE CYBER_TIME_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_TIME_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_TIME_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_TIME_SRCS}
    COMPONENT_NAME cyber_cmake_time
    PUBLIC_LIBS cyber-cmake-common
)