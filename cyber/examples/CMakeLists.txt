cmake_minimum_required(VERSION 3.16)
project(example)

cyber_add_excutable(
    TARGET eyber_example_talker
    SOURCES talker.cc
    PUBLIC_LIBS cyber-cmake-core
    INSTALL_PATH bin/cyber/examples
)
cyber_add_excutable(
    TARGET cyber_example_listener
    SOURCES listener.cc
    PUBLIC_LIBS cyber-cmake-core  
    INSTALL_PATH bin/cyber/examples
)
cyber_add_excutable(
    TARGET cyber_example_paramserver
    SOURCES paramserver.cc
    PUBLIC_LIBS cyber-cmake-core  
    INSTALL_PATH bin/cyber/examples
)
cyber_add_excutable(
    TARGET cyber_example_record
    SOURCES record.cc
    PUBLIC_LIBS cyber-cmake-core  
    INSTALL_PATH bin/cyber/examples
)
cyber_add_excutable(
    TARGET cyber_example_service
    SOURCES service.cc
    PUBLIC_LIBS cyber-cmake-core  
    INSTALL_PATH bin/cyber/examples
)
add_subdirectory(common_component_example)
add_subdirectory(timer_component_example)
