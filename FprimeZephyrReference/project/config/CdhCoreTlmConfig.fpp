module CdhCore{

    # Uncomment the following block and comment the above block to use TlmPacketizer instead of TlmChan
    instance tlmSend: Svc.TlmPacketizer base id CdhCoreConfig.BASE_ID + 0x06000 \
       queue size CdhCoreConfig.QueueSizes.tlmSend \
       stack size CdhCoreConfig.StackSizes.tlmSend \
       priority CdhCoreConfig.Priorities.tlmSend \
    {
       # NOTE: The Name Ref is specific to the Reference deployment, Ref
       # This name will need to be updated if wishing to use this in a custom deployment
       phase Fpp.ToCpp.Phases.configComponents """
       CdhCore::tlmSend.setPacketList(
           ReferenceDeployment::ReferenceDeployment_ReferenceDeploymentPacketsTlmPackets::packetList, 
           ReferenceDeployment::ReferenceDeployment_ReferenceDeploymentPacketsTlmPackets::omittedChannels, 
           1
       );
       """
    }
}
