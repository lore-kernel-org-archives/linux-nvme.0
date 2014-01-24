From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jan 2014 16:50:50 -0700
Subject: [PATCH 3/7] NVMe: Initialization clean-up
In-Reply-To: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
References: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
Message-ID: <1390607454-23273-4-git-send-email-keith.busch@intel.com>

Just cleaning up harmless but unnecessary initialization code in queue
allocation and initialization.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e27f8d7..e9a4acc 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1245,12 +1245,9 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_dmadev = dmadev;
 	nvmeq->dev = dev;
 	spin_lock_init(&nvmeq->q_lock);
-	nvmeq->cq_head = 0;
-	nvmeq->cq_phase = 1;
 	init_waitqueue_head(&nvmeq->sq_full);
 	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	bio_list_init(&nvmeq->sq_cong);
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
 	nvmeq->qid = qid;
@@ -1289,7 +1286,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset(nvmeq->cmdid_data, 0, extra);
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
-	nvme_cancel_ios(nvmeq, false);
 	nvmeq->q_suspended = 0;
 }
 
-- 
1.7.10.4
