// ======================================================================
// \title  Main.cpp
// \brief main program for the F' application. Intended for CLI-based systems (Linux, macOS)
//
// ======================================================================
// Used to access topology functions
#include <FprimeZephyrReference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp>
#include <zephyr/sys/printk.h>
#include <zephyr/kernel.h>

const struct device *serial = DEVICE_DT_GET(DT_NODELABEL(cdc_acm_uart0));

int main(int argc, char* argv[]) {
    Os::init();

    // Object for communicating state to the topology
    ReferenceDeployment::TopologyState inputs;
    inputs.uartDevice = serial;
    inputs.baudRate = 115200;
 
    // Setup, cycle, and teardown topology
    ReferenceDeployment::setupTopology(inputs);

    ReferenceDeployment::startRateGroups(Fw::TimeInterval(0,100));  // Program loop cycling rate groups at 10Hz
    ReferenceDeployment::teardownTopology(inputs);
    return 0;
}
