From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 03:41:53 +0900
Subject: [PATCH 2/4] nvme: check admin queue with ctrl->admin_q, not rq_disk
In-Reply-To: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
References: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
Message-ID: <20190727184155.18014-3-minwoo.im.dev@gmail.com>

It used to figure out whether the given request is about the admin queue
or not by the req->rq_disk only.  But, in case of lightnvm, the request
may not have rq_disk mapped so that we just can't return the proper qid
for the I/O NVM commands like Vector Chunk Read/Write.

This patch replaces the condition from rq_disk to check
nvme_ctrl->admin_q and the given request_queue from the request itself.

This patch also moved nvme_req_qid() right next to struct nvme_ctrl to
have it inside.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Matias Bj?rling <mb at lightnvm.io>
Cc: Javier Gonz?lez <javier at javigon.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/nvme.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2e76198f5833..60c1abf8dce1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -122,13 +122,6 @@ static inline struct nvme_request *nvme_req(struct request *req)
 	return blk_mq_rq_to_pdu(req);
 }
 
-static inline u16 nvme_req_qid(struct request *req)
-{
-	if (!req->rq_disk)
-		return 0;
-	return req->mq_hctx->queue_num + 1;
-}
-
 /* The below value is the specific amount of delay needed before checking
  * readiness in case of the PCI_DEVICE(0x1c58, 0x0003), which needs the
  * NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk enabled. The value (in ms) was
@@ -260,6 +253,15 @@ struct nvme_ctrl {
 	struct nvme_fault_inject fault_inject;
 };
 
+static inline u16 nvme_req_qid(struct request *req)
+{
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+
+	if (req->q == ctrl->admin_q)
+		return 0;
+	return req->mq_hctx->queue_num + 1;
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.17.1
