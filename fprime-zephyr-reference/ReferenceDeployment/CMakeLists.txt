#####
# 'ReferenceDeployment' Deployment:
#
# This registers the 'ReferenceDeployment' deployment to the build system. 
# Custom components that have not been added at the project-level should be added to 
# the list below.
#
#####

###
# Topology and Components
###
add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/Top/")

# Add custom components to this specific deployment here
# add_fprime_subdirectory("${CMAKE_CURRENT_LIST_DIR}/MyComponent/")

if (FPRIME_PLATFORM STREQUAL "Zephyr")
   register_fprime_zephyr_deployment(
            ${FPRIME_CURRENT_MODULE}
        SOURCES
            "${CMAKE_CURRENT_LIST_DIR}/Main.cpp"
        DEPENDS
            ${FPRIME_CURRENT_MODULE}_Top
    )
else()
    # In non-Zephyr targets, register a deployment as usual
    register_fprime_deployment(
        SOURCES
            "${CMAKE_CURRENT_LIST_DIR}/Main.cpp"
        DEPENDS
            ${FPRIME_CURRENT_MODULE}_Top
    )
endif()

