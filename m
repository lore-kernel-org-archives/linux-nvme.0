From: hch@lst.de (Christoph Hellwig)
Date: Mon, 17 Aug 2015 21:09:39 +0200
Subject: [PATCH 1/2] nvme: remove spurious use of *_to_cpup helpers
In-Reply-To: <1439838580-29647-1-git-send-email-hch@lst.de>
References: <1439838580-29647-1-git-send-email-hch@lst.de>
Message-ID: <1439838580-29647-2-git-send-email-hch@lst.de>

Switch to the normal endianess helpers that take an integer instead of
the pointer to it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 28 ++++++++++++++--------------
 drivers/block/nvme-scsi.c |  2 +-
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 666e994..8a27893 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -281,13 +281,13 @@ static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 	if (ctx == CMD_CTX_COMPLETED) {
 		dev_warn(nvmeq->q_dmadev,
 				"completed id %d twice on queue %d\n",
-				cqe->command_id, le16_to_cpup(&cqe->sq_id));
+				cqe->command_id, le16_to_cpu(cqe->sq_id));
 		return;
 	}
 	if (ctx == CMD_CTX_INVALID) {
 		dev_warn(nvmeq->q_dmadev,
 				"invalid id %d completed on queue %d\n",
-				cqe->command_id, le16_to_cpup(&cqe->sq_id));
+				cqe->command_id, le16_to_cpu(cqe->sq_id));
 		return;
 	}
 	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n", ctx);
@@ -308,8 +308,8 @@ static void *cancel_cmd_info(struct nvme_cmd_info *cmd, nvme_completion_fn *fn)
 static void async_req_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
-	u32 result = le32_to_cpup(&cqe->result);
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	u32 result = le32_to_cpu(cqe->result);
+	u16 status = le16_to_cpu(cqe->status) >> 1;
 
 	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
 		++nvmeq->dev->event_limit;
@@ -330,8 +330,8 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 {
 	struct request *req = ctx;
 
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
-	u32 result = le32_to_cpup(&cqe->result);
+	u16 status = le16_to_cpu(cqe->status) >> 1;
+	u32 result = le32_to_cpu(cqe->result);
 
 	blk_mq_free_request(req);
 
@@ -343,8 +343,8 @@ static void async_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct async_cmd_info *cmdinfo = ctx;
-	cmdinfo->result = le32_to_cpup(&cqe->result);
-	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	cmdinfo->result = le32_to_cpu(cqe->result);
+	cmdinfo->status = le16_to_cpu(cqe->status) >> 1;
 	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
 	blk_mq_free_request(cmdinfo->req);
 }
@@ -607,7 +607,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	struct request *req = iod_get_private(iod);
 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
 
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	u16 status = le16_to_cpu(cqe->status) >> 1;
 
 	if (unlikely(status)) {
 		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
@@ -632,7 +632,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	} else
 		req->errors = 0;
 	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-		u32 result = le32_to_cpup(&cqe->result);
+		u32 result = le32_to_cpu(cqe->result);
 		req->special = (void *)(uintptr_t)result;
 	}
 
@@ -2031,7 +2031,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (ns->ms && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
 	else
-		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
+		set_capacity(disk, le64_to_cpu(id->nsze) << (ns->lba_shift - 9));
 
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
@@ -2430,7 +2430,7 @@ static void nvme_dev_scan(struct work_struct *work)
 		return;
 	if (nvme_identify_ctrl(dev, &ctrl))
 		return;
-	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
+	nvme_scan_namespaces(dev, le32_to_cpu(ctrl->nn));
 	kfree(ctrl);
 }
 
@@ -2454,8 +2454,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		return -EIO;
 	}
 
-	nn = le32_to_cpup(&ctrl->nn);
-	dev->oncs = le16_to_cpup(&ctrl->oncs);
+	nn = le32_to_cpu(ctrl->nn);
+	dev->oncs = le16_to_cpu(ctrl->oncs);
 	dev->abort_limit = ctrl->acl + 1;
 	dev->vwc = ctrl->vwc;
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index e5a63f0..800427b 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1178,7 +1178,7 @@ static void nvme_trans_fill_read_cap(u8 *response, struct nvme_id_ns *id_ns,
 
 	flbas = (id_ns->flbas) & 0x0F;
 	lba_length = (1 << (id_ns->lbaf[flbas].ds));
-	rlba = le64_to_cpup(&id_ns->nsze) - 1;
+	rlba = le64_to_cpu(id_ns->nsze) - 1;
 	(id_ns->dps) ? (prot_en = 0x01) : (prot_en = 0);
 
 	if (!cdb16) {
-- 
1.9.1
