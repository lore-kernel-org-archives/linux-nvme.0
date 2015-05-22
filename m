From: parav.pandit@avagotech.com (Parav Pandit)
Date: Thu, 21 May 2015 20:12:33 -0400
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
Message-ID: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>

Avoid diabling interrupt and holding q_lock for the queue
which is just getting initialized.

With this change, online_queues is also incremented without
lock during queue setup stage.
if Power management nvme_suspend() kicks in during queue setup time,
per nvmeq based q_lock spinlock cannot protect device wide
online_queues variable anyway.

Signed-off-by: Parav Pandit <parav.pandit at avagotech.com>
---
 drivers/block/nvme-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 58041c7..7f09e5e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1437,14 +1437,12 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-	spin_lock_irq(&nvmeq->q_lock);
 	nvmeq->sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	dev->online_queues++;
-	spin_unlock_irq(&nvmeq->q_lock);
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
-- 
1.8.3.1
