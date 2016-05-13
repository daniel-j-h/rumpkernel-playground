cmake_minimum_required(VERSION 3.1 FATAL_ERROR)
project(app VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -fno-exceptions")

add_executable(${PROJECT_NAME} ${PROJECT_NAME}.cc)
