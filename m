From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 30 Jun 2015 11:22:52 -0600
Subject: [PATCH] NVMe: Fix irq freeing when queue_request_irq fails
Message-ID: <1435684972-4245-1-git-send-email-jonathan.derrick@intel.com>

Fixes an issue when queue_reuest_irq fails in nvme_setup_io_queues. This
patch initializes all vectors to -1 and resets the vector to -1 in the
case of a failure in queue_request_irq. This avoids the free_irq in
nvme_suspend_queue if the queue did not get an irq.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/block/nvme-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 34338d7..d1d6141 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1474,6 +1474,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
+	nvmeq->cq_vector = -1;
 	dev->queues[qid] = nvmeq;
 
 	/* make sure queue descriptor is set before queue count, for kthread */
@@ -1726,8 +1727,10 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	nvmeq->cq_vector = 0;
 	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
-	if (result)
+	if (result) {
+		nvmeq->cq_vector = -1;
 		goto free_nvmeq;
+	}
 
 	return result;
 
@@ -2213,8 +2216,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->max_qid = nr_io_queues;
 
 	result = queue_request_irq(dev, adminq, adminq->irqname);
-	if (result)
+	if (result) {
+		adminq->cq_vector = -1;
 		goto free_queues;
+	}
 
 	/* Free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, nr_io_queues + 1);
-- 
2.1.4
