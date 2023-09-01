cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-data)

file(GLOB_RECURSE CYBER_DATA_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.h")
cyber_add_header_lib(
    TARGET cyber-cmake-data
    SOURCES ${CYBER_DATA_SRCS})

install(TARGETS cyber-cmake-data
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    )