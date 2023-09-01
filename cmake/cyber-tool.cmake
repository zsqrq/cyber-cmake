macro(cyber_add_library)
    set(switches USE_C_LANGUAGE NO_EXPORT NO_PACKAGE_SETUP NO_FIND_PACKAGE_SUPPORT STATIC)
    set(arguments TARGET NAMESPACE PROJECT_PREFIX)
    set(multiarguments SOURCES COMPONENT_NAME PUBLIC_LIBS PRIVATE_LIBS BUILD_INTERFACE
        INSTALL_INTERFACE ADDTIONAL_EXPORT_TARGETS TARGET_PUBLIC_INCLUDE_DIRS TARGET_PRIVATE_INCLUDE_DIRS
        PUBLIC_LIBS_LINUX PRIVATE_LIBS_LINUX)
    cmake_parse_arguments(
        CYBER
        "${switches}"
        "${arguments}"
        "${multiarguments}"
        ${ARGN}
    )
    if (CYBER_STATIC)
        add_library(${CYBER_TARGET} STATIC ${CYBER_SOURCES})
    else()
        add_library(${CYBER_TARGET} SHARED ${CYBER_SOURCES})
    endif ()

    if (CYBER_TARGET_PUBLIC_INCLUDE_DIRS)
        target_include_directories(${CYBER_TARGET} PUBLIC ${CYBER_TARGET_PUBLIC_INCLUDE_DIRS})
    endif ()

    if (CYBER_TARGET_PUBLIC_PRIVATE_DIRS)
        target_include_directories(${CYBER_TARGET} PRIVATE ${CYBER_TARGET_PRIVATE_INCLUDE_DIRS})
    endif ()

    target_include_directories(${CYBER_TARGET}
        PRIVATE ${CMAKE_INSTALL_PREFIX}/include
        )
    if (${CYBER_PUBLIC_LIBS})
        target_link_libraries(${CYBER_TARGET}
            PUBLIC ${CYBER_PUBLIC_LIBS}
            )
    endif ()

    if (${CYBER_PRIVATE_LIBS})
        target_link_libraries(${CYBER_TARGET}
            PRIVATE ${CYBER_PRIVATE_LIBS}
            )
    endif ()
    target_precompile_headers(${CYBER_TARGET}
        PUBLIC ${CYBER_PRECORE_HEADERS}
        )
    install(TARGETS ${CYBER_TARGET}
        LIBRARY
        DESTINATION lib
        COMPONENT ${CYBER_COMPONENT_NAME})
endmacro()

macro(any_add_library)
    cyber_add_library(${ARGN})
endmacro()

macro(GET_SUBDIRS RESULT CURDIR)
    file(GLOB children PRIVATE ${CURDIR} ${CURDIR}/*)
    set(dirlist "")
    foreach(child children)
        if (IS_DIRECTORY ${CURDIR}/${child})
            if (NOT ${child} STREQUAL "build")
                LIST(APPEND dirlist ${child})
            endif ()
        endif ()
    endforeach()
    set(RESULT ${dirlist})
endmacro()

macro(cyber_add_header_lib)
    set(switches USE_C_LANGUAGE NO_EXPORT NO_PACKAGE_SETUP NO_FIND_PACKAGE_SUPPORT)
    set(arguments TARGET NAMESPACE PROJECT_PREFIX)
    set(multiarguments SOURCES COMPONENT_NAME PUBLIC_LIBS PRIVATE_LIBS BUILD_INTERFACE
        INSTALL_INTERFACE ADDTIONAL_EXPORT_TARGETS TARGET_PUBLIC_INCLUDE_DIRS TARGET_PRIVATE_INCLUDE_DIRS
        PUBLIC_LIBS_LINUX PRIVATE_LIBS_LINUX)
    cmake_parse_arguments(
        CYBER
        "${switches}"
        "${arguments}"
        "${multiarguments}"
        ${ARGN}
    )

    add_library(${CYBER_TARGET} INTERFACE)

    target_sources(${CYBER_TARGET} INTERFACE
        ${CYBER_SOURCES}
        )

endmacro()

macro(generate_doc_file)
    find_package(Doxygen REQUIRED)
    if (DOXYGEN_FOUND)
        set(DOXYGEN_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/docs")
        set(DOXYGEN_GENERATE_HTML YES)
        set(DOXYGEN_GENERATE_MAN YES)
        set(DOXYGEN_MARKDOWN_SUPPORT YES)
        set(DOXYGEN_AUTOLINK_SUPPORT YES)
        set(DOXYGEN_HAVE_DOT YES)
        set(DOXYGEN_COLLABORATION_GRAPH YES)
        set(DOXYGEN_CLASS_GRAPH YES)
        set(DOXYGEN_UML_LOOK YES)
        set(DOXYGEN_DOT_UML_DETAILS YES)
        set(DOXYGEN_DOT_WRAP_THRESHOLD 100)
        set(DOXYGEN_CALL_GRAPH YES)
        set(DOXYGEN_QUIRT YES)
        doxygen_add_docs(
            cyber_docs
            ${CYBER_DOCS_TARGET_SRC}
            ALL
            COMMENT "Generation Documentation For Cybertron"
        )
    else()
        message(WARNING "Doxygen tools Not Found, Can Not Generate Document Files")
    endif ()

endmacro()