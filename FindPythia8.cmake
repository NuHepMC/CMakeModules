include(CMessage)

set(Pythia8_FOUND TRUE)
if(NOT TARGET Pythia8::Pythia8)

  EnsureVarOrEnvSet(PYTHIA8 PYTHIA8)
  EnsureVarOrEnvSet(PYTHIA8_ENV_LIB_DIR PYTHIA8_LIB_DIR)
  EnsureVarOrEnvSet(PYTHIA8_LIBRARY PYTHIA8_LIBRARY)
  EnsureVarOrEnvSet(PYTHIA8_ENV_INCLUDE_DIR PYTHIA8_INCLUDE_DIR)
  EnsureVarOrEnvSet(PYTHIA8_INCLUDE_DIR PYTHIA8_INCLUDE_DIR)

  find_path(PYTHIA8_LIB_DIR
    NAMES libpythia8.so libPythia8.so
    PATHS ${PYTHIA8} ${PYTHIA8_ENV_LIB_DIR} ${PYTHIA8_LIBRARY}
    PATH_SUFFIXES lib lib64
  )

  find_path(PYTHIA8_INCLUDE_DIR
    NAMES Pythia8/Pythia.h
    PATHS ${PYTHIA8} ${PYTHIA8_ENV_INCLUDE_DIR} ${PYTHIA8_INCLUDE_DIR}
    PATH_SUFFIXES include
  )

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(Pythia8
    REQUIRED_VARS
      PYTHIA8_LIB_DIR
      PYTHIA8_INCLUDE_DIR
  )

  if(NOT Pythia8_FOUND)
    return()
  endif()

  cmessage(STATUS "Found Pythia8:")
  cmessage(STATUS "     PYTHIA8_LIB_DIR: ${PYTHIA8_LIB_DIR}")
  cmessage(STATUS "     PYTHIA8_INCLUDE_DIR: ${PYTHIA8_INCLUDE_DIR}")

  add_library(Pythia8::Pythia8 INTERFACE IMPORTED)
  set_target_properties(Pythia8::Pythia8 PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${PYTHIA8_INCLUDE_DIR}"
    INTERFACE_LINK_DIRECTORIES "${PYTHIA8_LIB_DIR}"
    INTERFACE_LINK_LIBRARIES pythia8
  )
endif()
