From: keith.busch@intel.com (Keith Busch)
Date: Fri,  9 Dec 2016 12:08:58 -0500
Subject: [PATCH] nvme/pci: Delete misleading queue-wrap comment
Message-ID: <1481303338-25134-1-git-send-email-keith.busch@intel.com>

It is not theoretically possible for this driver to wrap twice while
processing completions. The driver allocates only 'queue_depth - 1'
tags, so there can never be more than that to reap when processing a
completion queue. Removing this misleading comment makes it a little
less likely people with broken controllers will blame the driver for
their spurious interrupts.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e179cf..ec4d445 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -712,15 +712,8 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
 		nvme_req(req)->result = cqe.result;
 		blk_mq_complete_request(req, le16_to_cpu(cqe.status) >> 1);
-
 	}
 
-	/* If the controller ignores the cq head doorbell and continuously
-	 * writes to the queue, it is theoretically possible to wrap around
-	 * the queue twice and mistakenly return IRQ_NONE.  Linux only
-	 * requires that 0.1% of your interrupts are handled, so this isn't
-	 * a big problem.
-	 */
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return;
 
-- 
2.5.5
