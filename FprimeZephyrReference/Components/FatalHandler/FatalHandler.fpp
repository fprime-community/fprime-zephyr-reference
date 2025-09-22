module Components {

  @ Handles FATAL calls
  passive component FatalHandler {

    @ FATAL event receive port
    sync input port FatalReceive: Svc.FatalEvent

    @ Issue a FSW reset
    sync command RESTART

    @ Event to indicate reboot is happening
    event Rebooting() \
      severity activity high \
      format "Rebooting..."

    ##########################################################
    # Standard AC Ports: Required for Commands, and Events   #
    ##########################################################
    @ Port for requesting the current time
    time get port timeCaller

    @ Port for sending command registrations
    command reg port cmdRegOut

    @ Port for receiving commands
    command recv port cmdIn

    @ Port for sending command responses
    command resp port cmdResponseOut

    @ Port for sending textual representation of events
    text event port logTextOut

    @ Port for sending events to downlink
    event port logOut
  }

}
