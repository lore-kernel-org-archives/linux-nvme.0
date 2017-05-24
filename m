From: yu.a.xu@intel.com (Xu Yu)
Date: Wed, 24 May 2017 16:39:55 +0800
Subject: [PATCH v3] nvme/pci: remap BAR0 to cover admin CQ doorbell for large
 stride
Message-ID: <1495615195-2304-1-git-send-email-yu.a.xu@intel.com>

The existing driver initially maps 8192 bytes of BAR0 which is
intended to cover doorbells of admin SQ and CQ. However, if a
large stride, e.g. 10, is used, the doorbell of admin CQ will
be out of 8192 bytes. Consequently, a page fault will be raised
when the admin CQ doorbell is accessed in nvme_configure_admin_queue().

This patch fixes this issue by remapping BAR0 before accessing
admin CQ doorbell if the initial mapping is not enough.

Signed-off-by: Xu Yu <yu.a.xu at intel.com>
---
Changes since v2:
* Add a sanity check in nvme_remap_bar().
* Keep constant 4096 in nvme_dev_map().
Changes since v1:
* Move the bar (re)mapping logic in nvme_dev_map(), nvme_configure_admin_queue()
and nvme_setup_io_queues() to a new helper nvme_remap_bar().
* Replace several magic numbers by PAGE_SIZE and the new NVME_REG_DBS.
---
 drivers/nvme/host/pci.c | 65 ++++++++++++++++++++++++++++++++-----------------
 include/linux/nvme.h    |  1 +
 2 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9d4640a..2c24046 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -91,6 +91,7 @@ struct nvme_dev {
 	int q_depth;
 	u32 db_stride;
 	void __iomem *bar;
+	unsigned long bar_mapped_size;
 	struct work_struct reset_work;
 	struct work_struct remove_work;
 	struct timer_list watchdog_timer;
@@ -1316,6 +1317,32 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 	return 0;
 }
 
+static unsigned long db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
+{
+	return NVME_REG_DBS + ((nr_io_queues + 1) * 8 * dev->db_stride);
+}
+
+static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (size <= dev->bar_mapped_size)
+		return 0;
+	if (size > pci_resource_len(pdev, 0))
+		return -ENOMEM;
+	if (dev->bar)
+		iounmap(dev->bar);
+	dev->bar = ioremap(pci_resource_start(pdev, 0), size);
+	if (!dev->bar) {
+		dev->bar_mapped_size = 0;
+		return -ENOMEM;
+	}
+	dev->bar_mapped_size = size;
+	dev->dbs = dev->bar + NVME_REG_DBS;
+
+	return 0;
+}
+
 static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result;
@@ -1323,6 +1350,10 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u64 cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 	struct nvme_queue *nvmeq;
 
+	result = nvme_remap_bar(dev, db_bar_size(dev, 0));
+	if (result < 0)
+		return result;
+
 	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
 						NVME_CAP_NSSRC(cap) : 0;
 
@@ -1514,16 +1545,12 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	}
 }
 
-static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
-{
-	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
-}
-
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int result, nr_io_queues, size;
+	int result, nr_io_queues;
+	unsigned long size;
 
 	nr_io_queues = num_online_cpus();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
@@ -1542,20 +1569,15 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 			nvme_release_cmb(dev);
 	}
 
-	size = db_bar_size(dev, nr_io_queues);
-	if (size > 8192) {
-		iounmap(dev->bar);
-		do {
-			dev->bar = ioremap(pci_resource_start(pdev, 0), size);
-			if (dev->bar)
-				break;
-			if (!--nr_io_queues)
-				return -ENOMEM;
-			size = db_bar_size(dev, nr_io_queues);
-		} while (1);
-		dev->dbs = dev->bar + 4096;
-		adminq->q_db = dev->dbs;
-	}
+	do {
+		size = db_bar_size(dev, nr_io_queues);
+		result = nvme_remap_bar(dev, size);
+		if (!result)
+			break;
+		if (!--nr_io_queues)
+			return -ENOMEM;
+	} while (1);
+	adminq->q_db = dev->dbs;
 
 	/* Deregister the admin queue's interrupt */
 	free_irq(pci_irq_vector(pdev, 0), adminq);
@@ -2061,8 +2083,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	if (pci_request_mem_regions(pdev, "nvme"))
 		return -ENODEV;
 
-	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
-	if (!dev->bar)
+	if (nvme_remap_bar(dev, NVME_REG_DBS + 4096))
 		goto release;
 
 	return 0;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bac..7715be4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -101,6 +101,7 @@ enum {
 	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
 	NVME_REG_CMBLOC = 0x0038,	/* Controller Memory Buffer Location */
 	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
+	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
 };
 
 #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
-- 
1.9.1
