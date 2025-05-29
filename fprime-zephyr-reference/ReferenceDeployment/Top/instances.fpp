module ReferenceDeployment {

  # ----------------------------------------------------------------------
  # Defaults
  # ----------------------------------------------------------------------

  module Default {
    constant QUEUE_SIZE = 10
    constant STACK_SIZE = 8 * 1024
  }

  # ----------------------------------------------------------------------
  # Active component instances
  # ----------------------------------------------------------------------

  instance rateGroup1: Svc.ActiveRateGroup base id 0x0200 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 13

  instance rateGroup2: Svc.ActiveRateGroup base id 0x0400 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 12

  instance cmdDisp: Svc.CommandDispatcher base id 0x0500 \
    queue size 20 \
    stack size Default.STACK_SIZE \
    priority 11

  instance comQueue: Svc.ComQueue base id 0x0700 \
      queue size 50 \
      stack size Default.STACK_SIZE \
      priority 10 \

  instance eventLogger: Svc.ActiveLogger base id 0x0B00 \
    queue size Default.QUEUE_SIZE \
    stack size Default.STACK_SIZE \
    priority 9

  # comment in Svc.TlmChan or Svc.TlmPacketizer
  # depending on which form of telemetry downlink
  # you wish to use

  #instance tlmSend: Svc.TlmChan base id 0x0C00 \
  #  queue size Default.QUEUE_SIZE \
  #  stack size Default.STACK_SIZE \
  #  priority 97

  #instance tlmSend: Svc.TlmPacketizer base id 0x0C00 \
  #    queue size Default.QUEUE_SIZE \
  #    stack size Default.STACK_SIZE \
  #    priority 97

  # ----------------------------------------------------------------------
  # Queued component instances
  # ----------------------------------------------------------------------

  instance $health: Svc.Health base id 0x2000 \
    queue size 25

  # ----------------------------------------------------------------------
  # Passive component instances
  # ----------------------------------------------------------------------

  instance clockSource: Zephyr.ZephyrRateDriver base id 0x4000


  instance framer: Svc.FprimeFramer base id 0x4100

  #instance fatalAdapter: Svc.AssertFatalAdapter base id 0x4200

  instance fatalHandler: Components.FatalHandler base id 0x4300

  instance bufferManager: Svc.BufferManager base id 0x4400

  instance chronoTime: Svc.ChronoTime base id 0x4500

  instance rateGroupDriver: Svc.RateGroupDriver base id 0x4600

  instance textLogger: Svc.PassiveTextLogger base id 0x4800

  instance deframer: Svc.FprimeDeframer base id 0x4900

  instance systemResources: Svc.SystemResources base id 0x4A00

  instance comStub: Svc.ComStub base id 0x4B00

  instance frameAccumulator: Svc.FrameAccumulator base id 0x4C00

  instance fprimeRouter: Svc.FprimeRouter base id 0x4D00

  instance version: Svc.Version base id 0x4E00
}
