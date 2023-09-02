cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-node)

file(GLOB_RECURSE CYBER_NODE_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_NODE_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_NODE_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_NODE_SRCS}
    COMPONENT_NAME cyber_cmake_node
    PUBLIC_LIBS cyber-cmake-scheduler cyber-cmake-blocker fastrtps fastcdr 
)