cmake_minimum_required(VERSION 3.16)
project(Cyber-Cmake)
set(CMAKE_CXX_STANDARD 17)

list(APPEND CMAKE_FIND_ROOT_PATH ${CMAKE_SOURCE_DIR}/cmake)

find_package(CyberConfig REQUIRED)
find_package(Threads REQUIRED)
find_package(PkgConfig REQUIRED)
find_package(Poco REQUIRED COMPONENTS Foundation)
find_package(glog REQUIRED)
find_package(Protobuf REQUIRED)
pkg_check_modules(Python REQUIRED python3)
pkg_check_modules(Uuid REQUIRED uuid)
pkg_check_modules(Gflags REQUIRED gflags)
pkg_check_modules(NlohmannJson REQUIRED nlohmann_json)

message(WARNING "fastrtps include dir is ：： ${fastrtps_INCLUDE_DIR}")

set(CYBER_DEPENCENCY_INCLUDE_DIRS
    ${fastcdr_INCLUDE_DIR}
    ${fastrtps_INCLUDE_DIR}
    ${Protobuf_INCLUDE_DIRS}
    ${Python_INCLUDE_DIRS}
    ${Uuid_INCLUDE_DIRS}
    ${glog_INCLUDE_DIRS}
    ${Gflags_INCLUDE_DIRS}
    ${NlohmannJson_INCLUDE_DIRS}
    )

set(DEPENCENCY_LIB_DIRS
    ${fastcdr_LIB_DIR}
    ${fastrtps_LIB_DIR}
    ${Protobuf_LIBRARIES_DIRS}
    ${Python_LIBRARIES_DIRS}
    ${Uuid_LIBRARIES_DIRS}
    ${glog_LIBRARY_DIRS}
    ${Gflags_LIBRARY_DIRS}
    ${NlohmannJson_LIBRARY_DIRS}
    )
set(DEPENCENCY_LIBS
    ${glog_LIBRARIES}
    ${Gflags_LIBRARIES}
    )

if(NOT CMAKE_BUILD_TYPE)
    set(DEF Debug)
    set(DEFAULT_COMPILE -std=c++17 -O0 -g3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
else()
    set(DEFAULT_COMPILE -std=c++17 -O3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
endif()
add_link_options(-Wl,--disable-new-dtags)
set(CMAKE_INSTALL_RPATH "$ORIGIN/..lib")

if(DEFINED ENABLE_DOCMENTATION)
    generate_doc_file()
endif()

include_directories(
    ${CMAKE_INSTALL_PREFIX}
    ${CMAKE_BINARY_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
    ${CYBER_PROTOC_OUTPUT_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CYBER_DEPENCENCY_INCLUDE_DIRS}
    ${CMAKE_CURRENT_SOURCE_DIR}/cyber)
link_directories(${DEPENCENCY_LIB_DIRS})

add_executable(CyberCmake main.cpp)
install(TARGETS CyberCmake
    RUNTIME
    DESTINATION bin)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cyber
    DESTINATION include
    FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp")
GET_SUBDIRS(CYBER_SUB_DIRS ${CMAKE_CURRENT_SOURCE_DIR}/cyber)
foreach(sub_dir ${CYBER_SUB_DIRS})
    file(GLOB CMAKELIST_FILE "${CMAKE_CURRENT_SOURCE_DIR}/cyber/${sub_dir}/CMakeLists.txt")
    if (CMAKELIST_FILE)
        add_subdirectory(cyber/${sub_dir})
    endif ()
endforeach()

