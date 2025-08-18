module MpuImu {
    module SubtoplogyConfig {
        constant BASE_ID = 0xE0000000
    }

    instance imuDriver: Zephyr.ZephyrI2CDriver base id MpuImu.SubtoplogyConfig.BASE_ID + 0x00002000 {
        phase Fpp.ToCpp.Phases.configComponents """
        if (not MpuImu::imuDriver.open(state.mpu.device)) {
            Fw::Logger::log("[ERROR] MPU IMU open failed\\n");
        }
        else {
            Fw::Logger::log("[INFO] MPU IMU open successful\\n");
        }
        """
    }
}
