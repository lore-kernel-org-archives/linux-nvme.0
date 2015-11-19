From: keith.busch@intel.com (Keith Busch)
Date: Thu, 19 Nov 2015 21:41:57 +0000
Subject: [PATCH] nvme: allow queues the chance to quiesce after
 freezing them
In-Reply-To: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
References: <1447960312-2245-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20151119214156.GA22690@localhost.localdomain>

On Thu, Nov 19, 2015@12:11:52PM -0700, Jon Derrick wrote:
> A panic was discovered while doing io and hitting the sysfs reset.
> Because io was completing successfully, the nvme_dev_shutdown code
> detected this non-idle state as a stuck state and started to tear down
> the queues. This resulted in a paging error when nvme_process_cq wrote
> the doorbell of a deleted queue.
> 
> This patch allows some time after starting the queue freeze for queues
> to quiesce on their own. It also sets a new nvme_queue member, frozen,
> to prevent writing of the cq doorbell. If the queues successfully
> quiesce, nvme_process_cq will run upon resuming. If the queues don't
> quiesce, existing code considers it a dead controller and is torn down.

I think all we really want is skip notifying completions on a
"suspended" queue. We can tell by the value of the cq-vector,
and it's already lock protected.

It also sounds like we need to poll the cq after the delete completes
to catch successful completions before we force cancel the rest.

This appears to work for me. Does it pass your test?
---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 394fd16..930042fa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -968,7 +968,8 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return;
 
-	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	if (likely(nvmeq->cq_vector >= 0))
+		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -2787,6 +2788,10 @@ static void nvme_del_queue_end(struct nvme_queue *nvmeq)
 {
 	struct nvme_delq_ctx *dq = nvmeq->cmdinfo.ctx;
 	nvme_put_dq(dq);
+
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
 }
 
 static int adapter_async_del_queue(struct nvme_queue *nvmeq, u8 opcode,
--
