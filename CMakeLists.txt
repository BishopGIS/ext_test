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
find_anyproject(CURL REQUIRED CMAKE_ARGS
      -DBUILD_CURL_EXE=OFF
      -DCURL_DISABLE_FTP=ON
      -DCURL_DISABLE_LDAP=ON
      -DCURL_DISABLE_TELNET=ON
      -DCURL_DISABLE_DICT=ON
      -DCURL_DISABLE_FILE=ON
      -DCURL_DISABLE_TFTP=ON
      -DCURL_DISABLE_LDAPS=ON
      -DCURL_DISABLE_RTSP=ON
      -DCURL_DISABLE_PROXY=ON
      -DCURL_DISABLE_POP3=ON
      -DCURL_DISABLE_IMAP=ON
      -DCURL_DISABLE_SMTP=ON
      -DCURL_DISABLE_GOPHER=ON
      -DCURL_DISABLE_CRYPTO_AUTH=OFF
      -DENABLE_IPV6=OFF
      -DENABLE_MANUAL=OFF
      -DCMAKE_USE_OPENSSL=OFF
      -DCMAKE_USE_LIBSSH2=OFF)


add_executable(${APP_NAME} main.cpp)

target_link_extlibraries(${APP_NAME})

install(TARGETS ${APP_NAME}
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

