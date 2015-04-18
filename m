From: hch@lst.de (Christoph Hellwig)
Date: Sat, 18 Apr 2015 09:45:27 +0200
Subject: [PATCH v3] nvme: consolidate synchronous command submission helpers
Message-ID: <1429343127-18030-1-git-send-email-hch@lst.de>

Note that we keep the unused timeout argument, but allow callers to
pass 0 instead of a timeout if they want the default.  This will allow
adding a timeout to the pass through path later on.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/nvme-core.c | 96 ++++++++++++++++-------------------------------
 drivers/block/nvme-scsi.c | 17 ++++-----
 include/linux/nvme.h      |  6 +--
 3 files changed, 42 insertions(+), 77 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036..247c02a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -991,27 +991,40 @@ static void sync_completion(struct nvme_queue *nvmeq, void *ctx,
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
-static int nvme_submit_sync_cmd(struct request *req, struct nvme_command *cmd,
-						u32 *result, unsigned timeout)
+static int __nvme_submit_sync_cmd(struct request_queue *q,
+		struct nvme_command *cmd, u32 *result, unsigned timeout)
 {
 	struct sync_cmd_info cmdinfo;
-	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
-	struct nvme_queue *nvmeq = cmd_rq->nvmeq;
+	struct nvme_cmd_info *cmd_rq;
+	struct request *req;
+	int res;
+
+	req = blk_mq_alloc_request(q, WRITE, GFP_KERNEL, false);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
 
 	cmdinfo.task = current;
 	cmdinfo.status = -EINTR;
 
 	cmd->common.command_id = req->tag;
 
+	cmd_rq = blk_mq_rq_to_pdu(req);
 	nvme_set_info(cmd_rq, &cmdinfo, sync_completion);
 
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	nvme_submit_cmd(nvmeq, cmd);
+	nvme_submit_cmd(cmd_rq->nvmeq, cmd);
 	schedule();
 
 	if (result)
 		*result = cmdinfo.result;
-	return cmdinfo.status;
+	res = cmdinfo.status;
+	blk_mq_free_request(req);
+	return res;
+}
+
+int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd)
+{
+	return __nvme_submit_sync_cmd(q, cmd, NULL, 0);
 }
 
 static int nvme_submit_async_admin_req(struct nvme_dev *dev)
@@ -1060,41 +1073,6 @@ static int nvme_submit_admin_async_cmd(struct nvme_dev *dev,
 	return nvme_submit_cmd(nvmeq, cmd);
 }
 
-static int __nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
-						u32 *result, unsigned timeout)
-{
-	int res;
-	struct request *req;
-
-	req = blk_mq_alloc_request(dev->admin_q, WRITE, GFP_KERNEL, false);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-	res = nvme_submit_sync_cmd(req, cmd, result, timeout);
-	blk_mq_free_request(req);
-	return res;
-}
-
-int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
-								u32 *result)
-{
-	return __nvme_submit_admin_cmd(dev, cmd, result, ADMIN_TIMEOUT);
-}
-
-int nvme_submit_io_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
-					struct nvme_command *cmd, u32 *result)
-{
-	int res;
-	struct request *req;
-
-	req = blk_mq_alloc_request(ns->queue, WRITE, (GFP_KERNEL|__GFP_WAIT),
-									false);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-	res = nvme_submit_sync_cmd(req, cmd, result, NVME_IO_TIMEOUT);
-	blk_mq_free_request(req);
-	return res;
-}
-
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
 	struct nvme_command c;
@@ -1103,7 +1081,7 @@ static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 	c.delete_queue.opcode = opcode;
 	c.delete_queue.qid = cpu_to_le16(id);
 
-	return nvme_submit_admin_cmd(dev, &c, NULL);
+	return nvme_submit_sync_cmd(dev->admin_q, &c);
 }
 
 static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
@@ -1120,7 +1098,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	c.create_cq.cq_flags = cpu_to_le16(flags);
 	c.create_cq.irq_vector = cpu_to_le16(nvmeq->cq_vector);
 
-	return nvme_submit_admin_cmd(dev, &c, NULL);
+	return nvme_submit_sync_cmd(dev->admin_q, &c);
 }
 
 static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
@@ -1137,7 +1115,7 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 	c.create_sq.sq_flags = cpu_to_le16(flags);
 	c.create_sq.cqid = cpu_to_le16(qid);
 
-	return nvme_submit_admin_cmd(dev, &c, NULL);
+	return nvme_submit_sync_cmd(dev->admin_q, &c);
 }
 
 static int adapter_delete_cq(struct nvme_dev *dev, u16 cqid)
@@ -1161,7 +1139,7 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid, unsigned cns,
 	c.identify.prp1 = cpu_to_le64(dma_addr);
 	c.identify.cns = cpu_to_le32(cns);
 
-	return nvme_submit_admin_cmd(dev, &c, NULL);
+	return nvme_submit_sync_cmd(dev->admin_q, &c);
 }
 
 int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
@@ -1175,7 +1153,7 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
 
-	return nvme_submit_admin_cmd(dev, &c, result);
+	return __nvme_submit_sync_cmd(dev->admin_q, &c, result, 0);
 }
 
 int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
@@ -1189,7 +1167,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	return nvme_submit_admin_cmd(dev, &c, result);
+	return __nvme_submit_sync_cmd(dev->admin_q, &c, result, 0);
 }
 
 /**
@@ -1813,7 +1791,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 	c.rw.prp2 = cpu_to_le64(iod->first_dma);
 	c.rw.metadata = cpu_to_le64(meta_dma);
-	status = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	status = nvme_submit_sync_cmd(ns->queue, &c);
  unmap:
 	nvme_unmap_user_pages(dev, write, iod);
 	nvme_free_iod(dev, iod);
@@ -1869,23 +1847,15 @@ static int nvme_user_cmd(struct nvme_dev *dev, struct nvme_ns *ns,
 	timeout = cmd.timeout_ms ? msecs_to_jiffies(cmd.timeout_ms) :
 								ADMIN_TIMEOUT;
 
-	if (length != cmd.data_len)
+	if (length != cmd.data_len) {
 		status = -ENOMEM;
-	else if (ns) {
-		struct request *req;
-
-		req = blk_mq_alloc_request(ns->queue, WRITE,
-						(GFP_KERNEL|__GFP_WAIT), false);
-		if (IS_ERR(req))
-			status = PTR_ERR(req);
-		else {
-			status = nvme_submit_sync_cmd(req, &c, &cmd.result,
-								timeout);
-			blk_mq_free_request(req);
-		}
-	} else
-		status = __nvme_submit_admin_cmd(dev, &c, &cmd.result, timeout);
+		goto out;
+	}
+
+	status = __nvme_submit_sync_cmd(ns ? ns->queue : dev->admin_q, &c,
+					&cmd.result, timeout);
 
+out:
 	if (cmd.data_len) {
 		nvme_unmap_user_pages(dev, cmd.opcode & 1, iod);
 		nvme_free_iod(dev, iod);
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 6b736b0..ba1809f 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -1053,7 +1053,7 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
 	c.common.prp1 = cpu_to_le64(dma_addr);
 	c.common.cdw10[0] = cpu_to_le32((((sizeof(struct nvme_smart_log) /
 			BYTES_TO_DWORDS) - 1) << 16) | NVME_LOG_SMART);
-	res = nvme_submit_admin_cmd(dev, &c, NULL);
+	res = nvme_submit_sync_cmd(dev->admin_q, &c);
 	if (res != NVME_SC_SUCCESS) {
 		temp_c = LOG_TEMP_UNKNOWN;
 	} else {
@@ -1121,7 +1121,7 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	c.common.prp1 = cpu_to_le64(dma_addr);
 	c.common.cdw10[0] = cpu_to_le32((((sizeof(struct nvme_smart_log) /
 			BYTES_TO_DWORDS) - 1) << 16) | NVME_LOG_SMART);
-	res = nvme_submit_admin_cmd(dev, &c, NULL);
+	res = nvme_submit_sync_cmd(dev->admin_q, &c);
 	if (res != NVME_SC_SUCCESS) {
 		temp_c_cur = LOG_TEMP_UNKNOWN;
 	} else {
@@ -1609,7 +1609,7 @@ static int nvme_trans_send_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		c.common.cdw10[0] = cpu_to_le32(cdw10);
 	}
 
-	nvme_sc = nvme_submit_admin_cmd(dev, &c, NULL);
+	nvme_sc = nvme_submit_sync_cmd(dev->admin_q, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_unmap;
@@ -1971,7 +1971,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	c.format.nsid = cpu_to_le32(ns->ns_id);
 	c.format.cdw10 = cpu_to_le32(cdw10);
 
-	nvme_sc = nvme_submit_admin_cmd(dev, &c, NULL);
+	nvme_sc = nvme_submit_sync_cmd(dev->admin_q, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out_dma;
@@ -2139,7 +2139,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 		nvme_offset += unit_num_blocks;
 
-		nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+		nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
 		if (nvme_sc != NVME_SC_SUCCESS) {
 			nvme_unmap_user_pages(dev,
 				(is_write) ? DMA_TO_DEVICE : DMA_FROM_DEVICE,
@@ -2696,7 +2696,7 @@ static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 			c.common.opcode = nvme_cmd_flush;
 			c.common.nsid = cpu_to_le32(ns->ns_id);
 
-			nvme_sc = nvme_submit_io_cmd(ns->dev, ns, &c, NULL);
+			nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
 			res = nvme_trans_status_code(hdr, nvme_sc);
 			if (res)
 				goto out;
@@ -2724,8 +2724,7 @@ static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
 	c.common.opcode = nvme_cmd_flush;
 	c.common.nsid = cpu_to_le32(ns->ns_id);
 
-	nvme_sc = nvme_submit_io_cmd(ns->dev, ns, &c, NULL);
-
+	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
 		goto out;
@@ -2932,7 +2931,7 @@ static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	c.dsm.nr = cpu_to_le32(ndesc - 1);
 	c.dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
-	nvme_sc = nvme_submit_io_cmd(dev, ns, &c, NULL);
+	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 
 	dma_free_coherent(&dev->pci_dev->dev, ndesc * sizeof(*range),
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8dbd05e..61488b2 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -158,11 +158,7 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 				unsigned long addr, unsigned length);
 void nvme_unmap_user_pages(struct nvme_dev *dev, int write,
 			struct nvme_iod *iod);
-int nvme_submit_io_cmd(struct nvme_dev *, struct nvme_ns *,
-						struct nvme_command *, u32 *);
-int nvme_submit_flush_data(struct nvme_queue *nvmeq, struct nvme_ns *ns);
-int nvme_submit_admin_cmd(struct nvme_dev *, struct nvme_command *,
-							u32 *result);
+int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd);
 int nvme_identify(struct nvme_dev *, unsigned nsid, unsigned cns,
 							dma_addr_t dma_addr);
 int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
-- 
1.9.1
