From: hch@lst.de (Christoph Hellwig)
Date: Fri,  2 Oct 2015 19:58:18 +0200
Subject: [PATCH 6/7] nvme: properly handle partially initialized queues in
 nvme_create_io_queues
In-Reply-To: <1443808699-4738-1-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
Message-ID: <1443808699-4738-7-git-send-email-hch@lst.de>

This avoids having to clean up later in a seemingly unrelated place.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c35ead3..48688d6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2191,6 +2191,13 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 	kfree(ns);
 }
 
+/*
+ * Create I/O queues.  Failing to create an I/O queue is not an issue,
+ * we can continue with less than the desired amount of queues, and
+ * even a controller without I/O queues an still be used to issue
+ * admin commands.  This might be useful to upgrade a buggy firmware
+ * for example.
+ */
 static void nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i;
@@ -2200,8 +2207,10 @@ static void nvme_create_io_queues(struct nvme_dev *dev)
 			break;
 
 	for (i = dev->online_queues; i <= dev->queue_count - 1; i++)
-		if (nvme_create_queue(dev->queues[i], i))
+		if (nvme_create_queue(dev->queues[i], i)) {
+			nvme_free_queues(dev, i);
 			break;
+		}
 }
 
 static int set_queue_count(struct nvme_dev *dev, int count)
@@ -2998,9 +3007,12 @@ static void nvme_probe_work(struct work_struct *work)
 
 	dev->event_limit = 1;
 
+	/*
+	 * Keep the controller around but remove all namespaces if we don't have
+	 * any working I/O queue.
+	 */
 	if (dev->online_queues < 2) {
 		dev_warn(dev->dev, "IO queues not created\n");
-		nvme_free_queues(dev, 1);
 		nvme_dev_remove(dev);
 	} else {
 		nvme_unfreeze_queues(dev);
-- 
1.9.1
