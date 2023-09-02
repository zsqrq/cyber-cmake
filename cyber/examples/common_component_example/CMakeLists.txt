cmake_minimum_required(VERSION 3.16)

cyber_add_excutable(
    TARGET channel_test_writer
    SOURCES channel_test_writer.cc
    PUBLIC_LIBS cyber-cmake-core  
)
cyber_add_excutable(
    TARGET channel_prediction_writer
    SOURCES channel_prediction_writer.cc
    PUBLIC_LIBS cyber-cmake-core  
)

cyber_add_library(
    TARGET common_component_example
    SOURCES common_component_example.cc
    COMPONENT_NAME cyber_common_component_example
    PUBLIC_LIBS cyber-cmake-core  
)


install(FILES common.dag common.launch
  DESTINATION share/examples/common_component_example
)
