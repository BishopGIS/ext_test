################################################################################
# Project:  external projects
# Purpose:  CMake build scripts
# Author:   Dmitry Baryshnikov, polimax@mail.ru
################################################################################
# Copyright (C) 2015, NextGIS <info@nextgis.com>
# Copyright (C) 2015, Dmitry Baryshnikov
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
################################################################################

function(find_extproject name)
    # get some properties from <cmakemodules>/findext${name}.cmake file
    include(FindExt${name})
    
    set(EP_BASE "${CMAKE_BINARY_DIR}/third-party")
    set(EP_URL "https://github.com/nextgis-extra")
    
    include(ExternalProject)
    set_property(DIRECTORY PROPERTY "EP_BASE" ${EP_BASE})
    
    ExternalProject_Add(${name}_EP
        GIT_REPOSITORY ${EP_URL}/${repo_name}
        CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
        CMAKE_CACHE_DEFAULT_ARGS -DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
    )
   
    if(NOT EXISTS "${EP_BASE}/Build/${name}_EP/${repo_project}-exports.cmake")
        find_package(Git)
        if(NOT GIT_FOUND)
          message(FATAL_ERROR "git is required")
          return()
        endif()
        execute_process(COMMAND ${GIT_EXECUTABLE} clone ${EP_URL}/${repo_name} ${name}_EP
           WORKING_DIRECTORY  ${EP_BASE}/Source)
    endif()
     
    execute_process(COMMAND ${CMAKE_COMMAND} ${EP_BASE}/Source/${name}_EP
       "-DCMAKE_INSTALL_PREFIX=${EP_BASE}/Install/${name}_EP"
       WORKING_DIRECTORY ${EP_BASE}/Build/${name}_EP )

         
    include(${EP_BASE}/Build/${name}_EP/${repo_project}-exports.cmake)  

    add_dependencies(${repo_project} ${name}_EP)  
    
    set(DEPENDENCY_LIB ${DEPENDENCY_LIB} ${repo_project} PARENT_SCOPE)   
    set(TARGET_LINK_LIB ${TARGET_LINK_LIB} ${repo_project} PARENT_SCOPE)
    
    include_directories(${EP_BASE}/Build/${name}_EP ${EP_BASE}/Source/${name}_EP)
    
    install( DIRECTORY ${EP_BASE}/Install/${name}_EP/ DESTINATION ${CMAKE_INSTALL_PREFIX} )
    
endfunction()
