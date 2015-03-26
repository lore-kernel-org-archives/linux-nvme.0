From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Mar 2015 13:49:33 -0600
Subject: [PATCH] NVMe: Freeze admin queue on device failure
Message-ID: <1427399373-19746-1-git-send-email-keith.busch@intel.com>

This fixes a race accessing an invalid address when a controller's admin
queue is in use during a reset for failure or hot removal occurs. The
admin queue will be frozen to prevent new users from entering prior to
the doorbell queue being unmapped.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 94832e1..e8baffa 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1344,6 +1344,9 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
 
+	if (!nvmeq->qid && nvmeq->dev->admin_q)
+		blk_mq_freeze_queue_start(nvmeq->dev->admin_q);
+
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
@@ -1375,8 +1378,6 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 		adapter_delete_sq(dev, qid);
 		adapter_delete_cq(dev, qid);
 	}
-	if (!qid && dev->admin_q)
-		blk_mq_freeze_queue_start(dev->admin_q);
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
-- 
1.7.10.4
