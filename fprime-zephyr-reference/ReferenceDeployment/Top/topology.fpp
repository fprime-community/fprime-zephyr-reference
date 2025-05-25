module ReferenceDeployment {

  # ----------------------------------------------------------------------
  # Symbolic constants for port numbers
  # ----------------------------------------------------------------------

  enum Ports_RateGroups {
    rateGroup1
    rateGroup2
    rateGroup3
  }
  enum Ports_ComPacketQueue {
    EVENTS,
    TELEMETRY
  }


  topology ReferenceDeployment {

    # ----------------------------------------------------------------------
    # Instances used in the topology
    # ----------------------------------------------------------------------

    instance $health
    instance clockSource
    #instance tlmSend
    instance cmdDisp
    instance comDriver
    instance comQueue
    instance comStub
    instance fprimeRouter
    instance deframer
    instance frameAccumulator
    instance eventLogger
    #instance fatalAdapter
    instance fatalHandler
    instance bufferManager
    instance framer
    instance chronoTime
    instance rateGroup1
    instance rateGroup2
    instance rateGroupDriver
    instance textLogger
    instance systemResources
    instance version

    # ----------------------------------------------------------------------
    # Pattern graph specifiers
    # ----------------------------------------------------------------------

    command connections instance cmdDisp

    event connections instance eventLogger

    #telemetry connections instance tlmSend

    text event connections instance textLogger

    time connections instance chronoTime

    health connections instance $health

    # ----------------------------------------------------------------------
    # Telemetry packets
    # ----------------------------------------------------------------------

    include "ReferenceDeploymentPackets.fppi"


    # ----------------------------------------------------------------------
    # Direct graph specifiers
    # ----------------------------------------------------------------------

    connections Downlink {
      # Inputs to ComQueue (events, telemetry)
      eventLogger.PktSend         -> comQueue.comPacketQueueIn[Ports_ComPacketQueue.EVENTS]
      #tlmSend.PktSend             -> comQueue.comPacketQueueIn[Ports_ComPacketQueue.TELEMETRY]

      # ComQueue <-> Framer
      comQueue.dataOut   -> framer.dataIn
      framer.dataReturnOut -> comQueue.dataReturnIn
      framer.comStatusOut  -> comQueue.comStatusIn

      # Buffer Management for Framer
      framer.bufferAllocate   -> bufferManager.bufferGetCallee
      framer.bufferDeallocate -> bufferManager.bufferSendIn

      # Framer <-> ComStub
      framer.dataOut        -> comStub.dataIn
      comStub.dataReturnOut -> framer.dataReturnIn
      comStub.comStatusOut  -> framer.comStatusIn

      # ComStub <-> ComDriver
      comStub.drvSendOut      -> comDriver.$send
      comDriver.sendReturnOut -> comStub.drvSendReturnIn
      comDriver.ready         -> comStub.drvConnected
    }

    connections FaultProtection {
      eventLogger.FatalAnnounce -> fatalHandler.FatalReceive
    }

    connections RateGroups {
      # Block driver
      clockSource.CycleOut -> rateGroupDriver.CycleIn

      # Rate group 1
      rateGroupDriver.CycleOut[Ports_RateGroups.rateGroup1] -> rateGroup1.CycleIn
      rateGroup1.RateGroupMemberOut[0] -> comDriver.schedIn
      #rateGroup1.RateGroupMemberOut[2] -> tlmSend.Run

      # Rate group 2
      rateGroupDriver.CycleOut[Ports_RateGroups.rateGroup2] -> rateGroup2.CycleIn
      rateGroup2.RateGroupMemberOut[0] -> $health.Run
#      rateGroup2.RateGroupMemberOut[1] -> blockDrv.Sched
#      rateGroup2.RateGroupMemberOut[2] -> bufferManager.schedIn
#      rateGroup2.RateGroupMemberOut[3] -> systemResources.run
#      rateGroup1.RateGroupMemberOut[0] -> comQueue.run
    }

    connections Uplink {
      # ComDriver buffer allocations
      comDriver.allocate      -> bufferManager.bufferGetCallee
      comDriver.deallocate    -> bufferManager.bufferSendIn
      # ComDriver <-> ComStub
      comDriver.$recv             -> comStub.drvReceiveIn
      comStub.drvReceiveReturnOut -> comDriver.recvReturnIn
      # ComStub <-> FrameAccumulator
      comStub.dataOut                -> frameAccumulator.dataIn
      frameAccumulator.dataReturnOut -> comStub.dataReturnIn
      # FrameAccumulator buffer allocations
      frameAccumulator.bufferDeallocate -> bufferManager.bufferSendIn
      frameAccumulator.bufferAllocate   -> bufferManager.bufferGetCallee
      # FrameAccumulator <-> Deframer
      frameAccumulator.dataOut  -> deframer.dataIn
      deframer.dataReturnOut    -> frameAccumulator.dataReturnIn
      # Deframer <-> Router
      deframer.dataOut           -> fprimeRouter.dataIn
      fprimeRouter.dataReturnOut -> deframer.dataReturnIn
      # Router buffer allocations
      fprimeRouter.bufferAllocate   -> bufferManager.bufferGetCallee
      fprimeRouter.bufferDeallocate -> bufferManager.bufferSendIn
      # Router <-> CmdDispatcher
      fprimeRouter.commandOut  -> cmdDisp.seqCmdBuff
      cmdDisp.seqCmdStatus     -> fprimeRouter.cmdResponseIn
    }

    connections ReferenceDeployment {
      # Add here connections to user-defined components
    }

  }

}
