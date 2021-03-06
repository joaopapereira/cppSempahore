CMAKE_MINIMUM_REQUIRED(VERSION 2.6)
#####################################
## Option part
#####################################
option(semaphore_build_samples "Build semaphore sample programs." OFF)
option(compile_with_debug "Build library with debug." OFF)

#####################################
## Definition of environment
#####################################
IF( DEFINED ENV{INSTALL_LIB_DIR} )
   SET(INSTALL_LIBS $ENV{INSTALL_LIB_DIR}/ )
ELSE()
   SET(INSTALL_LIBS ${CMAKE_HOME_DIRECTORY}/lib )
ENDIF()
IF( DEFINED ENV{INSTALL_INC_DIR} )
   SET(INSTALL_INCS $ENV{INSTALL_INC_DIR}/ )
ELSE()
   SET(INSTALL_INCS ${CMAKE_HOME_DIRECTORY}/include )
ENDIF()

IF( EXISTS ${INSTALL_LIBS}/libJPSemaphores.so )
	return()
ENDIF()


SET(LIBRARY_OUTPUT_PATH .)
SET(EXECUTABLE_OUTPUT_PATH .)

#####################################
## Project name
#####################################
PROJECT(Semaphores)

#####################################
## Include directories 
#####################################
INCLUDE_DIRECTORIES( include lib ${INSTALL_LIBS} ${INSTALL_INCS})

#####################################
## Folders to be build
#####################################
ADD_SUBDIRECTORY( src lib )
#ADD_SUBDIRECTORY( exampleProgram bin )
#####################################
## Samples to be build
#####################################
if( semaphore_build_samples)
	ADD_SUBDIRECTORY( exampleProgram bin )
endif()
#####################################
# Search for needed lib
#####################################
FIND_LIBRARY( CPPJPLOGGER_LIB NAMES logger
		PATHS ${LOCAL_LIBS} ${INSTALL_LIBS} )

find_library(logger REQUIRED)
include_directories(${logger_INCLUDE_DIRS})

#####################################
# Instalation section
#####################################
INSTALL( FILES include/libJPSemaphores.hpp
         DESTINATION ${INSTALL_INCS} )

INSTALL( FILES lib/libJPSemaphoresStatic.a
         DESTINATION ${INSTALL_LIBS} )
INSTALL( FILES lib/libJPSemaphores.so
         DESTINATION ${INSTALL_LIBS} )

#####################################
# Others
#####################################
IF( UNIX )
   ADD_CUSTOM_TARGET( distclean @@echo cleaning for source distribution)
  SET(DISTCLEANED
   cmake.depends
   cmake.check_depends
   CMakeCache.txt
   cmake.check_cache
   Makefile
   core core.*
   gmon.out
   *~
   lib
   CMakeFiles
   bin
   install_*
   cmake_install.cmake 
   doc/docs/
   doc/semaphore.dox
  )
  
  ADD_CUSTOM_COMMAND(
    DEPENDS clean
    COMMENT "distribution clean"
    COMMAND rm
    ARGS    -Rf CMakeTmp ${DISTCLEANED}
    TARGET  distclean
  )

ENDIF( UNIX )
if( compile_with_debug )
	set(CMAKE_CXX_FLAGS "-DDEBUG=1")
	set(CMAKE_BUILD_TYPE Debug)
endif()

#####################################
# add a target to generate API documentation with Doxygen
#####################################
find_package(Doxygen)
if(DOXYGEN_FOUND)
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/doc/semaphore.dox.in ${CMAKE_CURRENT_BINARY_DIR}/doc/semaphore.dox @ONLY)
	add_custom_target(docs
			${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/doc/semaphore.dox
			WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
			COMMENT "Generating Semaphore documentation with Doxygen" VERBATIM
)
endif(DOXYGEN_FOUND)
