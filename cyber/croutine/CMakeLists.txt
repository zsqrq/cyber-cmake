cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-croutine)

if(COMPILE_PLATFOM STREQUAL "x86")
  set(CYBER_CROUTINE_FILE "${CMAKE_CURRENT_SOURCE_DIR}/detail/swap_x86_64.S")
elseif(COMPILE_PLATFOM STREQUAL "aarch64")
  set(CYBER_CROUTINE_FILE "${CMAKE_CURRENT_SOURCE_DIR}/detail/swap_aarch64.S")
endif()

file(GLOB_RECURSE CYBER_CROUTINE_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_CROUTINE_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_CROUTINE_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_CROUTINE_SRCS} ${CYBER_CROUTINE_FILE}
    COMPONENT_NAME cyber_cmake_croutine
    PRIVATE_LIBS cyber-base
    PUBLIC_LIBS cyber-cmake-proto cyber-cmake-common
)