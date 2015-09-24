From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 24 Sep 2015 13:47:08 -0600
Subject: [PATCHv2] nvme: Add error checking in nvme_create_io_queues
Message-ID: <1443124028-24573-1-git-send-email-jonathan.derrick@intel.com>

emit a warning if the first io queue fails to be allocated or
initialized

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
Currently there is no notice to the user if this failure occurs
 drivers/block/nvme-core.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b97fc3f..dcffc83 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2186,17 +2186,25 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	kfree(ns);
 }
 
-static void nvme_create_io_queues(struct nvme_dev *dev)
+static int nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i;
 
 	for (i = dev->queue_count; i <= dev->max_qid; i++)
-		if (!nvme_alloc_queue(dev, i, dev->q_depth))
+		if (!nvme_alloc_queue(dev, i, dev->q_depth)) {
+			if (dev->queue_count == 1)
+				return -ENODEV;
 			break;
+		}
 
 	for (i = dev->online_queues; i <= dev->queue_count - 1; i++)
-		if (nvme_create_queue(dev->queues[i], i))
+		if (nvme_create_queue(dev->queues[i], i)) {
+			if (dev->online_queues == 1)
+				return -ENODEV;
 			break;
+		}
+
+	return 0;
 }
 
 static int set_queue_count(struct nvme_dev *dev, int count)
@@ -2350,7 +2358,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	/* Free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, nr_io_queues + 1);
-	nvme_create_io_queues(dev);
+	result = nvme_create_io_queues(dev);
+	if (result)
+		dev_warn(dev->dev, "Failed to create io queues\n");
 
 	return 0;
 
-- 
2.5.0
