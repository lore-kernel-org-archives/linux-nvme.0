From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 09:45:03 +0100
Subject: [PATCH 09/12] nvme: properly free resources for cancelled command
In-Reply-To: <1446885906-20967-1-git-send-email-hch@lst.de>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
Message-ID: <1446885906-20967-10-git-send-email-hch@lst.de>

We need to move freeing of resources to the ->complete handler to ensure
they are also freed when we cancel the command.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 86 +++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 03b8a3c..a5ee159 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -76,12 +76,10 @@ static wait_queue_head_t nvme_kthread_wait;
 
 struct nvme_dev;
 struct nvme_queue;
-struct nvme_iod;
 
 static int nvme_reset(struct nvme_dev *dev);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
-static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_iod *iod);
 
 struct async_cmd_info {
 	struct kthread_work work;
@@ -483,42 +481,6 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
 }
 #endif
 
-static void req_completion(struct nvme_queue *nvmeq, struct nvme_completion *cqe)
-{
-	struct request *req = blk_mq_tag_to_rq(*nvmeq->tags, cqe->command_id);
-	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
-	struct nvme_iod *iod = cmd_rq->iod;
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-	int error = 0;
-
-	if (unlikely(status)) {
-		if (nvme_req_needs_retry(req, status)) {
-			nvme_unmap_data(nvmeq->dev, iod);
-			nvme_requeue_req(req);
-			return;
-		}
-
-		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-			error = status;
-		} else {
-			error = nvme_error_status(status);
-		}
-	}
-
-	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-		u32 result = le32_to_cpup(&cqe->result);
-		req->special = (void *)(uintptr_t)result;
-	}
-
-	if (cmd_rq->aborted)
-		dev_warn(nvmeq->dev->dev,
-			"completing aborted command with status:%04x\n",
-			error);
-
-	nvme_unmap_data(nvmeq->dev, iod);
-	blk_mq_complete_request(req, error);
-}
-
 static bool nvme_setup_prps(struct nvme_dev *dev, struct nvme_iod *iod,
 		int total_len)
 {
@@ -760,6 +722,43 @@ out:
 	return ret;
 }
 
+static void nvme_complete_rq(struct request *req)
+{
+	struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev = cmd->nvmeq->dev;
+	int error = 0;
+
+	nvme_unmap_data(dev, cmd->iod);
+
+	if (unlikely(req->errors)) {
+		/*
+		 * Some silly Intel userspace code breaks if it doesn't get a
+		 * negative errno back for driver returns values.
+		 */
+		if (req->errors < 0) {
+			error = req->errors;
+		} else {
+			if (nvme_req_needs_retry(req, req->errors)) {
+				nvme_requeue_req(req);
+				return;
+			}
+
+			if (req->cmd_type == REQ_TYPE_DRV_PRIV)
+				error = req->errors;
+			else
+				error = nvme_error_status(req->errors);
+		}
+	}
+
+	if (cmd->aborted) {
+		dev_warn(dev->dev,
+			"completing aborted command with status:%04x\n",
+			req->errors);
+	}
+
+	blk_mq_end_request(req, error);
+}
+
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
 	u16 head, phase;
@@ -770,6 +769,7 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	for (;;) {
 		struct nvme_completion cqe = nvmeq->cqes[head];
 		u16 status = le16_to_cpu(cqe.status);
+		struct request *req;
 
 		if ((status & 1) != phase)
 			break;
@@ -798,7 +798,13 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 			continue;
 		}
 
-		req_completion(nvmeq, &cqe);
+		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
+		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
+			u32 result = le32_to_cpu(cqe.result);
+			req->special = (void *)(uintptr_t)result;
+		}
+		blk_mq_complete_request(req, status >> 1);
+
 	}
 
 	/* If the controller ignores the cq head doorbell and continuously
@@ -1297,6 +1303,7 @@ static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 
 static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.complete	= nvme_complete_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
 	.exit_hctx      = nvme_admin_exit_hctx,
@@ -1306,6 +1313,7 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 
 static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
+	.complete	= nvme_complete_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
-- 
1.9.1
