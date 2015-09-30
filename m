From: mohana.goli@seagate.com (Mohana Goli)
Date: Wed, 30 Sep 2015 20:45:14 +0530
Subject: Deadlock on Fast hotplug with NVMe drives
Message-ID: <CAPYzm7TRasa6xKtHp=41bD-3DQx1fo5YeT1Zc7CQjaj69AA8ZQ@mail.gmail.com>

Hi Keith,

I am seeing a kernel freeze ,a possible deadlock when i do hot
plug/unplug with NVMe drives.
I have observed that after hot adding the drive,if we remove within 3
secs Kernel simply freezes.
Observations:

1. nvme_dev_scan ,worker  is taking around 2.2 secs when  hot added the device.
2. If the device is removed, once scan_work is completed,no issue is seen.
3. If the device is removed while scan work is going,remove worker
thread and scan worker thread both are deadlocked.
4. I induced kernel panic when this issue happens,i see remove worker
is waiting on scan_work to complete and scan_worker is struck while
adding disk
5. nvme_dev_scan completes in less than a second if the device is
already present and if i do unload and load of the driver.This could
be because the drive is
   already powered up and ready to service the IOs,where as in
hot-added device case drive firmware needs to be up before servicing
the IOs.
6.This is easily reproducible on my setup.

As of now i do not have why this is happening.If you have any comments
please let me know on this issue.

Thanks & Regards,
Mohan.



 dmesg output which shows nvme_dev_scan is taking 2.2 secs in working case:

[ 902.036018] pciehp 0000:0e:08.0:pcie24: slot(8): Link Up event
[ 902.036043] pcieport 0000:00:03.0: AER: Corrected error received: id=0e40
[ 902.036056] pciehp 0000:0e:08.0:pcie24: Link Up event ignored on
slot(8): already powering on
[ 902.910600] pci 0000:14:00.0: [144d:a820] type 00 class 0x010802
[ 902.910720] pci 0000:14:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[ 902.910842] pci 0000:14:00.0: Max Payload Size set to 256 (was 128, max 256)
[ 902.912222] pcieport 0000:0e:08.0: bridge window [io 0x1000-0x0fff]
to [bus 14] add_size 1000
[ 902.912245] pcieport 0000:0e:08.0: res[13]=[io 0x1000-0x0fff]
res_to_dev_res add_size 1000 min_align 1000
[ 902.912249] pcieport 0000:0e:08.0: res[13]=[io 0x1000-0x1fff]
res_to_dev_res add_size 1000 min_align 1000
[ 902.912254] pcieport 0000:0e:08.0: BAR 13: no space for [io size 0x1000]
[ 902.912257] pcieport 0000:0e:08.0: BAR 13: failed to assign [io size 0x1000]
[ 902.912261] pcieport 0000:0e:08.0: BAR 13: no space for [io size 0x1000]
[ 902.912263] pcieport 0000:0e:08.0: BAR 13: failed to assign [io size 0x1000]
[ 902.912271] pci 0000:14:00.0: BAR 0: assigned [mem
0x98000000-0x98003fff 64bit]
[ 902.912305] pcieport 0000:0e:08.0: PCI bridge to [bus 14]
[ 902.912311] pcieport 0000:0e:08.0: bridge window [mem 0x98000000-0x987fffff]
[ 902.912316] pcieport 0000:0e:08.0: bridge window [mem
0x180000c00000-0x180000dfffff 64bit pref]
[ 902.912489] nvme 0000:14:00.0: enabling device (0000 -> 0002)
[ 902.912568] nvme 0000:14:00.0: enabling bus mastering
[ 903.468113] nvme_dev_scan entry
[ 905.677893] nvme_dev_scan exit

stack trace for both remove worker thread and scan_work worker thread.

Remove worker:
================
PID: 220 TASK: ffff881036e18000 CPU: 0 COMMAND: "kworker/0:1"
#0 [ffff881036e23a38] __schedule at ffffffff81528156
#1 [ffff881036e23a90] schedule at ffffffff81528717
#2 [ffff881036e23ab0] schedule_timeout at ffffffff8152af1b
#3 [ffff881036e23b70] wait_for_completion at ffffffff81529806
#4 [ffff881036e23bd0] flush_work at ffffffff8106a394
#5 [ffff881036e23c50] nvme_remove at ffffffffa005cc8f [nvme]
#6 [ffff881036e23c80] pci_device_remove at ffffffff8132e48f
#7 [ffff881036e23cb0] __device_release_driver at ffffffff813deaa6
#8 [ffff881036e23cd0] device_release_driver at ffffffff813deb63
#9 [ffff881036e23cf0] pci_stop_bus_device at ffffffff813285f4
#10 [ffff881036e23d20] pci_stop_and_remove_bus_device at ffffffff81328706
#11 [ffff881036e23d40] pciehp_unconfigure_device at ffffffff81340ebb
#12 [ffff881036e23d80] pciehp_disable_slot at ffffffff81340903
#13 [ffff881036e23db0] pciehp_power_thread at ffffffff81340a11
#14 [ffff881036e23e00] process_one_work at ffffffff8106ac13
#15 [ffff881036e23e50] worker_thread at ffffffff8106afaa
#16 [ffff881036e23ec0] kthread at ffffffff810708c9
#17 [ffff881036e23f50] ret_from_fork at ffffffff8152c0cf


scan_work worker thread:
===================

PID: 486 TASK: ffff881033d42480 CPU: 0 COMMAND: "kworker/0:2"
#0 [ffff881032d8f6c8] __schedule at ffffffff81528156
#1 [ffff881032d8f720] schedule at ffffffff81528717
#2 [ffff881032d8f740] schedule_timeout at ffffffff8152af1b
#3 [ffff881032d8f800] io_schedule_timeout at ffffffff81527e06
#4 [ffff881032d8f840] bit_wait_io at ffffffff81528e56
#5 [ffff881032d8f850] __wait_on_bit at ffffffff81528a8d
#6 [ffff881032d8f8a0] wait_on_page_bit at ffffffff81138520
#7 [ffff881032d8f8f0] wait_on_page_read at ffffffff81138729
#8 [ffff881032d8f910] do_read_cache_page at ffffffff811397fd
#9 [ffff881032d8f960] read_cache_page at ffffffff81139919
#10 [ffff881032d8f970] read_dev_sector at ffffffff812de1ad
#11 [ffff881032d8f990] read_lba at ffffffff812e0ad2
#12 [ffff881032d8f9f0] find_valid_gpt at ffffffff812e10c3
#13 [ffff881032d8faa0] efi_partition at ffffffff812e17d9
#14 [ffff881032d8fba0] check_partition at ffffffff812df421
#15 [ffff881032d8fbd0] rescan_partitions at ffffffff812dea0d
#16 [ffff881032d8fc30] __blkdev_get at ffffffff811ddab4
#17 [ffff881032d8fc90] blkdev_get at ffffffff811ddd7a
#18 [ffff881032d8fd20] add_disk at ffffffff812dc406
#19 [ffff881032d8fd90] nvme_dev_scan at ffffffffa005d4e8 [nvme]
#20 [ffff881032d8fe00] process_one_work at ffffffff8106ac13
#21 [ffff881032d8fe50] worker_thread at ffffffff8106afaa
#22 [ffff881032d8fec0] kthread at ffffffff810708c9
#23 [ffff881032d8ff50] ret_from_fork at ffffffff8152c0cf
