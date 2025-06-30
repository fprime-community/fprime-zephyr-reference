// ======================================================================
// \title  Main.cpp
// \brief main program for the F' application. Intended for CLI-based systems (Linux, macOS)
//
// ======================================================================
// Used to access topology functions
#include <fprime-zephyr-reference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp>
#include <fprime-zephyr-reference/ReferenceDeployment/Top/ReferenceDeploymentTopologyAc.hpp>
// OSAL initialization
#include <Os/Os.hpp>
#include <Fw/Logger/Logger.hpp>
#include <Fw/Types/Assert.hpp>

const struct device *serial = DEVICE_DT_GET(DT_NODELABEL(cdc_acm_uart0));
/**
 * \brief execute the program
 *
 * This F´ program is designed to run in standard environments (e.g. Linux/macOs running on a laptop). Thus it uses
 * command line inputs to specify how to connect.
 *
 * @param argc: argument count supplied to program
 * @param argv: argument values supplied to program
 * @return: 0 on success, something else on failure
 */
int main(int argc, char* argv[]) {
    Os::init();
    // Object for communicating state to the reference topology
    ReferenceDeployment::TopologyState inputs; // Part of FPrime, comment out for debugging
    inputs.baudRate = 115200;
    inputs.uartDevice = serial;


    // Setup, cycle, and teardown topology
    Fw::Logger::log("[F Prime] Initializing topology\n");
    ReferenceDeployment::setupTopology(inputs); // Part of FPrime, comment out for debugging
    Fw::Logger::log("[F Prime] Entering main loop\n");

    // Main program loop
    while (true) {
        // This cycles the rate group by spinning on a timer
        ReferenceDeployment::clockSource.cycle(); // Part of FPrime, comment out for debugging
        // This section will force teensy specific boards into the programing bootloader after the specified number of
        // cycles. This will ensure that CI programs will always return to a programable state.
        #if defined(FPRIME_CI_FAILSAFE_CYCLE_COUNT)
            static U64 failsafe_count = 0;
            if (FPRIME_CI_FAILSAFE_CYCLE_COUNT <= failsafe_count) {
                fatalHandler.reboot();        
            }
            failsafe_count = failsafe_count + 1;
        #endif
    }
    Fw::Logger::log("[F Prime] Resetting main loop\n");
    return 0;
}
