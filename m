From: kamalax.subbiah@intel.com (Subbiah, KamalaX)
Date: Tue, 18 Jul 2017 13:34:24 +0000
Subject: NVMe drive is not discovered after resuming back from suspend in host.
Message-ID: <06DD61BCF94D6D48AEF1059E41772BF32B6686BB@BGSMSX108.gar.corp.intel.com>


Hi,

Both NVMeOF host? and NVMeOF target server is configured with RHEL OS v7.3 and upstream kernel v4.10.4.
NIC card (both target and host) - Mellanox Technologies MT27710 Family [ConnectX-4??? Lx], driver: mlx5_core, version: 3.0-1, firmware v14.14.1100.
1. Powered on the NVMeOF target server with single drive.
2. NVMe OF Target and Host? is configured and loaded with all nvme modules and mlx5 drivers.
3. Discovered the device with 'nvme discover -t rdma -a 1.1.1.1 -s 4440' in host.
4. Verify drive discovery??? <ls /dev/nvme*> in host.
5. Issue?? <pm-suspend> in host.

Observation:
   After resumes back from suspend unable to discover the drive with nvme discover command. Getting connection timed out error.

Nvme-cli error: 
       [root at localhost ~]# nvme discover -t rdma -a 1.1.1.1 -s 4440
       Failed to write to /dev/nvme-fabrics: Connection timed out

dmesg output:
[? 229.722177] PM: Syncing filesystems ... done.
[? 230.129798] Freezing user space processes ... (elapsed 0.002 seconds) done.
[? 230.131922] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[? 230.133919] Suspending console(s) (use no_console_suspend to debug) [? 230.134630] sd 8:0:0:0: [sda] Synchronizing SCSI cache [? 230.134726] sd 8:0:0:0: [sda] Stopping disk [? 230.135043] serial 00:03: disabled [? 230.135069] serial 00:02: disabled [? 230.246045] pcieport 0000:00:02.2: System wakeup enabled by ACPI [? 230.258654] pcieport 0000:00:02.2: System wakeup enabled by ACPI [? 230.974588] PM: suspend of devices complete after 840.088 msecs [? 230.976024] PM: late suspend of devices complete after 1.431 msecs [? 230.977486] ehci-pci 0000:00:1d.0: System wakeup enabled by ACPI [? 230.977856] ehci-pci 0000:00:1a.0: System wakeup enabled by ACPI [? 230.977912] xhci_hcd 0000:00:14.0: System wakeup enabled by ACPI [? 230.989857] PM: noirq suspend of devices complete after 13.804 msecs [? 231.204578] Suspended for 0.999 seconds [? 232.217525] Suspended for 0.997 seconds [? 233.230523] Suspended for 0.997 seconds [? 234.243561] Suspended for 0.997 seconds [? 234.651911] xhci_hcd 0000:00:14.0: System wakeup disabled by ACPI [? 234.651960] ehci-pci 0000:00:1a.0: System wakeup disabled by ACPI [? 234.651988] ehci-pci 0000:00:1d.0: System wakeup disabled by ACPI [? 234.663773] PM: noirq resume of devices complete after 26.046 msecs [? 234.665444] PM: early resume of devices complete after 1.551 msecs [? 234.666022] pcieport 0000:00:02.2: System wakeup disabled by ACPI [? 234.666030] pcieport 0000:00:02.2: System wakeup disabled by ACPI [? 234.666342] power_meter ACPI000D:00: Found ACPI power meter.
[? 234.666392] rtc_cmos 00:00: System wakeup disabled by ACPI [? 234.666504] sd 8:0:0:0: [sda] Starting disk [? 234.666705] serial 00:02: activated [? 234.666888] serial 00:03: activated [? 234.667002] Suspended for 19799.159 seconds [? 234.926014] PM: resume of devices complete after 260.565 msecs [? 234.926509] Restarting tasks ... done.
[? 234.984079] ata3: SATA link down (SStatus 0 SControl 300) [? 234.984150] ata2: SATA link down (SStatus 0 SControl 300) [? 234.984213] ata4: SATA link down (SStatus 0 SControl 300) [? 234.984256] ata8: SATA link down (SStatus 0 SControl 300) [? 234.984302] ata1: SATA link down (SStatus 0 SControl 300) [? 234.984391] ata6: SATA link down (SStatus 0 SControl 300) [? 234.984465] ata7: SATA link down (SStatus 0 SControl 300) [ ?234.984599] ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300) [? 234.984643] ata5: SATA link down (SStatus 0 SControl 300) [? 234.985003] ata9.00: configured for UDMA/133 [? 234.992413] ata10: SATA link down (SStatus 0 SControl 300) [? 238.221171] igb 0000:03:00.0 enp3s0f0: igb: enp3s0f0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX [? 246.562810] nvme nvme1: rdma_resolve_addr wait failed (-110).
[? 295.843232] mlx5_core 0000:82:00.0: wait_func:882:(pid 658): QUERY_Q_COUNTER(0x773) timeout. Will cause a leak of a command resource [? 308.131318] mlx5_core 0000:82:00.0: wait_func:882:(pid 803): CREATE_CQ(0x400) timeout. Will cause a leak of a command resource [? 357.283741] mlx5_core 0000:82:00.0: wait_func:882:(pid 658): QUERY_VPORT_COUNTER(0x770) timeout. Will cause a leak of a command resource
