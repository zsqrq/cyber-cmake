cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-transport)

set(fastcdr_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/third_party/fast-rtps-1.5.0-1/include CACHE INTERNAL "")
set(fastrtps_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/third_party/fast-rtps-1.5.0-1/include CACHE INTERNAL "")
set(fastrtps_LIB_DIR ${CMAKE_SOURCE_DIR}/third_party/fast-rtps-1.5.0-1/lib CACHE INTERNAL "")
set(fastcdr_LIB_DIR ${CMAKE_SOURCE_DIR}/third_party/fast-rtps-1.5.0-1/lib CACHE INTERNAL "")

file(GLOB_RECURSE CYBER_TRANSPORT_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(FILTER CYBER_TRANSPORT_SRCS EXCLUDE REGEX "test/.*")
list(FILTER CYBER_TRANSPORT_SRCS EXCLUDE REGEX "example/.*")
list(FILTER CYBER_TRANSPORT_SRCS EXCLUDE REGEX "_test.cc")

cyber_add_library(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_TRANSPORT_SRCS}
    COMPONENT_NAME cyber_cmake_transport
    PUBLIC_LIBS cyber-cmake-common cyber-cmake-scheduler fastrtps fastcdr atomic uuid
)
