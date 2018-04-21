From: mpatocka@redhat.com (Mikulas Patocka)
Date: Sat, 21 Apr 2018 09:59:48 -0400 (EDT)
Subject: [PATCH] fix failure when root filesystem is on nvme
Message-ID: <alpine.LRH.2.02.1804210942070.11467@file01.intranet.prod.int.rdu2.redhat.com>

Hi

There's a bug in the nvme block device driver that causes failure when we 
have no initramfs and the root filesystem is directly on nvme. The driver 
spawns a work item nvme_reset_work() in the nvme_wq workqueue, but doesn't 
wait for it. The result is that the kernel attempts to mount the root 
filesystem before nvme_reset_work() finishes and it panics because it 
can't find the root device.

It can be fixed with this simple patch (perhaps you can come up with a 
better patch that uses the asynchronous probing infrastructure?)

Mikulas

an example of kernel log showing the failure:

[    1.426358] pcieport 0000:00:00.0: Signaling PME with IRQ 35
[    1.432086] pcieport 0000:00:00.0: AER enabled with IRQ 35
==== here it detects the nvme device
[    1.437724] nvme nvme0: pci function 0000:01:00.0
[    1.442563] xhci-hcd f4500000.usb3: xHCI Host Controller
[    1.444550] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.447300] ata3.00: ATA-8: ST4000DM000-1F2168, CC52, max UDMA/133
[    1.447302] ata3.00: 7814037168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    1.448035] ata3.00: configured for UDMA/133
[    1.448138] scsi 2:0:0:0: Direct-Access     ATA      ST4000DM000-1F21 CC52 PQ: 0 ANSI: 5
[    1.479552] xhci-hcd f4500000.usb3: new USB bus registered, assigned bus number 5
[    1.487128] xhci-hcd f4500000.usb3: hcc params 0x0a000990 hci version 0x100 quirks 0x00010010
[    1.495708] xhci-hcd f4500000.usb3: irq 29, io mem 0xf4500000
[    1.501678] hub 5-0:1.0: USB hub found
[    1.505454] hub 5-0:1.0: 1 port detected
[    1.509475] xhci-hcd f4500000.usb3: xHCI Host Controller
[    1.514815] xhci-hcd f4500000.usb3: new USB bus registered, assigned bus number 6
[    1.522356] usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
[    1.530623] hub 6-0:1.0: USB hub found
[    1.534400] hub 6-0:1.0: 1 port detected
[    1.538446] armada38x-rtc f4284000.rtc: setting system clock to 2018-04-21 12:48:10 UTC (1524314890)
==== here it attempts to mount the root filesystem and fails
[    1.547867] VFS: Cannot open root device "nvme0n1p1" or unknown-block(0,0): error -6
[    1.555650] Please append a correct "root=" boot option; here are the available partitions:
[    1.564045] b300         7634944 mmcblk0
[    1.564047]  driver: mmcblk
[    1.570885]   b301         7633920 mmcblk0p1 62641075-01
[    1.570887]
[    1.577726] b318             512 mmcblk0rpmb
[    1.577728]  (driver?)
[    1.584472] b310            4096 mmcblk0boot1
[    1.584474]  (driver?)
[    1.591303] b308            4096 mmcblk0boot0
[    1.591305]  (driver?)
[    1.598138] b320         7774208 mmcblk1
[    1.598140]  driver: mmcblk
[    1.604974]   b321           16384 mmcblk1p1 b26e29b3-82c5-7a47-a69c-c9641245b135
[    1.604975]
[    1.613987]   b322         7147503 mmcblk1p2 51931c47-13b3-6d44-bba4-313e5a67b923
[    1.613988]
[    1.622999] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    1.631298] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.14.34 #1
==== here it detects partitions on the nvme device - it is already too late and the panic is in progress
[    1.631627]  nvme0n1: p1 p2
[    1.640129] Hardware name: Marvell 8040 MACHIATOBin (DT)
[    1.645461] Call trace:
[    1.647923] [<ffffff8008088b60>] dump_backtrace+0x0/0x3b8
[    1.653345] [<ffffff8008088f2c>] show_stack+0x14/0x20
[    1.658419] [<ffffff80085057cc>] dump_stack+0x8c/0xb0
[    1.663492] [<ffffff80080c1680>] panic+0x114/0x264
[    1.668302] [<ffffff8008681084>] mount_block_root+0x20c/0x2ac


Signed-off-by: Mikulas Patocka <mpatocka at redhat.com>

---
 drivers/nvme/host/pci.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-4.14.34/drivers/nvme/host/pci.c
===================================================================
--- linux-4.14.34.orig/drivers/nvme/host/pci.c	2018-02-13 23:44:54.000000000 +0100
+++ linux-4.14.34/drivers/nvme/host/pci.c	2018-04-21 15:08:56.000000000 +0200
@@ -2356,6 +2356,7 @@ static int nvme_probe(struct pci_dev *pd
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
 	queue_work(nvme_wq, &dev->ctrl.reset_work);
+	flush_work(&dev->ctrl.reset_work);
 	return 0;
 
  release_pools:
