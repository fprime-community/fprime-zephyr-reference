####
# F prime CMakeLists.txt:
#
# SOURCE_FILES: combined list of source and autocoding files
# MOD_DEPS: (optional) module dependencies
####
set(SPECIFIC_INSTANCES "${CMAKE_CURRENT_LIST_DIR}/instances-native.fpp")
if ("${FPRIME_PLATFORM}" STREQUAL Zephyr)
    set(SPECIFIC_INSTANCES "${CMAKE_CURRENT_LIST_DIR}/instances-zephyr.fpp")
endif()
register_fprime_module(
    AUTOCODER_INPUTS
        "${CMAKE_CURRENT_LIST_DIR}/instances.fpp"
        "${SPECIFIC_INSTANCES}"
        "${CMAKE_CURRENT_LIST_DIR}/topology.fpp"
    SOURCES
        "${CMAKE_CURRENT_LIST_DIR}/ReferenceDeploymentTopology.cpp"
)
