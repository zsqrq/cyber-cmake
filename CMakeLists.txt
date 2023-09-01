cmake_minimum_required(VERSION 3.16)

project(Cyber-Cmake)

set(CMAKE_CXX_STANDARD 17)

if(NOT CMAKE_BUILD_TYPE)
    set(DEF Debug)
    set(DEFAULT_COMPILE -std=c++17 -O0 -g3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
else()
    set(DEFAULT_COMPILE -std=c++17 -O3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
endif()
#add_link_options(-Wl,--disable-new-dtags)
#set(CMAKE_INSTALL_RPATH "$ORIGIN/..lib")

if(DEFINED ENABLE_DOCMENTATION)
    generate_doc_file()
endif()
list(APPEND CMAKE_FIND_ROOT_PATH ${CMAKE_SOURCE_DIR}/cmake)
find_package(CyberConfig REQUIRED)

include_directories(
    ${CMAKE_INSTALL_PREFIX}
    ${CMAKE_BINARY_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CYBER_PROTOC_OUTPUT_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/cyber)

add_executable(CyberCmake main.cpp)
install(TARGETS CyberCmake
    RUNTIME
    DESTINATION bin)
add_subdirectory(cyber/base)
add_subdirectory(cyber/proto)
add_subdirectory(cyber/common)
