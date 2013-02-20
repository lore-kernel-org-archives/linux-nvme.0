From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:43 -0700
Subject: [PATCH 6/8] NVMe: Wait for controller status ready to clear
In-Reply-To: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
Message-ID: <1361404365-18982-6-git-send-email-keith.busch@intel.com>

The nvme spec specifies potentially undefined results if we continue
to use the driver after clearing enable but not waiting for CSTS.RDY to
clear. This waits for ready status to clear before proceeding.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 199c182..0acccc1 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1045,6 +1045,20 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	unsigned long timeout;
 	struct nvme_queue *nvmeq;
 
+	cap = readq(&dev->bar->cap);
+	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+	writel(0, &dev->bar->cc);
+	while (!result && (readl(&dev->bar->csts) & NVME_CSTS_RDY)) {
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(&dev->pci_dev->dev,
+				"Device still ready; aborting initialisation\n");
+			return -ENODEV;
+		}
+	}
+
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
 
 	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
@@ -1059,13 +1073,11 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
-	writel(0, &dev->bar->cc);
 	writel(aqa, &dev->bar->aqa);
 	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
 	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
 	writel(dev->ctrl_config, &dev->bar->cc);
 
-	cap = readq(&dev->bar->cap);
 	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
 	dev->db_stride = NVME_CAP_STRIDE(cap);
 
-- 
1.7.0.4
