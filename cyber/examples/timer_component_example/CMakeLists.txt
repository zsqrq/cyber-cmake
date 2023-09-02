cyber_add_library(
    TARGET timer_component_example
    SOURCES timer_component_example.cc
    COMPONENT_NAME cyber_timer_component_example
    PUBLIC_LIBS cyber-cmake-core  
)

install(FILES timer.dag timer.launch
  DESTINATION share/examples/timer_component_example
)