From: sunad.s@samsung.com (Sunad Bhandary)
Date: Wed, 29 Apr 2015 17:35:25 +0530
Subject: Hot-remove of a device with a mounted partition
Message-ID: <006f01d08274$d31e7430$795b5c90$@samsung.com>

Hi,

A couple of things I observed  on hot-removal of a device with a mounted
partition 

1) When the device is removed , sometimes(around 4-5 out of 10 times) the
removal process hangs. The device nodes are still present under /dev. It
seems like call to del_gendisk  function is hung and not returning. 

2) In cases where the removal process completes, a subsequent un-mount gives
rise to the following trace:

[ 1334.796803] WARNING: CPU: 9 PID: 1517 at fs/block_dev.c:56
__blkdev_put+0xbd/0x210()
[ 1334.796806] Modules linked in: ipmi_ssif mei_me intel_rapl iosf_mbi
x86_pkg_temp_thermal mei intel_powerclamp coretemp kvm_intel ipmi_devintf
kvm crct10dif_pclmul crc32_pclmul ipmi_si ghash_clmulni_intel dcdbas
aesni_intel aes_x86_64 ipmi_msghandler lrw shpchp ioatdma 8250_fintek
gf128mul glue_helper ablk_helper lpc_ich cryptd joydev sb_edac dca edac_core
acpi_pad wmi mac_hid acpi_power_meter autofs4 hid_generic nvme tg3 ahci
megaraid_sas usbhid libahci hid ptp pps_core
[ 1334.796866] CPU: 9 PID: 1517 Comm: umount Not tainted 4.1.0-rc1 #1
[ 1334.796869] Hardware name: Dell Inc. PowerEdge R720/0X3D66, BIOS 2.2.2
01/16/2014
[ 1334.796873]  ffffffff81ac8ea3 ffff8800c5853d98 ffffffff817d2177
0000000000000007
[ 1334.796878]  0000000000000000 ffff8800c5853dd8 ffffffff8107980a
0000000000000000
[ 1334.796882]  ffff88040f500680 ffff88040f5007f8 ffff88040f500770
ffff88040f500698
[ 1334.796887] Call Trace:
[ 1334.796900]  [<ffffffff817d2177>] dump_stack+0x45/0x57
[ 1334.796908]  [<ffffffff8107980a>] warn_slowpath_common+0x8a/0xc0
[ 1334.796912]  [<ffffffff810798fa>] warn_slowpath_null+0x1a/0x20
[ 1334.796917]  [<ffffffff812368ed>] __blkdev_put+0xbd/0x210
[ 1334.796922]  [<ffffffff81237360>] blkdev_put+0x50/0x160
[ 1334.796930]  [<ffffffff811fe6d1>] kill_block_super+0x41/0x80
[ 1334.796934]  [<ffffffff811fe9f9>] deactivate_locked_super+0x49/0x80
[ 1334.796939]  [<ffffffff811fee6c>] deactivate_super+0x6c/0x80
[ 1334.796946]  [<ffffffff8121cf43>] cleanup_mnt+0x43/0xa0
[ 1334.796950]  [<ffffffff8121cff2>] __cleanup_mnt+0x12/0x20
[ 1334.796958]  [<ffffffff81097224>] task_work_run+0xd4/0xf0
[ 1334.796968]  [<ffffffff8101404d>] do_notify_resume+0x8d/0xa0
[ 1334.796974]  [<ffffffff817d9604>] int_signal+0x12/0x17
[ 1334.796977] ---[ end trace 050c7d9ced17fce4 ]---    

Any thoughts on this inconsistent behavior would be helpful .

Thanks and regards,
Sunad
