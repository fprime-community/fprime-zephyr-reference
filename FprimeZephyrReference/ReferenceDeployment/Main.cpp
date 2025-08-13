// ======================================================================
// \title  Main.cpp
// \brief main program for the F' application. Intended for CLI-based systems (Linux, macOS)
//
// ======================================================================
// Used to access topology functions
#include <FprimeZephyrReference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp>
#include <zephyr/sys/printk.h>
#include <zephyr/kernel.h>

const struct device *serial = DEVICE_DT_GET(DT_NODELABEL(uart0));

int main(int argc, char* argv[]) {
    k_sleep(K_MSEC(3000)); // Wait for initialization
    
    Os::init();
    
    printk("Starting software\n");
    //k_sleep(K_MSEC(1000)); // Allow time for the console to initialize
    printk("Software started\n");

    // Object for communicating state to the topology
    ReferenceDeployment::TopologyState inputs;
    inputs.uartDevice = serial;
    inputs.baudRate = 115200;
 
    // Setup, cycle, and teardown topology
    ReferenceDeployment::setupTopology(inputs);
    printk("Starting main loop\n");
    ReferenceDeployment::startRateGroups(); // Program loop
    printk("Stopping main loop\n");
    ReferenceDeployment::teardownTopology(inputs);
    return 0;
}
