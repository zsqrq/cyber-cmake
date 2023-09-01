cmake_minimum_required(VERSION 3.16)
project(mainboard)

link_directories(
    ${DEPENCENCY_LIB_DIRS}
    ${CMAKE_INSTALL_PREFIX}/lib
    ${FAST_RTPS_LIB_DIR}
    ${CMAKE_SOURCE_DIR}/third_party/lib
)

add_executable(mainboard
    mainboard.cc
    module_argument.cc
    module_controller.cc
    )
target_link_directories(mainboard
    PRIVATE ${DEPENCENCY_LIB_DIRS}
    PRIVATE ${CMAKE_INSTALL_PREFIX}/lib
    PRIVATE ${FAST_RTPS_LIB_DIR}
    PRIVATE ${CMAKE_SOURCE_DIR}/third_party/lib
    )
target_include_directories(mainboard
    PRIVATE ${FAST_RTPS_INC_DIR}
)
target_link_libraries(mainboard
    ${DEPENCENCY_LIBS} pthread cyber-cmake-common cyber-cmake-binary
    cyber-cmake-init cyber-cmake-state cyber-cmake-component cyber-cmake-proto
    cyber-cmake-classloader cyber-cmake-node cyber-cmake-message cyber-cmake-transport
    cyber-cmake-logger fastrtps fastcdr protobuf
    pthread
)
