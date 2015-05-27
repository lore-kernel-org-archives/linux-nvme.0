From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 27 May 2015 12:26:23 -0600
Subject: [PATCH] NVMe: Memory barrier before queue_count is incremented
Message-ID: <1432751183-20199-1-git-send-email-jonathan.derrick@intel.com>

Protects against reordering and/or preempting which would allow the
kthread to access the queue descriptor before it is set up

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/block/nvme-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c42bc53..2b0c817 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1463,9 +1463,12 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
-	dev->queue_count++;
 	dev->queues[qid] = nvmeq;
 
+	/* make sure queue descriptor is set before queue count, for kthread */
+	mb();
+	dev->queue_count++;
+
 	return nvmeq;
 
  free_cqdma:
-- 
2.1.4
