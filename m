From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:39 +0100
Subject: [PATCH 04/26] nvme: protect against simultaneous shutdown invocations
In-Reply-To: <1448995981-11982-1-git-send-email-hch@lst.de>
References: <1448995981-11982-1-git-send-email-hch@lst.de>
Message-ID: <1448995981-11982-5-git-send-email-hch@lst.de>

From: Keith Busch <keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d82f08d..ad6d5cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -31,6 +31,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/poison.h>
 #include <linux/ptrace.h>
@@ -113,6 +114,7 @@ struct nvme_dev {
 	struct work_struct reset_work;
 	struct work_struct probe_work;
 	struct work_struct scan_work;
+	struct mutex shutdown_lock;
 	bool subsystem;
 	void __iomem *cmb;
 	dma_addr_t cmb_dma_addr;
@@ -2073,6 +2075,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	nvme_dev_list_remove(dev);
 
+	mutex_lock(&dev->shutdown_lock);
 	if (dev->bar) {
 		nvme_freeze_queues(dev);
 		csts = readl(dev->bar + NVME_REG_CSTS);
@@ -2091,6 +2094,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_clear_queue(dev->queues[i]);
+	mutex_unlock(&dev->shutdown_lock);
 }
 
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
@@ -2333,6 +2337,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->probe_work, nvme_probe_work);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
+	mutex_init(&dev->shutdown_lock);
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-- 
1.9.1
