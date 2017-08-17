From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Aug 2017 16:45:06 -0400
Subject: [PATCH] nvme/pci: Set cqe_seen on polled completions
Message-ID: <1503002706-32394-1-git-send-email-keith.busch@intel.com>

Fixes: 920d13a884 ("nvme-pci: factor out the cqe reading mechanics from __nvme_process_cq")

Reported-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ea5eb4c..e9886e1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -795,6 +795,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
+	nvmeq->cqe_seen = 1;
 	req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
 	nvme_end_request(req, cqe->status, cqe->result);
 }
@@ -824,10 +825,8 @@ static void nvme_process_cq(struct nvme_queue *nvmeq)
 		consumed++;
 	}
 
-	if (consumed) {
+	if (consumed)
 		nvme_ring_cq_doorbell(nvmeq);
-		nvmeq->cqe_seen = 1;
-	}
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
-- 
2.5.5
