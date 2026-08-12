module ComCcsdsConfig {
    #Base ID for the ComCcsds Subtopology, all components are offsets from this base ID
    constant BASE_ID = 0x02000000
    
    module QueueSizes {
        constant comQueue    = 10
        constant aggregator  = 5
    }
    
    module StackSizes {
        constant comQueue   = 8 * 1024 # Must match prj.conf thread stack size
        constant aggregator = 8 * 1024 # Must match prj.conf thread stack size
    }

    module Priorities {
        constant comQueue   = 5
        constant aggregator = 4
    }

    module CpuAffinities {
        # -1 casts to Os::Task::TASK_DEFAULT (no CPU pinning)
        constant TASK_DEFAULT = -1
        constant comQueue   = TASK_DEFAULT
        constant aggregator = TASK_DEFAULT
    }

    # Queue configuration constants
    module QueueDepths {
        constant events      = 20             
        constant tlm         = 20           
        constant file        = 1            
    }

    module QueuePriorities {
        constant events      = 0                 
        constant tlm         = 2                 
        constant file        = 1                   
    }

    # Buffer management constants
    module BuffMgr {
        constant frameAccumulatorSize  = 2048
        constant commsBuffSize         = 2048
        constant commsFileBuffSize     = 1
        constant commsBuffCount        = 5
        constant commsFileBuffCount    = 1
        constant commsBuffMgrId        = 200
    }
}
