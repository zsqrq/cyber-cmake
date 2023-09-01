cmake_minimum_required(VERSION 3.16)
project(cyber-cmake-service)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
file(GLOB_RECURSE CYBER_SERVICE_HDRS ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
cyber_add_header_lib(
    TARGET cyber-cmake-service
    SOURCES ${CYBER_SERVICE_HDRS})

install(TARGETS cyber-cmake-service
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    )