# Install script for directory: /home/wz/Desktop/playground/cyber-cmake/cyber/base

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/wz/Desktop/playground/cyber-cmake/build/x86/cyber")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/base" TYPE FILE FILES
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/atomic_hash_map.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/atomic_rw_lock.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/bounded_queue.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/concurrent_object_pool.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/for_each.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/macros.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/object_pool.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/reentrant_rw_lock.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/rw_lock_guard.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/signal.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/thread_pool.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/thread_safe_queue.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/unbounded_queue.h"
    "/home/wz/Desktop/playground/cyber-cmake/cyber/base/wait_strategy.h"
    )
endif()

