From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  5 Jun 2015 14:54:23 +0200
Subject: [PATCH v4 1/8] nvme: add special param for nvme_submit_sync_cmd
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <1433508870-28251-2-git-send-email-m@bjorling.me>

In preparation for LightNVM, it requires a hook for internal commands
to resolve its state on command completion. Use req->special for this
and move the command result to req->sense.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/nvme-core.c | 19 ++++++++++---------
 drivers/block/nvme-scsi.c |  4 ++--
 include/linux/nvme.h      |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 6ed1356..d2955fe 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -614,7 +614,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 		req->errors = 0;
 	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
 		u32 result = le32_to_cpup(&cqe->result);
-		req->special = (void *)(uintptr_t)result;
+		req->sense = (void *)(uintptr_t)result;
 	}
 
 	if (cmd_rq->aborted)
@@ -998,7 +998,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, void __user *ubuffer, unsigned bufflen,
-		u32 *result, unsigned timeout)
+		u32 *result, unsigned timeout, void *special)
 {
 	bool write = cmd->common.opcode & 1;
 	struct bio *bio = NULL;
@@ -1019,7 +1019,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 
 	req->cmd = (unsigned char *)cmd;
 	req->cmd_len = sizeof(struct nvme_command);
-	req->special = (void *)0;
+	req->special = special;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, __GFP_WAIT);
@@ -1036,7 +1036,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (bio)
 		blk_rq_unmap_user(bio);
 	if (result)
-		*result = (u32)(uintptr_t)req->special;
+		*result = (u32)(uintptr_t)req->sense;
 	ret = req->errors;
  out:
 	blk_mq_free_request(req);
@@ -1046,7 +1046,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen, NULL, 0);
+	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen, NULL, 0,
+									NULL);
 }
 
 static int nvme_submit_async_admin_req(struct nvme_dev *dev)
@@ -1209,7 +1210,7 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 	c.features.fid = cpu_to_le32(fid);
 
 	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
-			result, 0);
+			result, 0, NULL);
 }
 
 int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
@@ -1224,7 +1225,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
-			result, 0);
+			result, 0, NULL);
 }
 
 int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log **log)
@@ -1787,7 +1788,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.metadata = cpu_to_le64(meta_dma);
 
 	status = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
-			(void __user *)io.addr, length, NULL, 0);
+			(void __user *)io.addr, length, NULL, 0, NULL);
  unmap:
 	if (meta) {
 		if (status == NVME_SC_SUCCESS && !write) {
@@ -1831,7 +1832,7 @@ static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
 
 	status = __nvme_submit_sync_cmd(ns ? ns->queue : dev->admin_q, &c,
 			NULL, (void __user *)cmd.addr, cmd.data_len,
-			&cmd.result, timeout);
+			&cmd.result, timeout, NULL);
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
 			return -EFAULT;
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 8e6223e..ad35bb7 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1297,7 +1297,7 @@ static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr
 	c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
 
 	nvme_sc = __nvme_submit_sync_cmd(dev->admin_q, &c, NULL,
-			hdr->dxferp, tot_len, NULL, 0);
+			hdr->dxferp, tot_len, NULL, 0, NULL);
 	return nvme_trans_status_code(hdr, nvme_sc);
 }
 
@@ -1704,7 +1704,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			break;
 		}
 		nvme_sc = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
-				next_mapping_addr, unit_len, NULL, 0);
+				next_mapping_addr, unit_len, NULL, 0, NULL);
 		if (nvme_sc)
 			break;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 986bf8a..fce2090 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -150,7 +150,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, void __user *ubuffer, unsigned bufflen,
-		u32 *result, unsigned timeout);
+		u32 *result, unsigned timeout, void *special);
 int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id);
 int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
 		struct nvme_id_ns **id);
-- 
2.1.4
