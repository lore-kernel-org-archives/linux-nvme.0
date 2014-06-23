From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Jun 2014 11:46:35 -0600
Subject: [PATCH] NVMe: Skip orderly shutdown on failed devices
Message-ID: <1403545595-525-1-git-send-email-keith.busch@intel.com>

Rather than skipping shutdown only for device's that have been removed,
skip the orderly shutdown on failed devices to avoid the long timeout
handling that inevitably happens when deleting queues on such a device.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b634233..30b7f64 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2525,7 +2525,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	dev->initialized = 0;
 	nvme_dev_list_remove(dev);
 
-	if (!dev->bar || (dev->bar && readl(&dev->bar->csts) == -1)) {
+	if (!dev->bar || (dev->bar && readl(&dev->bar->csts) & NVME_CSTS_CFS)) {
 		for (i = dev->queue_count - 1; i >= 0; i--) {
 			struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
 			nvme_suspend_queue(nvmeq);
-- 
1.7.10.4
