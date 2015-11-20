From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Fri, 20 Nov 2015 19:57:06 +0100
Subject: [PATCH 1/1] nvme: temporary fix for Apple NVMe controller reset
Message-ID: <6ed9ad799884d9d4bdbfbdf94185c3f2@localhost>

Recent patches added basic support for the Apple NVMe controller but
still cause controller resets and data corruption when a specific
pattern of read/flush commands occurs on that controller.

This patch prevents that and was tested for a weeek by myself running
4.4-rc1. It is also confirmed to work around that problem by at least
one other guy.

Maybe this hotfix can be done in a more elegant way, but something
like that should definitely go into 4.4 as the controller will otherwise
destroy file systems.


Signed-off-by: Stephan G?nther <guenther at tum.de>
Signed-off-by: Maurice Leclaure <leclaire at in.tum.de
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8187df2..15bbedb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2701,6 +2701,14 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
+
+	/*
+	 * Temporary fix for the Apple controller found in the MacBook8,1 and
+	 * some MacBook7,1 to avoid controller resets and data loss.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001)
+		dev->q_depth = 2;
+
 	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
 		dev->cmb = nvme_map_cmb(dev);
