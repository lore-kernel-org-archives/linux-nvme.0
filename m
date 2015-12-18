From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Dec 2015 17:08:15 -0700
Subject: [PATCH 2/2] NVMe: Fix possible queue use after freed
In-Reply-To: <1450397295-24031-1-git-send-email-keith.busch@intel.com>
References: <1450397295-24031-1-git-send-email-keith.busch@intel.com>
Message-ID: <1450397295-24031-2-git-send-email-keith.busch@intel.com>

This notifies blk-mq when the tag set contains a different number of
queues prior to freeing unused ones that the request queue points to.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b82bbea..b03631c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1392,7 +1392,7 @@ static int nvme_kthread(void *data)
 
 static int nvme_create_io_queues(struct nvme_dev *dev)
 {
-	unsigned i;
+	unsigned i, max;
 	int ret = 0;
 
 	for (i = dev->queue_count; i <= dev->max_qid; i++) {
@@ -1402,7 +1402,8 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 		}
 	}
 
-	for (i = dev->online_queues; i <= dev->queue_count - 1; i++) {
+	max = min(dev->max_qid, dev->queue_count - 1);
+	for (i = dev->online_queues; i <= max; i++) {
 		ret = nvme_create_queue(dev->queues[i], i);
 		if (ret) {
 			nvme_free_queues(dev, i);
@@ -1559,9 +1560,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		adminq->cq_vector = -1;
 		goto free_queues;
 	}
-
-	/* Free previously allocated queues that are no longer usable */
-	nvme_free_queues(dev, nr_io_queues + 1);
 	return nvme_create_io_queues(dev);
 
  free_queues:
@@ -1617,7 +1615,13 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
+	} else {
+		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
+
+		/* Free previously allocated queues that are no longer usable */
+		nvme_free_queues(dev, dev->online_queues);
 	}
+
 	queue_work(nvme_workq, &dev->scan_work);
 	return 0;
 }
-- 
2.6.2.307.g37023ba
