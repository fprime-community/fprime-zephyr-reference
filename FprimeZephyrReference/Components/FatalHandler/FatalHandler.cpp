// ======================================================================
// \title  FatalHandlerImpl.cpp
// \author mstarch
// \brief  cpp file for FatalHandler component implementation class
//
// \copyright
// Copyright 2009-2015, by the California Institute of Technology.
// ALL RIGHTS RESERVED.  United States Government Sponsorship
// acknowledged.
//
// ======================================================================

#include <Fw/Logger/Logger.hpp>
#include <FprimeZephyrReference/Components/FatalHandler/FatalHandler.hpp>
#include <Fw/FPrimeBasicTypes.hpp>
#include <zephyr/sys/reboot.h>

namespace Components {

  // ----------------------------------------------------------------------
  // Construction, initialization, and destruction
  // ----------------------------------------------------------------------

  FatalHandler ::
    FatalHandler(
        const char *const compName
    ) : FatalHandlerComponentBase(compName)
  {

  }

  FatalHandler ::
    ~FatalHandler()
  {

  }

  void FatalHandler::reboot() {
  // When running in CI failsafe mode and the board is a teensy,
  // then we should invoke bkpt #251 to trigger the soft reboot enabling a
  // flash of new software
  #if defined(FPRIME_CI_FAILSAFE_CYCLE_COUNT)
      // Magic bootloader breakpoint, provided by PRJC
      if (strncmp(CONFIG_BOARD, "teensy", 6) == 0) {
        asm("bkpt #251");
      }
  #endif
    // Otherwise, use Zephyr to reboot the system
    sys_reboot(SYS_REBOOT_COLD);
  }

  void FatalHandler::FatalReceive_handler(
            const FwIndexType portNum,
            FwEventIdType Id) {
        Fw::Logger::log("FATAL %" PRI_FwEventIdType "handled.\n",Id);
        Os::Task::delay(Fw::TimeInterval(0, 100000)); // Delay to allow log to be processed
        this->reboot(); // Reboot the system
    }

// ----------------------------------------------------------------------
// Handler implementations for commands
// ----------------------------------------------------------------------

void FatalHandler ::RESTART_cmdHandler(FwOpcodeType opCode, U32 cmdSeq) {
    this->log_ACTIVITY_HI_Rebooting();
    Os::Task::delay(Fw::TimeInterval(0, 100000)); // Delay to allow event to go out
    this->reboot();
    this->cmdResponse_out(opCode, cmdSeq, Fw::CmdResponse::OK);
}


} // end namespace Svc
