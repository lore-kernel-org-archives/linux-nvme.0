From: hch@lst.de (Christoph Hellwig)
Date: Thu, 30 Mar 2017 13:41:31 +0200
Subject: [PATCH 1/2] nvme-fc: drop ctrl for all command completions
Message-ID: <20170330114132.27292-1-hch@lst.de>

A requeue means we go through nvme_fc_start_fcp_op again and get
another controller reference.  To make sure the refcount doesn't
leak we also need to drop it for every completion that came from
the LLDD.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2987f5ecd496..48a5557028e2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1937,7 +1937,7 @@ nvme_fc_complete_rq(struct request *rq)
 		if (nvme_req_needs_retry(rq, rq->errors)) {
 			rq->retries++;
 			nvme_requeue_req(rq);
-			return;
+			goto put_ctrl;
 		}
 
 		if (blk_rq_is_passthrough(rq))
@@ -1946,9 +1946,10 @@ nvme_fc_complete_rq(struct request *rq)
 			error = nvme_error_status(rq->errors);
 	}
 
+	blk_mq_end_request(rq, error);
+put_ctrl:
 	nvme_fc_ctrl_put(ctrl);
 
-	blk_mq_end_request(rq, error);
 }
 
 static struct blk_mq_ops nvme_fc_mq_ops = {
-- 
2.11.0
