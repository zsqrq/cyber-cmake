cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-base)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
file(GLOB_RECURSE CYBER_BASE_HDRS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
cyber_add_header_lib(
    TARGET cyber-base
    SOURCES ${CYBER_BASE_HDRS})

install(TARGETS cyber-base
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)