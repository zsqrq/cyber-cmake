cmake_minimum_required(VERSION 3.16)

project(Cyber-Cmake)

find_package(CyberConfig REQUIRED)
find_package(Threads REQUIRED)
find_package(PkgConfig REQUIRED)
find_package(fastrtps REQUIRED)
find_package(fastcdr REQUIRED)
find_package(Poco REQUIRED COMPONENTS Foundation)
find_package(glog REQUIRED)
find_package(Protobuf REQUIRED)

pkg_check_modules(Python REQUIRED python3)
pkg_check_modules(Uuid REQUIRED uuid)
pkg_check_modules(Gflags REQUIRED gflags)
pkg_check_modules(NlohmannJson REQUIRED nlohmann_json)

set(CMAKE_CXX_STANDARD 17)
set(CYBER_DOCS_TARGET_SRC ${CMAKE_SOURCE_DIR}/cyber CACHE INTERNAL "For Document Generation")
set(CYBER_PROTOC_IMPORT_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/cyber/proto)
set(CYBER_PROTOC_OUTPUT_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/cyber/proto)


if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
    set(DEFAULT_COMPILE -std=c++17 -O0 -g3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
else()
    set(DEFAULT_COMPILE -std=c++17 -O3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
endif()

if(DEFINED ENABLE_DOCMENTATION)
    generate_doc_file()
endif()

file(GLOB PROTO_FILES "${CMAKE_CURRENT_SOURCE_DIR}/cyber/proto/*.proto")
PROTOBUF_GENERATE_CPP(${CYBER_PROTOC_IMPORT_DIRS} ${PROTO_FILES})

include_directories(${CYBER_PROTOC_OUTPUT_DIRS} ${CMAKE_CURRENT_SOURCE_DIR}/cyber)

add_executable(CyberCmake main.cpp)
install(TARGETS CyberCmake
    RUNTIME
    DESTINATION bin)
add_subdirectory(cyber/base)
add_subdirectory(cyber/proto)
