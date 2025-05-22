// ======================================================================
// \title  Main.cpp
// \brief main program for the F' application. Intended for CLI-based systems (Linux, macOS)
//
// ======================================================================
// Used to access topology functions
#include <fprime-zephyr-reference/ReferenceDeployment/Top/ReferenceDeploymentTopology.hpp>
// OSAL initialization
#include <Os/Os.hpp>
// Used for signal handling shutdown
#include <signal.h>
// Used for command line argument processing
#include <getopt.h>
// Used for printf functions
#include <cstdlib>

/**
 * \brief print command line help message
 *
 * This will print a command line help message including the available command line arguments.
 *
 * @param app: name of application
 */
void print_usage(const char* app) {
    (void)printf("Usage: ./%s [options]\n-b\tBaud rate\n-d\tUART Device\n", app);
}

/**
 * \brief shutdown topology cycling on signal
 *
 * The reference topology allows for a simulated cycling of the rate groups. This simulated cycling needs to be stopped
 * in order for the program to shutdown. This is done via handling signals such that it is performed via Ctrl-C
 *
 * @param signum
 */
static void signalHandler(int signum) {
    ReferenceDeployment::stopSimulatedCycle();
}

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
    I32 option = 0;
    CHAR* uart_device = nullptr;
    U32 baud_rate = 0;
    Os::init();

    // Loop while reading the getopt supplied options
    while ((option = getopt(argc, argv, "hb:d:")) != -1) {
        switch (option) {
            // Handle the -b baud rate argument
            case 'b':
                baud_rate = static_cast<U32>(atoi(optarg));
                break;
            // Handle the -d device argument
            case 'd':
                uart_device = optarg;
                break;
            // Cascade intended: help output
            case 'h':
            // Cascade intended: help output
            case '?':
            // Default case: output help and exit
            default:
                print_usage(argv[0]);
                return (option == 'h') ? 0 : 1;
        }
    }
    // Object for communicating state to the reference topology
    ReferenceDeployment::TopologyState inputs;
    inputs.baudRate = baud_rate;
    inputs.uartDevice = uart_device;

    // Setup program shutdown via Ctrl-C
    signal(SIGINT, signalHandler);
    signal(SIGTERM, signalHandler);
    (void)printf("Hit Ctrl-C to quit\n");

    // Setup, cycle, and teardown topology
    ReferenceDeployment::setupTopology(inputs);
    ReferenceDeployment::startSimulatedCycle(Fw::TimeInterval(1,0));  // Program loop cycling rate groups at 1Hz
    ReferenceDeployment::teardownTopology(inputs);
    (void)printf("Exiting...\n");
    return 0;
}
