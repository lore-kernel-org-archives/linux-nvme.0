From: yu.a.xu@intel.com (Xu Yu)
Date: Thu, 18 May 2017 06:35:47 +0800
Subject: [PATCH] nvme/pci: remap BAR0 to cover admin CQ doorbell for large
 stride
Message-ID: <1495060547-6180-1-git-send-email-yu.a.xu@intel.com>

The existing driver initially maps 8192 bytes of BAR0 which is
intended to cover doorbells of admin SQ and CQ. However, if a
large stride, e.g. 10, is used, the doorbell of admin CQ will
be out of 8192 bytes. Consequently, a page fault will be raised
when the admin CQ doorbell is accessed in nvme_configure_admin_queue().

This patch fixes this issue by remapping BAR0 before accessing
admin CQ doorbell if the initial mapping is not enough.

Signed-off-by: "Xu, Yu A" <yu.a.xu at intel.com>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9d4640a..7c991eb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1322,6 +1322,17 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u32 aqa;
 	u64 cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 	struct nvme_queue *nvmeq;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned long size;
+
+	size = 4096 + 2 * 4 * dev->db_stride;
+	if (size > 8192) {
+		iounmap(dev->bar);
+		dev->bar = ioremap(pci_resource_start(pdev, 0), size);
+		if (!dev->bar)
+			return -ENOMEM;
+		dev->dbs = dev->bar + 4096;
+	}
 
 	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
 						NVME_CAP_NSSRC(cap) : 0;
-- 
2.10.1
