cmake_minimum_required(VERSION 3.16)

project(Cyber-Cmake)

find_package(CyberConfig REQUIRED)

set(CMAKE_CXX_STANDARD 17)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

add_executable(CyberCmake main.cpp)
install(TARGETS CyberCmake
    RUNTIME
    DESTINATION bin)
