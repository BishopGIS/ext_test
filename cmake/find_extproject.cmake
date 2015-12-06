################################################################################
# Project:  external projects
# Purpose:  CMake build scripts
# Author:   Dmitry Baryshnikov, polimax@mail.ru
################################################################################
# Copyright (C) 2015, NextGIS <info@nextgis.com>
# Copyright (C) 2015 Dmitry Baryshnikov
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

    include(ExternalProject)

    set(ep_base "${CMAKE_BINARY_DIR}/third-party")
    set_property(DIRECTORY PROPERTY "EP_BASE" ${ep_base})
    set(EP_URL "https://github.com/nextgis-extra")
    
    # get some properties from <cmakemodules>/findext${name}.cmake file
    include(FindExt${name})
    
    ExternalProject_Add(${name}_EP
        GIT_REPOSITORY ${EP_URL}/${repo_name}
        INSTALL_COMMAND ""
    )
    
    if(BUILD_SHARED_LIBS)
        add_library(${name} SHARED IMPORTED GLOBAL)
    else()
        add_library(${name} STATIC IMPORTED GLOBAL)
    endif()
    
    add_dependencies(${name} ${name}_EP)  
    
    set(DEPENDENCY_LIB ${DEPENDENCY_LIB} ${name} PARENT_SCOPE)
    
# Edition 1   
    foreach( LIB_NAME ${repo_output} )
        set( TARGET_LINK_EXTLIB ${TARGET_LINK_EXTLIB} ${ep_base}/Build/${name}_EP/${LIB_NAME} )
    endforeach() 
    set(TARGET_LINK_LIB ${TARGET_LINK_LIB} ${TARGET_LINK_EXTLIB} PARENT_SCOPE)

# Edition 2
#    if(NOT EXISTS "${ep_base}/Build/${name}_EP/${repo_project}-exports.cmake")
#        execute_process(COMMAND git clone ${EP_URL}/${repo_name} ${name}_EP
#            WORKING_DIRECTORY  ${ep_base}/Source)
#    endif()
#      
#    execute_process(COMMAND ${CMAKE_COMMAND} ${ep_base}/Source/${name}_EP
#        WORKING_DIRECTORY ${ep_base}/Build/${name}_EP )
#          
#    include(${ep_base}/Build/${name}_EP/${repo_project}-exports.cmake)
#    
#    get_target_property(${name}_LIBLOC ${repo_project} IMPORTED_LOCATION_NOCONFIG)
#    
#    set(TARGET_LINK_LIB ${TARGET_LINK_LIB} ${${name}_LIBLOC} PARENT_SCOPE)

     
endfunction()
