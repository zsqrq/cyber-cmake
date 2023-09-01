cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-task)

file(GLOB_RECURSE CYBER_TASK_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_TASK_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_TASK_SRCS EXCLUDE REGEX "example/.*")
list(FILTER CYBER_TASK_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_TASK_SRCS}
    COMPONENT_NAME cyber_cmake_task
    PRIVATE_LIBS cyber-base
    PUBLIC_LIBS cyber-cmake-proto cyber-cmake-common cyber-cmake-scheduler
)