From: mlin@kernel.org (Ming Lin)
Date: Tue, 22 Mar 2016 00:24:46 -0700
Subject: [PATCH v2 4/4] nvme: add helper nvme_setup_cmd()
In-Reply-To: <1458631486-14120-1-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
Message-ID: <1458631486-14120-5-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

This moves nvme_setup_{flush,discard,rw} calls into a common
nvme_setup_cmd() helper. So we can eventually hide all the command
setup in the core module and don't even need to update the fabrics
drivers for any specific command type.

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  53 +-----------------------
 drivers/nvme/host/pci.c  |  47 +--------------------
 3 files changed, 108 insertions(+), 97 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ff9cf2b..dfb5b6e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -127,6 +127,111 @@ struct request *nvme_alloc_request(struct request_queue *q,
 	return req;
 }
 
+static inline void nvme_setup_flush(struct nvme_ns *ns,
+		struct nvme_command *cmnd)
+{
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->common.opcode = nvme_cmd_flush;
+	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
+}
+
+static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
+		struct nvme_command *cmnd)
+{
+	struct nvme_dsm_range *range;
+	struct page *page;
+	int offset;
+	unsigned int nr_bytes = blk_rq_bytes(req);
+
+	range = kmalloc(sizeof(*range), GFP_ATOMIC);
+	if (!range)
+		return BLK_MQ_RQ_QUEUE_BUSY;
+
+	range->cattr = cpu_to_le32(0);
+	range->nlb = cpu_to_le32(nr_bytes >> ns->lba_shift);
+	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->dsm.opcode = nvme_cmd_dsm;
+	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->dsm.nr = 0;
+	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+
+	req->completion_data = range;
+	page = virt_to_page(range);
+	offset = offset_in_page(range);
+	blk_add_request_payload(req, page, offset, sizeof(*range));
+
+	/*
+	 * we set __data_len back to the size of the area to be discarded
+	 * on disk. This allows us to report completion on the full amount
+	 * of blocks described by the request.
+	 */
+	req->__data_len = nr_bytes;
+
+	return 0;
+}
+
+static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
+		struct nvme_command *cmnd)
+{
+	u16 control = 0;
+	u32 dsmgmt = 0;
+
+	if (req->cmd_flags & REQ_FUA)
+		control |= NVME_RW_FUA;
+	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
+		control |= NVME_RW_LR;
+
+	if (req->cmd_flags & REQ_RAHEAD)
+		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
+	cmnd->rw.command_id = req->tag;
+	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+
+	if (ns->ms) {
+		switch (ns->pi_type) {
+		case NVME_NS_DPS_PI_TYPE3:
+			control |= NVME_RW_PRINFO_PRCHK_GUARD;
+			break;
+		case NVME_NS_DPS_PI_TYPE1:
+		case NVME_NS_DPS_PI_TYPE2:
+			control |= NVME_RW_PRINFO_PRCHK_GUARD |
+					NVME_RW_PRINFO_PRCHK_REF;
+			cmnd->rw.reftag = cpu_to_le32(
+					nvme_block_nr(ns, blk_rq_pos(req)));
+			break;
+		}
+		if (!blk_integrity_rq(req))
+			control |= NVME_RW_PRINFO_PRACT;
+	}
+
+	cmnd->rw.control = cpu_to_le16(control);
+	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+}
+
+int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
+		struct nvme_command *cmd)
+{
+	int ret = 0;
+
+	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
+		memcpy(cmd, req->cmd, sizeof(*cmd));
+	else if (req->cmd_flags & REQ_FLUSH)
+		nvme_setup_flush(ns, cmd);
+	else if (req->cmd_flags & REQ_DISCARD)
+		ret = nvme_setup_discard(ns, req, cmd);
+	else
+		nvme_setup_rw(ns, req, cmd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_setup_cmd);
+
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 331d437..5eae43d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -189,57 +189,6 @@ static inline unsigned nvme_map_len(struct request *rq)
 		return blk_rq_bytes(rq);
 }
 
-static inline void nvme_setup_flush(struct nvme_ns *ns,
-		struct nvme_command *cmnd)
-{
-	memset(cmnd, 0, sizeof(*cmnd));
-	cmnd->common.opcode = nvme_cmd_flush;
-	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
-}
-
-static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmnd)
-{
-	u16 control = 0;
-	u32 dsmgmt = 0;
-
-	if (req->cmd_flags & REQ_FUA)
-		control |= NVME_RW_FUA;
-	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
-		control |= NVME_RW_LR;
-
-	if (req->cmd_flags & REQ_RAHEAD)
-		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
-
-	memset(cmnd, 0, sizeof(*cmnd));
-	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
-	cmnd->rw.command_id = req->tag;
-	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
-	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
-
-	if (ns->ms) {
-		switch (ns->pi_type) {
-		case NVME_NS_DPS_PI_TYPE3:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD;
-			break;
-		case NVME_NS_DPS_PI_TYPE1:
-		case NVME_NS_DPS_PI_TYPE2:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD |
-					NVME_RW_PRINFO_PRCHK_REF;
-			cmnd->rw.reftag = cpu_to_le32(
-					nvme_block_nr(ns, blk_rq_pos(req)));
-			break;
-		}
-		if (!blk_integrity_rq(req))
-			control |= NVME_RW_PRINFO_PRACT;
-	}
-
-	cmnd->rw.control = cpu_to_le16(control);
-	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
-}
-
-
 static inline int nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
@@ -278,6 +227,8 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl);
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags, int qid);
 void nvme_requeue_req(struct request *req);
+int nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
+		struct nvme_command *cmd);
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f2f8a4d..082c3d1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -607,43 +607,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	nvme_free_iod(dev, req);
 }
 
-static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmnd)
-{
-	struct nvme_dsm_range *range;
-	struct page *page;
-	int offset;
-	unsigned int nr_bytes = blk_rq_bytes(req);
-
-	range = kmalloc(sizeof(*range), GFP_ATOMIC);
-	if (!range)
-		return BLK_MQ_RQ_QUEUE_BUSY;
-
-	range->cattr = cpu_to_le32(0);
-	range->nlb = cpu_to_le32(nr_bytes >> ns->lba_shift);
-	range->slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
-
-	memset(cmnd, 0, sizeof(*cmnd));
-	cmnd->dsm.opcode = nvme_cmd_dsm;
-	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->dsm.nr = 0;
-	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
-
-	req->completion_data = range;
-	page = virt_to_page(range);
-	offset = offset_in_page(range);
-	blk_add_request_payload(req, page, offset, sizeof(*range));
-
-	/*
-	 * we set __data_len back to the size of the area to be discarded
-	 * on disk. This allows us to report completion on the full amount
-	 * of blocks described by the request.
-	 */
-	req->__data_len = nr_bytes;
-
-	return 0;
-}
-
 /*
  * NOTE: ns is NULL when called on the admin queue.
  */
@@ -676,15 +639,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
-		memcpy(&cmnd, req->cmd, sizeof(cmnd));
-	else if (req->cmd_flags & REQ_FLUSH)
-		nvme_setup_flush(ns, &cmnd);
-	else if (req->cmd_flags & REQ_DISCARD)
-		ret = nvme_setup_discard(ns, req, &cmnd);
-	else
-		nvme_setup_rw(ns, req, &cmnd);
-
+	ret = nvme_setup_cmd(ns, req, &cmnd);
 	if (ret)
 		goto out;
 
-- 
1.9.1
