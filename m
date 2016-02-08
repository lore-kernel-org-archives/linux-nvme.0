From: hch@lst.de (Christoph Hellwig)
Date: Mon,  8 Feb 2016 19:09:48 +0100
Subject: [PATCH] nvme: return the whole CQE through the request passthrough
 interface
In-Reply-To: <1454954988-32306-1-git-send-email-hch@lst.de>
References: <1454954988-32306-1-git-send-email-hch@lst.de>
Message-ID: <1454954988-32306-2-git-send-email-hch@lst.de>

See http://www.infradead.org/rpr.html

Both LighNVM and NVMe over Fabrics need to look at more than just the
status and result field.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/nvme/host/core.c | 27 +++++++++++++++++++--------
 drivers/nvme/host/nvme.h |  3 ++-
 drivers/nvme/host/pci.c  | 10 +++-------
 3 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c326931..6715bbf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -107,7 +107,6 @@ struct request *nvme_alloc_request(struct request_queue *q,
 
 	req->cmd = (unsigned char *)cmd;
 	req->cmd_len = sizeof(struct nvme_command);
-	req->special = (void *)0;
 
 	return req;
 }
@@ -117,7 +116,8 @@ struct request *nvme_alloc_request(struct request_queue *q,
  * if the result is positive, it's an NVM Express status code
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buffer, unsigned bufflen, u32 *result, unsigned timeout)
+		struct nvme_completion *cqe, void *buffer, unsigned bufflen,
+		unsigned timeout)
 {
 	struct request *req;
 	int ret;
@@ -127,6 +127,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->special = cqe;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -135,8 +136,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	}
 
 	blk_execute_rq(req->q, NULL, req, 0);
-	if (result)
-		*result = (u32)(uintptr_t)req->special;
 	ret = req->errors;
  out:
 	blk_mq_free_request(req);
@@ -146,7 +145,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, buffer, bufflen, NULL, 0);
+	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen, 0);
 }
 
 int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
@@ -155,6 +154,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		u32 *result, unsigned timeout)
 {
 	bool write = cmd->common.opcode & 1;
+	struct nvme_completion cqe;
 	struct nvme_ns *ns = q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
 	struct request *req;
@@ -167,6 +167,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	req->special = &cqe;
 
 	if (ubuffer && bufflen) {
 		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
@@ -221,7 +222,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	blk_execute_rq(req->q, disk, req, 0);
 	ret = req->errors;
 	if (result)
-		*result = (u32)(uintptr_t)req->special;
+		*result = le32_to_cpu(cqe.result);
 	if (meta && !ret && !write) {
 		if (copy_to_user(meta_buffer, meta, meta_len))
 			ret = -EFAULT;
@@ -302,6 +303,8 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 					dma_addr_t dma_addr, u32 *result)
 {
 	struct nvme_command c;
+	struct nvme_completion cqe;
+	int ret;
 
 	memset(&c, 0, sizeof(c));
 	c.features.opcode = nvme_admin_get_features;
@@ -309,13 +312,18 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
 
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0, result, 0);
+	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe, NULL, 0, 0);
+	if (ret >= 0)
+		*result = le32_to_cpu(cqe.result);
+	return ret;
 }
 
 int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 					dma_addr_t dma_addr, u32 *result)
 {
 	struct nvme_command c;
+	struct nvme_completion cqe;
+	int ret;
 
 	memset(&c, 0, sizeof(c));
 	c.features.opcode = nvme_admin_set_features;
@@ -323,7 +331,10 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0, result, 0);
+	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe, NULL, 0, 0);
+	if (ret >= 0)
+		*result = le32_to_cpu(cqe.result);
+	return ret;
 }
 
 int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4fb5bb7..d85997f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -247,7 +247,8 @@ void nvme_requeue_req(struct request *req);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buffer, unsigned bufflen,  u32 *result, unsigned timeout);
+		struct nvme_completion *cqe, void *buffer, unsigned bufflen,
+		unsigned timeout);
 int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *ubuffer, unsigned bufflen, u32 *result,
 		unsigned timeout);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72ef832..f8ae20c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -759,10 +759,8 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		}
 
 		req = blk_mq_tag_to_rq(*nvmeq->tags, cqe.command_id);
-		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
-			u32 result = le32_to_cpu(cqe.result);
-			req->special = (void *)(uintptr_t)result;
-		}
+		if (req->cmd_type == REQ_TYPE_DRV_PRIV && req->special)
+			memcpy(req->special, &cqe, sizeof(cqe));
 		blk_mq_complete_request(req, status >> 1);
 
 	}
@@ -905,12 +903,10 @@ static void abort_endio(struct request *req, int error)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = iod->nvmeq;
-	u32 result = (u32)(uintptr_t)req->special;
 	u16 status = req->errors;
 
-	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
+	dev_warn(nvmeq->q_dmadev, "Abort status 0x%x\n", status);
 	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
-
 	blk_mq_free_request(req);
 }
 
-- 
2.1.4
