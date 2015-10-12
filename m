From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:10:04 +0200
Subject: [PATCH 1/8] nvme: split __nvme_submit_sync_cmd
In-Reply-To: <1444633811-28319-1-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
Message-ID: <1444633811-28319-2-git-send-email-hch@lst.de>

Add a separate nvme_submit_user_cmd for commands that directly DMA
to or from userspace.  We'll add metadata support to that soon and
the common version would become too messy.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 82 ++++++++++++++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h |  6 ++--
 drivers/nvme/host/pci.c  |  6 ++--
 drivers/nvme/host/scsi.c |  4 +--
 4 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e2e8818..9d05df0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -21,22 +21,15 @@
 
 #include "nvme.h"
 
-/*
- * Returns 0 on success.  If the result is negative, it's a Linux error code;
- * if the result is positive, it's an NVM Express status code
- */
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buffer, void __user *ubuffer, unsigned bufflen,
-		u32 *result, unsigned timeout)
+static struct request *nvme_alloc_request(struct request_queue *q,
+		struct nvme_command *cmd)
 {
 	bool write = cmd->common.opcode & 1;
-	struct bio *bio = NULL;
 	struct request *req;
-	int ret;
 
 	req = blk_mq_alloc_request(q, write, GFP_KERNEL, false);
 	if (IS_ERR(req))
-		return PTR_ERR(req);
+		return req;
 
 	req->cmd_type = REQ_TYPE_DRV_PRIV;
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
@@ -44,26 +37,36 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	req->__sector = (sector_t) -1;
 	req->bio = req->biotail = NULL;
 
-	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
-
 	req->cmd = (unsigned char *)cmd;
 	req->cmd_len = sizeof(struct nvme_command);
 	req->special = (void *)0;
 
+	return req;
+}
+
+/*
+ * Returns 0 on success.  If the result is negative, it's a Linux error code;
+ * if the result is positive, it's an NVM Express status code
+ */
+int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void *buffer, unsigned bufflen, u32 *result, unsigned timeout)
+{
+	struct request *req;
+	int ret;
+
+	req = nvme_alloc_request(q, cmd);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, __GFP_WAIT);
 		if (ret)
 			goto out;
-	} else if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen, __GFP_WAIT);
-		if (ret)
-			goto out;
-		bio = req->bio;
 	}
 
 	blk_execute_rq(req->q, NULL, req, 0);
-	if (bio)
-		blk_rq_unmap_user(bio);
 	if (result)
 		*result = (u32)(uintptr_t)req->special;
 	ret = req->errors;
@@ -75,7 +78,40 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
-	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen, NULL, 0);
+	return __nvme_submit_sync_cmd(q, cmd, buffer, bufflen, NULL, 0);
+}
+
+int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void __user *ubuffer, unsigned bufflen, u32 *result,
+		unsigned timeout)
+{
+	struct bio *bio = NULL;
+	struct request *req;
+	int ret;
+
+	req = nvme_alloc_request(q, cmd);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+
+	if (ubuffer && bufflen) {
+		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+				__GFP_WAIT);
+		if (ret)
+			goto out;
+		bio = req->bio;
+	}
+
+	blk_execute_rq(req->q, NULL, req, 0);
+	if (bio)
+		blk_rq_unmap_user(bio);
+	if (result)
+		*result = (u32)(uintptr_t)req->special;
+	ret = req->errors;
+ out:
+	blk_mq_free_request(req);
+	return ret;
 }
 
 int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
@@ -130,8 +166,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
 
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
-			result, 0);
+	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0, result, 0);
 }
 
 int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
@@ -145,8 +180,7 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, NULL, 0,
-			result, 0);
+	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0, result, 0);
 }
 
 int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3e409fa..4d13354 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -83,8 +83,10 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buffer, void __user *ubuffer, unsigned bufflen,
-		u32 *result, unsigned timeout);
+		void *buffer, unsigned bufflen,  u32 *result, unsigned timeout);
+int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void __user *ubuffer, unsigned bufflen, u32 *result,
+		unsigned timeout);
 int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id);
 int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 		struct nvme_id_ns **id);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 08c716e..29b48a2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1736,7 +1736,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.appmask = cpu_to_le16(io.appmask);
 	c.rw.metadata = cpu_to_le64(meta_dma);
 
-	status = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
+	status = nvme_submit_user_cmd(ns->queue, &c,
 			(void __user *)io.addr, length, NULL, 0);
  unmap:
 	if (meta) {
@@ -1778,8 +1778,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
-	status = __nvme_submit_sync_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			NULL, (void __user *)cmd.addr, cmd.data_len,
+	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
+			(void __user *)cmd.addr, cmd.data_len,
 			&cmd.result, timeout);
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 00d0bdd..b673fe4 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -1295,7 +1295,7 @@ static int nvme_trans_send_download_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr
 	c.dlfw.numd = cpu_to_le32((tot_len/BYTES_TO_DWORDS) - 1);
 	c.dlfw.offset = cpu_to_le32(offset/BYTES_TO_DWORDS);
 
-	nvme_sc = __nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL,
+	nvme_sc = nvme_submit_user_cmd(ns->ctrl->admin_q, &c,
 			hdr->dxferp, tot_len, NULL, 0);
 	return nvme_trans_status_code(hdr, nvme_sc);
 }
@@ -1699,7 +1699,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			nvme_sc = NVME_SC_LBA_RANGE;
 			break;
 		}
-		nvme_sc = __nvme_submit_sync_cmd(ns->queue, &c, NULL,
+		nvme_sc = nvme_submit_user_cmd(ns->queue, &c,
 				next_mapping_addr, unit_len, NULL, 0);
 		if (nvme_sc)
 			break;
-- 
1.9.1
