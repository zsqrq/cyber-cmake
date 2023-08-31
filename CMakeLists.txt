cmake_minimum_required(VERSION 3.16)

project(Cyber-Cmake)

find_package(CyberConfig REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(CYBER_DOCS_TARGET_SRC ${CMAKE_SOURCE_DIR}/cyber CACHE INTERNAL "For Document Generation")


if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
    set(DEFAULT_COMPILE -std=c++17 -O0 -g3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
else()
    set(DEFAULT_COMPILE -std=c++17 -O3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
endif()

if(DEFINED ENABLE_DOCMENTATION)
    generate_doc_file()
endif()

add_executable(CyberCmake main.cpp)
install(TARGETS CyberCmake
    RUNTIME
    DESTINATION bin)
add_subdirectory(cyber/base)
