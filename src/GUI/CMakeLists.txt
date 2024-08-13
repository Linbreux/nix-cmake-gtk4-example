cmake_minimum_required(VERSION 3.28)

set(PACKAGE_NAME "gui" CACHE INTERNAL "Package name")

project(${PACKAGE_NAME})

set(SOURCE_FILES
  main.cpp
  src/welcomePage.cpp
)

find_package(PkgConfig REQUIRED)

set(CORE_TARGET core)
if(NOT TARGET core)
  find_package(core REQUIRED)
  set(CORE_TARGET core::core)
endif()

set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE INTERNAL "")

if(CMAKE_EXPORT_COMPILE_COMMANDS)
  set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES 
      ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()



add_executable(${PACKAGE_NAME} ${SOURCE_FILES})

target_include_directories(${PACKAGE_NAME} 
  PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include
)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTKMM gtkmm-4.0)

link_directories(
    ${GTKMM_LIBRARY_DIRS}  )

include_directories(
  ${GTKMM_INCLUDE_DIRS}  )

target_include_directories(${PACKAGE_NAME}
                           PRIVATE "${CMAKE_CURRENT_BINARY_DIR}")

target_link_libraries(${PACKAGE_NAME}
                      ${GTKMM_LIBRARIES} ${CORE_TARGET})

install(TARGETS ${PACKAGE_NAME}
  DESTINATION ${CMAKE_INSTALL_BINDIR}
  COMPONENT runtime
)
