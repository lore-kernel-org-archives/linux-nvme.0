From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 21:23:39 +0200
Subject: [PATCH] nvme: use an integer value to Linux errno values
Message-ID: <1444677819-23822-1-git-send-email-hch@lst.de>

Use a separate integer variable to hold the signed Linux errno
values we pass back to the block layer.  Note that for pass through
commands those might still be NVMe values, but those fit into the
int as well.

Fixes: f4829a9b7a61: ("blk-mq: fix racy updates of rq->errors")
Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a526696..9049888 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -606,8 +606,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	struct nvme_iod *iod = ctx;
 	struct request *req = iod_get_private(iod);
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
-
 	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	int error;
 
 	if (unlikely(status)) {
 		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
@@ -624,9 +624,11 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
 			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
-				status = -EINTR;
+				error = -EINTR;
+			else
+				error = status;
 		} else {
-			status = nvme_error_status(status);
+			error = nvme_error_status(status);
 		}
 	}
 
@@ -638,7 +640,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	if (cmd_rq->aborted)
 		dev_warn(nvmeq->dev->dev,
 			"completing aborted command with status:%04x\n",
-			status);
+			error);
 
 	if (iod->nents) {
 		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
@@ -652,7 +654,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	}
 	nvme_free_iod(nvmeq->dev, iod);
 
-	blk_mq_complete_request(req, status);
+	blk_mq_complete_request(req, error);
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
-- 
1.9.1
