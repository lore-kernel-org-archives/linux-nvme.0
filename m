From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:14 -0600
Subject: [PATCH 8/9] NVMe: Set queue db only when queue is initialized
In-Reply-To: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
Message-ID: <1378413915-16667-9-git-send-email-keith.busch@intel.com>

There is no need to set it when the queue is allocated as it can't be
used until it is created in the controller. We may initialized a queue
multiple times, but allocate it only once, so we have to set the queue
doorbell address each time it is initialized.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d09ef43..2c99e17 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1175,7 +1175,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	init_waitqueue_head(&nvmeq->sq_full);
 	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	bio_list_init(&nvmeq->sq_cong);
-	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
 	nvmeq->qid = qid;
-- 
1.7.0.4
