From: axboe@fb.com (Jens Axboe)
Date: Fri, 14 Nov 2014 09:50:19 -0700
Subject: [PATCH] NVMe: fail pci initialization if the device doesn't have any
 BARs
Message-ID: <20141114165019.GD12860@kernel.dk>

The PCI init of NVMe doesn't check for valid bars before proceeding
to map and use BAR 0. If the device is hosed (or firmware is), then
we should catch this case and give up early.

This fixes a:

[ 1662.035778] WARNING: CPU: 0 PID: 4 at arch/x86/mm/ioremap.c:63 __ioremap_check_ram+0xa7/0xc0()

and later badness on such a device.

Signed-off-by: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ee533aabf479..d982f7e6d09b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2158,6 +2158,9 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->entry[0].vector = pdev->irq;
 	pci_set_master(pdev);
 	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	if (!bars)
+		goto disable_pci;
+
 	if (pci_request_selected_regions(pdev, bars, "nvme"))
 		goto disable_pci;
 
-- 
1.9.1

-- 
Jens Axboe
