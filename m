From: sbradshaw@micron.com (Sam Bradshaw)
Date: Wed, 21 May 2014 11:14:25 -0700
Subject: [PATCH] NVMe: Remove superfluous cqe_seen
Message-ID: <537CED01.6040106@micron.com>

cqe_seen is redundant with the return value from nvme_process_cq().
Remove it.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc..c2287ac 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -102,7 +102,6 @@ struct nvme_queue {
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
-	u8 cqe_seen;
 	u8 q_suspended;
 	cpumask_var_t cpu_mask;
 	struct async_cmd_info cmdinfo;
@@ -790,7 +789,6 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
-	nvmeq->cqe_seen = 1;
 	return 1;
 }
 
@@ -826,8 +824,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 	struct nvme_queue *nvmeq = data;
 	spin_lock(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
-	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
-	nvmeq->cqe_seen = 0;
+	result = nvme_process_cq(nvmeq) ? IRQ_HANDLED : IRQ_NONE;
 	spin_unlock(&nvmeq->q_lock);
 	return result;
 }
