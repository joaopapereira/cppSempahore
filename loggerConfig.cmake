# find JPLoggerStatic

IF(NOT(JPLoggerStatic_LIBRARY AND JPLoggerStatic_INCLUDE_DIR))
	# search for include and library path
	FIND_PATH(JPLoggerStatic_INCLUDE_DIR  libJPLogger.hpp PATHS ${INSTALL_INCS} )
	FIND_LIBRARY(JPLoggerStatic_LIBRARY JPLoggerStatic PATHS ${INSTALL_LIBS} )

	IF(JPLoggerStatic_INCLUDE_DIR AND JPLoggerStatic_LIBRARY)
		SET(JPLoggerStatic_FOUND TRUE)
		MESSAGE(STATUS "Found JPLoggerStatic: ${JPLoggerStatic_LIBRARY}")

	ELSE(JPLoggerStatic_INCLUDE_DIR AND JPLoggerStatic_LIBRARY)
		SET(JPLoggerStatic_FOUND FALSE)
		MESSAGE(SEND_ERROR "Could NOT find JPLoggerStatic")
	ENDIF(JPLoggerStatic_INCLUDE_DIR AND JPLoggerStatic_LIBRARY)
ENDIF( NOT ( JPLoggerStatic_LIBRARY AND JPLoggerStatic_INCLUDE_DIR) )
