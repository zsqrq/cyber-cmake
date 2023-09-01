cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-component)

file(GLOB_RECURSE CYBER_COMPONENT_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_COMPONENT_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_COMPONENT_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_COMPONENT_SRCS}
    COMPONENT_NAME cyber_cmake_component
    PRIVATE_LIBS cyber-base cyber-cmake-proto cyber-cmake-common cyber-cmake-scheduler
      cyber-cmake-transport cyber-cmake-blocker
)