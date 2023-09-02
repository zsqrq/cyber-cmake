cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-message)

file(GLOB_RECURSE CYBER_MESSAGE_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_MESSAGE_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_MESSAGE_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_MESSAGE_SRCS}
    COMPONENT_NAME cyber_cmake_message
    PUBLIC_LIBS cyber-cmake-common cyber-cmake-scheduler 
)