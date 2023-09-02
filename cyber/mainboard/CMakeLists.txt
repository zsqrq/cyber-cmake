cmake_minimum_required(VERSION 3.16)
project(mainboard)

file(GLOB CYBER_MAINBOARD_SRCS "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")

cyber_add_excutable(
    TARGET ${PROJECT_NAME}
    SOURCES ${CYBER_MAINBOARD_SRCS}
    PUBLIC_LIBS cyber-cmake-core  
)
