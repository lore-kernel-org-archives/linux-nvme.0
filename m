From: kamalax.subbiah@intel.com (Subbiah, KamalaX)
Date: Tue, 18 Jul 2017 13:23:04 +0000
Subject: Power management cases are not working in NVMeOF target/host server
Message-ID: <06DD61BCF94D6D48AEF1059E41772BF32B6686A2@BGSMSX108.gar.corp.intel.com>

Hi,

Both NVMeOF host  and NVMeOF target server is configured with RHEL OS v7.3 and upstream kernel v4.10.4.
NIC card (both target and host) - Mellanox Technologies MT27710 Family [ConnectX-4    Lx], driver: mlx5_core, version: 3.0-1, firmware v14.14.1100.

1. Powered on the NVMeOF target server with single drive.
2. NVMe OF Target and Host  is configured and loaded with all nvme modules and mlx5 drivers. 
3. Verify drive discovery with ls /dev/nvme*
 4. Issue pm-hibernate/pm-suspend-hybrid in target/host server.

Observation: 
The machine is not resuming back and it is hanging. We need to do a cold reboot to get it back.
cat /sys/power/state is listing freeze, mem and disk that means it should  support all sleep states.
