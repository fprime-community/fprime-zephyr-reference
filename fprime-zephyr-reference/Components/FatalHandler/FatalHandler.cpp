// ======================================================================
// \title  FatalHandlerImpl.cpp
// \author tcanham
// \brief  cpp file for FatalHandler component implementation class
//
// \copyright
// Copyright 2009-2015, by the California Institute of Technology.
// ALL RIGHTS RESERVED.  United States Government Sponsorship
// acknowledged.
//
// ======================================================================


#include <fprime-zephyr-reference/Components/FatalHandler.hpp>
#include <Fw/FPrimeBasicTypes.hpp>

namespace Svc {

  // ----------------------------------------------------------------------
  // Construction, initialization, and destruction
  // ----------------------------------------------------------------------

  FatalHandlerComponentImpl ::
    FatalHandlerComponentImpl(
        const char *const compName
    ) : FatalHandlerComponentBase(compName)
  {

  }

  FatalHandlerComponentImpl ::
    ~FatalHandlerComponentImpl()
  {

  }

  void reboot() {
    #if defined(FPRIME_CI_FAILSAFE_CYCLE_COUNT)
      // Magic bootloader breakpoint, provided by PRJC
      asm("bkpt #251");
    #endif
    while(1) {}
  }

  void FatalHandlerComponentImpl::FatalReceive_handler(
            const FwIndexType portNum,
            FwEventIdType Id) {
        Fw::Logger::log("FATAL %" PRI_FwEventIdType "handled.\n",Id);
#if defined()


        while (true) {} // Returning might be bad
    }


} // end namespace Svc
