# fprime-zephyr-reference F' project

A reference deployment built on the Zephyr RTOS. 

**F´:** https://fprime.jpl.nasa.gov
**Zephyr RTOS:** https://docs.zephyrproject.org/latest/index.html

Installation Steps (See https://docs.zephyrproject.org/latest/develop/getting_started/index.html):

  0. Source your preferred Virtual Environment `python3 -m venv fprime-venv` then `. ./fprime-venv/bin/activate`
  1. Update submodules `git submodule update --init --recursive`
  2. Install Packages: `brew install gperf ccache qemu dtc libmagic wget openocd` or `apt install gperf ccache dfu-util device-tree-compiler wget xz-utils file xz-utils make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1`
  3. `git submodule update --init --update`
  4. `pip install -r requirements.txt`
  5. `cd lib/zephyr-workspace && west update && west zephyr-export && west packages pip --install` Note: may take a while
  6. Install Zephyr SDK: https://docs.zephyrproject.org/latest/develop/toolchains/zephyr_sdk.html#toolchain-zephyr-sdk
  7. Build: `cd fprime-zephyr-reference/ReferenceDeployment && fprime-util generate && fprime-util build`
  8. Flash onto board: `cd` into `build-artifacts` directory and run `teensy_loader_cli -v -mmcu=TEENSY41 -w zephyr.hex` for **Teensy41** or for **Raspberry Pi Pico**, put the Pico into bootloader mode by holding down the BOOTSEL button while connecting it to your computer via USB, then drag `zephyr.uf2` into the drive that appears
  9. Open GDS: `cd` into the project directory and run `fprime-gds -n --dictionary ./build-artifacts/zephyr/fprime-zephyr-deployment/dict/ReferenceDeploymentTopologyDictionary.json --communication-selection uart --uart-baud 115200 --output-unframed-data -` 

---
### Common Trouble-shooting 
* If it seems to be a Zephyr issue, run `west update` 
* When changing boards
  * Update `settings.ini` to the new board
  * Update `prj.conf` to the new board's Device PID and VID configurations 
  * Run `fprime-util generate -f` to generate new build files 
  * Run `fprime-util build` to build the new project 
* **Zephyr Supported Boards**: https://docs.zephyrproject.org/latest/boards/index.html#
* Remember to ensure new build is successful before flashing onto board
* For debugging using **FDTI** cable, see relevant pinout, https://microcontrollerslab.com/ftdi-usb-to-serial-converter-cable-use-linux-windows/



