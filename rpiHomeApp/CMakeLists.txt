##############################################
#CMake config file for rpiHome application 
#@Paku 2015
##############################################
cmake_minimum_required (VERSION 2.6)

project (rpiHome)

set (rpiHome_VERSION_MAJOR 0)
set (rpiHome_VERSION_MINOR 1)
##############################################

if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    # require at least gcc 4.7.2
    if (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.7.2)
        message(FATAL_ERROR "GCC version must be at least 4.7.2!")
    endif()
else()
    message(WARNING "You are using an unsupported compiler! Compilation has only been tested with GCC ver.4.7.2.")
endif()
 
##############################################

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")

#INCLUDE(Findmysqlclient)
INCLUDE(Findmysqlconnectorcpp)
INCLUDE(FindwiringPi)
#INCLUDE(ShowConfig)

#find_package(mysqlclient REQUIRED)
find_package(mysqlconnectorcpp REQUIRED)
find_package(wiringPi REQUIRED)


set(Boost_USE_STATIC_LIBS OFF) 
set(Boost_USE_MULTITHREADED ON)  
set(Boost_USE_STATIC_RUNTIME OFF) 
find_package(Boost 1.49.0 COMPONENTS program_options REQUIRED) 
 
##############################################

SET(GCC_COVERAGE_COMPILE_FLAGS "-Os -std=c++11")
#SET(GCC_COVERAGE_COMPILE_FLAGS "-std=c++11")
SET(GCC_COVERAGE_LINK_FLAGS    "")

SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}" )
SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}" )

##############################################

include_directories("${PROJECT_BINARY_DIR}")
#include_directories("${MYSQL_INCLUDE_DIR}")
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

##############################################
# CMake config ENDs here.
##############################################
# Trash below !!!
##############################################

#add_executable(daemon ${PROJECT_SOURCE_DIR}/source/tests/daemon/daemon.c)

#add_executable(blink ${PROJECT_SOURCE_DIR}/source/tests/wiringPi/blink.c)
#target_link_libraries(blink ${WIRINGPI_LIBRARIES} )

#add_executable(mysqlclient_test ${PROJECT_SOURCE_DIR}/source/tests/mySQL/mysqlclient_test.c)
#target_link_libraries( mysqlclient_test ${MYSQL_LIBRARIES} )


#configure_file (
#  "${PROJECT_SOURCE_DIR}/rpiHome.h.in"
#  "${PROJECT_BINARY_DIR}/rpiHomeApp.h"	
#  )



#install (FILES rpiHomeSQLDaemon.h DESTINATION include)  
#install (TARGETS rpiHomesqldaemon DESTINATION bin)


#find_package( libmysqlclient )
# Check if the library was found
#if ( libmysqlclient_FOUND )
# Set the path to the header files
#    include_directories( ${libmysqlclient_INCLUDE_DIRS} )
#  Link the library to the project
#    target_link_libraries( <TARGET> ${libmysqlclient_LIBRARIES} )
#endif()



#SET(GCC_COVERAGE_COMPILE_FLAGS "$(mysql_config --cflags)")
#SET(GCC_COVERAGE_LINK_FLAGS    "-lwiringPi $(mysql_config --libs)")
# FULL >>> SET(GCC_COVERAGE_LINK_FLAGS    "-lwiringPi -L/usr/lib/arm-linux-gnueabihf -lmysqld -lpthread -lz -lm -lrt -lwrap -lcrypt -ldl -laio")
#SET(GCC_COVERAGE_LINK_FLAGS    "-lwiringPi -L/usr/lib/arm-linux-gnueabihf -lpthread -lz -lm -lrt -lcrypt -ldl ")
#SET(GCC_COVERAGE_COMPILE_FLAGS "-I/usr/include/mysql")



#FIND_LIBRARY(XXX_LIBRARY XXX
#    PATHS @CMAKE_INSTALL_PREFIX@/lib
#    NO_DEFAULT_PATH
#)
#SET(XXX_LIBRARIES ${XXX_LIBRARY})
#FIND_PATH(XXX_INCLUDE_DIR XXX.h
#    PATHS @CMAKE_INSTALL_PREFIX@/include
#    NO_DEFAULT_PATH
#)
#SET(XXX_INCLUDE_DIRS ${XXX_INCLUDE_DIR})
#SET(XXX_DEFINITIONS ...)
## XXX_FOUND is set to "1" by FIND_PACKAGE()






