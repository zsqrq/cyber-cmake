set(ENABLE_TEST OFF)
include(GNUInstallDirs)
include(${CMAKE_SOURCE_DIR}/cmake/cyber-tool.cmake)
include(${CMAKE_SOURCE_DIR}/cmake/cyberproto-config.cmake)
set(AUTHOR_KEY "ENABLE_DOCMENTATION")
set(FAST_RTPS_INC_DIR ${CMAKE_SOURCE_DIR}/third_party/fast-rtps-1.5.0-1/include CACHE INTERNAL "")
set(FAST_RTPS_LIB_DIR ${CMAKE_SOURCE_DIR}/third_party/fast-rtps-1.5.0-1/lib CACHE INTERNAL "")
set(GOOGLE_FAMILY_LIB_DIR ${CMAKE_SOURCE_DIR}/third_party/lib/cmake CACHE INTERNAL "")

if(COMPILE_PLATFOM STREQUAL "x86")
  set(CONFIG_FILE_NAME "cyber_config.json")
  set(CONFIG_FILE ${CMAKE_SOURCE_DIR}/configuration/${CONFIG_FILE_NAME})
  configure_file(${CONFIG_FILE} ${CONFIG_FILE_NAME} COPYONLY)
  file(READ ${CMAKE_BINARY_DIR}/${CONFIG_FILE_NAME} CONFIG_CONTENT)

  string(REGEX REPLACE "\\s*{(.*)}\\s*" "\\1" CONFIG_CONTENT ${CONFIG_CONTENT})
  string(REGEX REPLACE "," ";" CONFIG_CONTENT_LINES ${CONFIG_CONTENT})

  foreach(LINE ${CONFIG_CONTENT_LINES})
    string(REGEX REPLACE "\"([^\"]+)\"\\s*:\\s*([^\"]+)\\s*" "\\1;\\2" KEY_VALUE_PAIR ${LINE})
    list(GET KEY_VALUE_PAIR 1 VALUE)
    list(GET KEY_VALUE_PAIR 0 KEY)

    if (${VALUE} STREQUAL "true")
      add_definitions(-D${KEY})
      string(FIND "${KEY_VALUE_PAIR}" "ENABLE_DOCMENTATION" FOUND_INDEX)
      string(FIND "${LINE}" "ENABLE_PROTO_GENERATE" FOUND_PROTO_INDEX)
      if(${FOUND_INDEX} GREATER_EQUAL 0)
        set(ENABLE_DOCMENTATION ${KEY} CACHE INTERNAL " ")
      endif()
      if(${FOUND_PROTO_INDEX} GREATER_EQUAL 0)
        set(ENABLE_PROTO_GENERATE ${KEY} CACHE INTERNAL " ")
      endif()
    endif ()
  endforeach()

  find_package(Git)
  if(GIT_FOUND)
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE CYBERCMAKE_GIT_COMMIT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  else()
    message(WARNING "Git Not Found, Can Not Record Compile Log")
  endif()

  add_custom_target(mark_built_time ALL)
  set(COMLOG_OUTPUT_DIR "${CMAKE_SOURCE_DIR}/log")
  set(COMLOG_OUTPUT_FILE "compile_log.txt")
  set(INCLUDE_DIR_TO_REMOVE "${CMAKE_INSTALL_PREFIX}/include")

  add_custom_command(TARGET mark_built_time PRE_BUILD
      COMMAND ${CMAKE_COMMAND} -E make_directory ${COMLOG_OUTPUT_DIR}
      COMMENT "Output Compiling Log Dir Already Exits"
      )
  add_custom_command(TARGET mark_built_time POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E echo "Built Completed at: 'date', Git Commit Version is:${CYBERCMAKE_GIT_COMMIT}" >> ${COMLOG_OUTPUT_DIR}/${COMLOG_OUTPUT_FILE}
      COMMENT "Writting Compile Complete time to compile_log file"
      )
  add_custom_command(TARGET mark_built_time POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E remove_directory ${INCLUDE_DIR_TO_REMOVE}
      COMMENT "Remove Unused include dir"
      )
  install(DIRECTORY ${COMLOG_OUTPUT_DIR}/ DESTINATION log)
  return()
endif()
