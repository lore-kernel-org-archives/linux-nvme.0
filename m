From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 Dec 2013 13:10:39 -0700
Subject: [PATCH 4/5] NVMe: Surprise removal handling
In-Reply-To: <1386706240-2300-1-git-send-email-keith.busch@intel.com>
References: <1386706240-2300-1-git-send-email-keith.busch@intel.com>
Message-ID: <1386706240-2300-5-git-send-email-keith.busch@intel.com>

This adds checks to see if the nvme pci device was removed. The check
reads the status register for the value of -1, which it should never be
unless the device is no longer present.

If a user performs a surprise removal on an nvme device, the driver will
be notified either by the pci driver remove callback if the platform's
slot is capable of this event, or via reading the device BAR status
register, which will indicate controller failure and trigger a reset.

Either way, the device is not present so all outstanding commands would
timeout. This will not send queue deletion commands to a drive that
isn't present and fail after ioremap, significantly speeding up surprise
removal; previously this took over 2 minutes per IO queue pair created,
but this will complete removing the device within a few seconds.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 120cfe3..db4e07b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1140,8 +1140,9 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
-	/* Don't tell the adapter to delete the admin queue */
-	if (qid) {
+	/* Don't tell the adapter to delete the admin queue.
+	 * Don't tell a removed adapter to delete IO queues. */
+	if (qid && readl(&dev->bar->csts) != -1) {
 		adapter_delete_sq(dev, qid);
 		adapter_delete_cq(dev, qid);
 	}
@@ -2039,12 +2040,17 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
 	if (!dev->bar)
 		goto disable;
-
+	if (readl(&dev->bar->csts) == -1) {
+		result = -ENODEV;
+		goto unmap;
+	}
 	dev->db_stride = NVME_CAP_STRIDE(readq(&dev->bar->cap));
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
 
 	return 0;
-
+ unmap:
+	iounmap(dev->bar);
+	dev->bar = NULL;
  disable:
 	pci_release_regions(pdev);
  disable_pci:
-- 
1.7.10.4
