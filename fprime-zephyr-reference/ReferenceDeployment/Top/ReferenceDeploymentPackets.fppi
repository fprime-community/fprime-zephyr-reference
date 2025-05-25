telemetry packets ReferenceDeploymentPackets {

  packet CDH id 1 group 1 {
    ReferenceDeployment.cmdDisp.CommandsDispatched
    ReferenceDeployment.rateGroup1.RgMaxTime
    ReferenceDeployment.rateGroup2.RgMaxTime
    ReferenceDeployment.bufferManager.TotalBuffs
    ReferenceDeployment.bufferManager.CurrBuffs
    ReferenceDeployment.bufferManager.HiBuffs
    ReferenceDeployment.comQueue.comQueueDepth
    ReferenceDeployment.comQueue.buffQueueDepth
    # Note: Uncomment when using Svc:TlmPacketizer
    # ReferenceDeployment.tlmSend.SendLevel
  }

  packet CDHErrors id 2 group 1 {
    ReferenceDeployment.rateGroup1.RgCycleSlips
    ReferenceDeployment.rateGroup2.RgCycleSlips
    ReferenceDeployment.$health.PingLateWarnings
    ReferenceDeployment.bufferManager.NoBuffs
    ReferenceDeployment.bufferManager.EmptyBuffs
  }

  packet DriveTlm id 3 group 1 {
  }

  packet SystemRes1 id 4 group 2 {
    ReferenceDeployment.systemResources.MEMORY_TOTAL
    ReferenceDeployment.systemResources.MEMORY_USED
    ReferenceDeployment.systemResources.NON_VOLATILE_TOTAL
    ReferenceDeployment.systemResources.NON_VOLATILE_FREE
  }

  packet SystemRes3 id 5 group 2 {
    ReferenceDeployment.systemResources.CPU
    ReferenceDeployment.systemResources.CPU_00
    ReferenceDeployment.systemResources.CPU_01
    ReferenceDeployment.systemResources.CPU_02
    ReferenceDeployment.systemResources.CPU_03
    ReferenceDeployment.systemResources.CPU_04
    ReferenceDeployment.systemResources.CPU_05
    ReferenceDeployment.systemResources.CPU_06
    ReferenceDeployment.systemResources.CPU_07
    ReferenceDeployment.systemResources.CPU_08
    ReferenceDeployment.systemResources.CPU_09
    ReferenceDeployment.systemResources.CPU_10
    ReferenceDeployment.systemResources.CPU_11
    ReferenceDeployment.systemResources.CPU_12
    ReferenceDeployment.systemResources.CPU_13
    ReferenceDeployment.systemResources.CPU_14
    ReferenceDeployment.systemResources.CPU_15
  }

  packet Version1 id 6 group 2 {
    ReferenceDeployment.version.FrameworkVersion
    ReferenceDeployment.version.ProjectVersion
  }

  packet Version_Library1 id 7 group 2 {
    ReferenceDeployment.version.LibraryVersion01
    ReferenceDeployment.version.LibraryVersion02
  }

  packet Version_Library2 id 8 group 2 {
    ReferenceDeployment.version.LibraryVersion03
    ReferenceDeployment.version.LibraryVersion04
  }

  packet Version_Library3 id 9 group 2 {
    ReferenceDeployment.version.LibraryVersion05
    ReferenceDeployment.version.LibraryVersion06
  }

  packet Version_Library4 id 10 group 2 {
    ReferenceDeployment.version.LibraryVersion07
    ReferenceDeployment.version.LibraryVersion08
  }

  packet Version_Library5 id 11 group 2 {
    ReferenceDeployment.version.LibraryVersion09
    ReferenceDeployment.version.LibraryVersion10
  }

  packet Version_Custom1 id 12 group 2 {
    ReferenceDeployment.version.CustomVersion01
  }

  packet Version_Custom2 id 13 group 2 {
    ReferenceDeployment.version.CustomVersion02
  }

  packet Version_Custom3 id 14 group 2 {
    ReferenceDeployment.version.CustomVersion03
  }

  packet Version_Custom4 id 15 group 2 {
    ReferenceDeployment.version.CustomVersion04
  }

  packet Version_Custom5 id 16 group 2 {
    ReferenceDeployment.version.CustomVersion05
  }

  packet Version_Custom6 id 17 group 2 {
    ReferenceDeployment.version.CustomVersion06
  }

  packet Version_Custom7 id 18 group 2 {
    ReferenceDeployment.version.CustomVersion07
  }

  packet Version_Custom8 id 19 group 2 {
    ReferenceDeployment.version.CustomVersion08
  }

  packet Version_Custom9 id 20 group 2 {
    ReferenceDeployment.version.CustomVersion09
  }

  packet Version_Custom10 id 21 group 2 {
    ReferenceDeployment.version.CustomVersion10
  }

} omit {
  ReferenceDeployment.cmdDisp.CommandErrors
#  ReferenceDeployment.comDriver.BytesRecv
#  ReferenceDeployment.comDriver.BytesSent
}
