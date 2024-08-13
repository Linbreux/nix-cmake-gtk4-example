cmake_minimum_required(VERSION 3.28)
project(core VERSION 1.0.0)

# Option for shared libraries
option(BUILD_SHARED_LIBS "Build shared libraries instead of static ones" OFF)

# Check if there is already a project name set. If not, use CMAKE_PROJECT_NAME
if(NOT NIX_LIBRARY_NAME)
  set(LIBRARY_NAME "core")
else()
  set(LIBRARY_NAME ${NIX_LIBRARY_NAME})
endif()

# Define the library
add_library(${LIBRARY_NAME} src/core.cpp)

# Include directories
target_include_directories(${LIBRARY_NAME}
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include
  PUBLIC $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

# Set install directories
if(NOT CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib CACHE INTERNAL "Library directory")
endif()

if(NOT CMAKE_INSTALL_INCLUDEDIR)
  set(CMAKE_INSTALL_INCLUDEDIR include CACHE INTERNAL "Include directory")
endif()

# Install the library
install(TARGETS ${LIBRARY_NAME}
  EXPORT ${LIBRARY_NAME}Targets
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${LIBRARY_NAME}
)

# Install header files
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# Generate and install CMake configuration files
include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}ConfigVersion.cmake"
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion
)

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/${LIBRARY_NAME}Config.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}Config.cmake"
  @ONLY
)

install(EXPORT ${LIBRARY_NAME}Targets
  FILE ${LIBRARY_NAME}Targets.cmake
  NAMESPACE ${LIBRARY_NAME}::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${LIBRARY_NAME}
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}Config.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}ConfigVersion.cmake"
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${LIBRARY_NAME}
)

