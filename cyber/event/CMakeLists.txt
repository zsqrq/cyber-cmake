cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-event)

file(GLOB_RECURSE CYBER_EVENT_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_EVENT_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_EVENT_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_EVENT_SRCS}
    COMPONENT_NAME cyber_cmake_event
    PRIVATE_LIBS cyber-base
    PUBLIC_LIBS cyber-cmake-proto cyber-cmake-common
)