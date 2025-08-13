module CdhCoreConfig {
    #Base ID for the CdhCore Subtopology, all components are offsets from this base ID
    constant BASE_ID = 0x01000000
    
    module QueueSizes {
        constant cmdDisp     = 10
        constant events      = 25
        constant tlmSend     = 5
        constant $health     = 10
    }
    

    module StackSizes {
        constant cmdDisp     = 8 * 1024
        constant events      = 8 * 1024
        constant tlmSend     = 8 * 1024
    }

    module Priorities {
        constant cmdDisp     = 10
        constant $health     = 11
        constant events      = 12
        constant tlmSend     = 13

    }
}
