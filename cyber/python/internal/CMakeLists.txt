set(Python_VERSION "${Python_VERSION}")
set(CYBER_PYTHON_PATH "lib/python${Python_VERSION}/site-packages/cyber/python")
set(CYBER_PYTHON_INTERNAL_PATH "${CYBER_PYTHON_PATH}/internal")

add_library(_cyber-cmake-wrapper SHARED 
  py_cyber.cc
)
target_link_libraries(_cyber-cmake-wrapper
    PUBLIC cyber-cmake-core 
    PUBLIC ${Python_LIBRARIES}
)
add_library(py_cyber ALIAS _cyber-cmake-wrapper)

add_library(_cyber-cmake-record-wrapper SHARED 
  py_record.cc
)
target_link_libraries(_cyber-cmake-record-wrapper
    PUBLIC cyber-cmake-core 
    PUBLIC ${Python_LIBRARIES}
)
add_library(py_record ALIAS _cyber-cmake-record-wrapper)

add_library(_cyber-cmake-time-wrapper SHARED
  py_time.cc
)
target_link_libraries(_cyber-cmake-time-wrapper
    PUBLIC cyber-cmake-core 
    PUBLIC ${Python_LIBRARIES}
)
add_library(py_time ALIAS _cyber-cmake-time-wrapper)

add_library(_cyber-cmake-parameter-wrapper SHARED 
  py_parameter.cc
)
target_link_libraries(_cyber-cmake-parameter-wrapper
    PUBLIC cyber-cmake-core 
    PUBLIC ${Python_LIBRARIES}
)
add_library(py_parameter ALIAS _cyber-cmake-parameter-wrapper)

install(TARGETS
    _cyber-cmake-wrapper
    _cyber-cmake-record-wrapper
    _cyber-cmake-time-wrapper
    _cyber-cmake-parameter-wrapper
  DESTINATION ${CYBER_PYTHON_INTERNAL_PATH}
)