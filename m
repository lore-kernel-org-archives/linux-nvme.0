From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jun 2014 11:18:12 -0600
Subject: [PATCHv2] NVMe: Skip orderly shutdown on failed devices
Message-ID: <1403716692-1556-1-git-send-email-keith.busch@intel.com>

Rather than skipping shutdown only for device's that have been removed,
skip the orderly shutdown on failed devices to avoid the long timeout
handling that inevitably happens when deleting queues on such a device.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1->v2:

Cleaned up the logic for checking the controller status.

Added check for device not ready and skip shutdown there as well.

 drivers/block/nvme-core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b634233..e62a9c5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2521,11 +2521,14 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
 	int i;
+	u32 csts = -1;
 
 	dev->initialized = 0;
 	nvme_dev_list_remove(dev);
 
-	if (!dev->bar || (dev->bar && readl(&dev->bar->csts) == -1)) {
+	if (dev->bar)
+		csts = readl(&dev->bar->csts);
+	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
 		for (i = dev->queue_count - 1; i >= 0; i--) {
 			struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
 			nvme_suspend_queue(nvmeq);
-- 
1.7.10.4
