####
# default/config/CMakeLists.txt:
#
# Sets a list of source files for cmake to process as part of autocoding.
####
register_fprime_config(
    CONFIGURATION_OVERRIDES
        "${CMAKE_CURRENT_LIST_DIR}/AcConstants.fpp"
        "${CMAKE_CURRENT_LIST_DIR}/CommandDispatcherImplCfg.hpp"
        "${CMAKE_CURRENT_LIST_DIR}/TlmChanImplCfg.hpp"
        "${CMAKE_CURRENT_LIST_DIR}/FpConfig.h"
    INTERFACE
)
