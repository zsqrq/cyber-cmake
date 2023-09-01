cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-blocker)

file(GLOB_RECURSE CYBER_BLOCKER_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_BLOCKER_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_BLOCKER_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_BLOCKER_SRCS}
    COMPONENT_NAME cyber_cmake_blocker
    PRIVATE_LIBS cyber-base
    PUBLIC_LIBS cyber-cmake-proto cyber-cmake-common cyber-cmake-scheduler
)