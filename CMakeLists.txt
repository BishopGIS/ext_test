cmake_minimum_required(VERSION 2.8.10 FATAL_ERROR)

project(test_remote)

set(APP_NAME "test_ext")

# some init settings
set(CMAKE_COLOR_MAKEFILE ON)
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Configs" FORCE)

set(BUILD_SHARED_LIBS ON)

# set path to additional CMake modules
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake ${CMAKE_MODULE_PATH})

message(STATUS "Test ExternalProject")

include(find_anyproject)

find_anyproject(ZLIB REQUIRED)

add_executable(${APP_NAME} main.cpp)

target_link_extlibraries(${APP_NAME})

