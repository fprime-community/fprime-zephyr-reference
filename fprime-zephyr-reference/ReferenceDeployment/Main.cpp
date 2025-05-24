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
    ReferenceDeployment::TopologyState inputs;
    inputs.baudRate = 115200;
    inputs.uartDevice = serial;

    // Setup, cycle, and teardown topology
    ReferenceDeployment::setupTopology(inputs);
    // Tick the rategroups
    // TODO: can this improve
    while(true)
    {
        Os::RawTime time;
        ReferenceDeployment::rateGroupDriver.get_CycleIn_InputPort(0)->invoke(time);
        k_usleep(1);
    }
    return 0;
}
