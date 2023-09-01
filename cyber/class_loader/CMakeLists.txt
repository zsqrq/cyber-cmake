cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-classloader)

file(GLOB_RECURSE CYBER_CLASS_LOADER_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_CLASS_LOADER_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_CLASS_LOADER_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_CLASS_LOADER_SRCS}
    COMPONENT_NAME cyber_cmake_classloader
    PRIVATE_LIBS cyber-base
    PUBLIC_LIBS cyber-cmake-proto cyber-cmake-common
)