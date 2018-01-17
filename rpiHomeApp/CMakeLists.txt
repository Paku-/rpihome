##############################################
#CMake config file for rpiHome application 
#@Paku 2015
##############################################
cmake_minimum_required (VERSION 2.8)

project (rpiHome CXX)
set (rpiHome_VERSION_MAJOR 0)
set (rpiHome_VERSION_MINOR 1)
##############################################
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")
INCLUDE(GetCompilerVersion)

#CMake builds < 2.8.9 do not set  CMAKE_CXX_COMPILER_VERSION !!
if(CMAKE_CXX_COMPILER_VERSION)

	if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		# require at least gcc 4.7
		if (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.7)
			message(FATAL_ERROR "GCC version must be at least 4.7!")				
		endif()
	else()
		message(WARNING "You are using an unsupported compiler! Compilation has only been tested with GCC ver.4.7.2")
	endif()

endif(CMAKE_CXX_COMPILER_VERSION)

# the compiler used for C files 
#message( STATUS "CMAKE_C_COMPILER: " ${CMAKE_C_COMPILER} )
# the compiler used for C++ files 
message( STATUS "CMAKE_CXX_COMPILER: " ${CMAKE_CXX_COMPILER} )			
# the C++ compiler version 
message( STATUS "CMAKE_CXX_COMPILER_VERSION: " ${CMAKE_CXX_COMPILER_VERSION} )			
 
##############################################

#INCLUDE(Findmysqlclient)
INCLUDE(Findmysqlconnectorcpp)
INCLUDE(FindwiringPi)
#INCLUDE(ShowConfig)

##############################################

#find_package(mysqlclient REQUIRED)
find_package(mysqlconnectorcpp REQUIRED)
find_package(wiringPi REQUIRED)

##############################################

set(Boost_USE_STATIC_LIBS OFF) 
set(Boost_USE_MULTITHREADED ON)  
set(Boost_USE_STATIC_RUNTIME OFF) 
#find_package(Boost 1.49.0 COMPONENTS program_options REQUIRED) 
find_package(Boost 1.46.0 COMPONENTS program_options REQUIRED) 
 
##############################################

SET(GCC_COVERAGE_COMPILE_FLAGS "-Os -std=c++11")
SET(GCC_COVERAGE_LINK_FLAGS    "-lcrypt")

SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}" )
SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}" )

##############################################

include_directories("${PROJECT_BINARY_DIR}")
include_directories("${MYSQLCONNECTORCPP_INCLUDE_DIRS}")
include_directories("${WIRINGPI_INCLUDE_DIRS}")

##############################################

add_library(rpiHomeLib ${PROJECT_SOURCE_DIR}/source/rpiHomeApp/rpiHome.cpp)

if(Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIRS}) 
    add_executable(rpiHomeApp ${PROJECT_SOURCE_DIR}/source/rpiHomeApp/rpiHomeApp.cpp) 
    #target_link_libraries(rpiHomeApp rpiHomeLib ${WIRINGPI_LIBRARIES} ${MYSQL_LIBRARIES} ${Boost_LIBRARIES})
    target_link_libraries(rpiHomeApp rpiHomeLib ${WIRINGPI_LIBRARIES} ${MYSQLCONNECTORCPP_LIBRARIES} ${Boost_LIBRARIES})
endif()












