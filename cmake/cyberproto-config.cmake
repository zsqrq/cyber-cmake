function(PROTOBUF_GENERATE_CPP SRC_DIR IMPORT_DIRS PROTO_FILES)
  set(PROTO_FILES ${PROTO_FILES})
  FOREACH(FIL ${PROTO_FILES})
    message("### generate proto file: ${FIL}")
    GET_FILENAME_COMPONENT(FIL_WE ${FIL} NAME_WE)
    string(REGEX REPLACE ".+/(.+)\\..*" "\\1" FILE_NAME ${FIL})
    string(REGEX REPLACE "(.+)\\${FILE_NAME}.*" "\\1" FILE_PATH ${FIL})
    EXECUTE_PROCESS(
        COMMAND
        protoc
        -I${IMPORT_DIRS}
        --cpp_out=${SRC_DIR}
        ${FIL}
        RESULT_VARIABLE PROTOC_RESULT
        OUTPUT_VARIABLE PROTOC_OUTPUT
        ERROR_VARIABLE PROTOC_ERROR
    )
    if(NOT ${PROTOC_RESULT} EQUAL "0")
      message(WARNING "protoc exit code: ${PROTOC_RESULT}")
      message(WARNING "protoc output: ${PROTOC_OUTPUT}")
      message(WARNING "protoc error: ${PROTOC_ERROR}")
    endif()
  ENDFOREACH()
endfunction()

function(get_all_proto_files)

endfunction()
