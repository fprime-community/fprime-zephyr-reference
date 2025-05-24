# fprime-zephyr-reference F' project

A reference deployment built on the Zephyr RTOS. 

**F´:** https://fprime.jpl.nasa.gov
**Zephyr RTOS:** https://docs.zephyrproject.org/latest/index.html

Installation Steps (See https://docs.zephyrproject.org/latest/develop/getting_started/index.html):
  0. Source your preferred Virtual Environment
  1. Update submodules `git submodule update --init --recursive`
  2. Install Packages: `brew install gperf ccache qemu dtc libmagic wget openocd` or `apt install gperf ccache dfu-util device-tree-compiler wget xz-utils file xz-utils make gcc gcc-multilib g++-multilib libsdl2-dev libmagic1`
  3. `git submodule update --init --update`
  4. `pip install -r requirements.txt`
  5. `cd lib/zephyr-workspace && west update && west zephyr-export && west packages pip --install` Note: may take a while
  6. Install Zephyr SDK: https://docs.zephyrproject.org/latest/develop/toolchains/zephyr_sdk.html#toolchain-zephyr-sdk
  7. Build: `cd fprime-zephyr-reference/ReferenceDeployment && fprime-util generate && fprime-util build`




