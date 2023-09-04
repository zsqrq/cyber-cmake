cmake_minimum_required(VERSION 3.16)
project(Cyber-Cmake VERSION 8.0
    DESCRIPTION "Pure Cmake Project For Apollo Cyber Rt")
set(CMAKE_CXX_STANDARD 14)
enable_language(ASM)

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
add_subdirectory(third_party)

list(APPEND CMAKE_FIND_ROOT_PATH ${CMAKE_SOURCE_DIR}/cmake)

find_package(CyberConfig REQUIRED)
get_sub_dirs(${CMAKE_SOURCE_DIR}/third_party/lib/cmake GOOGLE_FAMILY_SUB_DIR)
foreach(sub_dir ${GOOGLE_FAMILY_SUB_DIR})
    list(APPEND CMAKE_FIND_ROOT_PATH "GOOGLE_FAMILY_LIB_DIR/${sub_dir}")
endforeach()
get_sub_dirs(${CMAKE_SOURCE_DIR}/third_party/fast-rtps-1.5.0-1/lib RTPS_DIR)
foreach(sub_dir ${RTPS_DIR})
    list(APPEND CMAKE_FIND_ROOT_PATH "${FAST_RTPS_LIB_DIR}/${sub_dir}/cmake")
endforeach()

find_package(Threads REQUIRED)
find_package(PkgConfig REQUIRED)
find_package(Poco REQUIRED COMPONENTS Foundation)
find_package(glog REQUIRED)
find_package(Protobuf REQUIRED)
find_package(fastrtps REQUIRED)
find_package(fastcdr REQUIRED)

pkg_check_modules(Python REQUIRED python3)
pkg_check_modules(Uuid REQUIRED uuid)
pkg_check_modules(Gflags REQUIRED gflags)
pkg_check_modules(NlohmannJson REQUIRED nlohmann_json)

if(NOT DEFINED glog_LIBRARIES)
    set(glog_LIBRARIES "glog")
endif()

if(NOT DEFINED Uuid_LIBRARIES)
    set(Uuid_LIBRARIES "uuid")
endif()

set(CYBER_DEPENCENCY_INCLUDE_DIRS
    ${Protobuf_INCLUDE_DIRS}
    ${FAST_RTPS_INC_DIR}
    ${Python_INCLUDE_DIRS}
    ${Uuid_INCLUDE_DIRS}
    ${glog_INCLUDE_DIRS}
    ${Gflags_INCLUDE_DIRS}
    ${NlohmannJson_INCLUDE_DIRS}
    )
set(TARGET_NAME "CyberRt")
set(DEPENCENCY_LIB_DIRS
    ${Protobuf_LIBRARIES_DIRS}
    ${FAST_RTPS_LIB_DIR}
    ${Python_LIBRARIES_DIRS}
    ${Uuid_LIBRARIES_DIRS}
    ${glog_LIBRARY_DIRS}
    ${Gflags_LIBRARY_DIRS}
    ${NlohmannJson_LIBRARY_DIRS}
    )
set(DEPENCENCY_LIBS
    ${glog_LIBRARIES}
    ${Gflags_LIBRARIES}
    ${Protobuf_LIBRARIES}
    )

set(CYBER_SUB_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cyber CACHE INTERNAL "")
if(NOT CMAKE_BUILD_TYPE)
    set(DEFAULT_COMPILE -std=c++14 -latomic -fPIC)
else()
    # set(DEFAULT_COMPILE -std=c++17 -O3 -Wall -c -fmessage-length=0 -fPIC -fPIE -pie -fstack-protector-all -Wtrampolines)
endif()
add_link_options(-Wl,--disable-new-dtags)
set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib")

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
    ${CMAKE_CURRENT_SOURCE_DIR}/cyber
    ${CMAKE_SOURCE_DIR}/third_party/include
    ${FAST_RTPS_INC_DIR})

link_directories(
    ${DEPENCENCY_LIB_DIRS}
    ${FAST_RTPS_LIB_DIR}
    ${CMAKE_INSTALL_PREFIX}/lib
    ${CMAKE_SOURCE_DIR}/third_party/lib
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cyber
    DESTINATION include
    FILES_MATCHING PATTERN "*.h" PATTERN "*.hpp")
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/scripts/
    DESTINATION scripts)

get_sub_dirs(${CYBER_SUB_DIR} SUB_DIRS)
foreach(sub_dir ${SUB_DIRS})
    file(GLOB CMAKELIST_FILE "${CMAKE_CURRENT_SOURCE_DIR}/cyber/${sub_dir}/CMakeLists.txt")
    if (CMAKELIST_FILE)
        add_subdirectory(cyber/${sub_dir})
    endif ()
endforeach()

# Make Package#
include(CMakePackageConfigHelpers)
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/${TARGET_NAME}.pc.in"
    "${CMAKE_INSTALL_PREFIX}/lib/cmake/${TARGET_NAME}.pc" @ONLY)

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/${TARGET_NAME}-config.cmake.in"
    "${CMAKE_INSTALL_PREFIX}/lib/cmake/${TARGET_NAME}-config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake"
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
    PATH_VARS CMAKE_INSTALL_INCLUDEDIR CMAKE_INSTALL_LIBDIR TARGET_NAME
)

write_basic_package_version_file(${CMAKE_INSTALL_PREFIX}/lib/cmake/${TARGET_NAME}-config-version.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

cyber_add_library(
    TARGET cyber-cmake-binary
    SOURCES ${CMAKE_SOURCE_DIR}/cyber/binary.cc
    PUBLIC_LIBS cyber-cmake-proto cyber-cmake-common pthread atomic
)
cyber_add_library(
    TARGET cyber-cmake-state
    SOURCES ${CMAKE_SOURCE_DIR}/cyber/state.cc
    PUBLIC_LIBS cyber-cmake-binary cyber-cmake-time cyber-cmake-timer cyber-cmake-logger
)
cyber_add_library(
    TARGET cyber-cmake-init
    SOURCES ${CMAKE_SOURCE_DIR}/cyber/init.cc
    PUBLIC_LIBS cyber-cmake-state cyber-cmake-service-discovery cyber-cmake-sysmo cyber-cmake-task
        cyber-cmake-parameter
)
cyber_add_library(
    TARGET cyber-cmake-core
    SOURCES ${CMAKE_SOURCE_DIR}/cyber/cyber.cc
    PUBLIC_LIBS cyber-cmake-init cyber-cmake-component cyber-cmake-node cyber-cmake-transport
        cyber-cmake-classloader cyber-cmake-message cyber-cmake-logger cyber-cmake-record
)
