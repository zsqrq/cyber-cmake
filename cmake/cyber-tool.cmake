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
    install(${CYBER_TARGET}
        LIBRARY
        DESTINATION lib
        COMPONENT ${CYBER_COMPONENT_NAME}
        )
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