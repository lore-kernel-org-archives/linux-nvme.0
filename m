From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 16:11:33 +0200
Subject: [PATCH 04/10] nvme: simplify the API for getting log pages
In-Reply-To: <20180611141139.30462-1-hch@lst.de>
References: <20180611141139.30462-1-hch@lst.de>
Message-ID: <20180611141139.30462-5-hch@lst.de>

Merge nvme_get_log and nvme_get_log_ext into a single helper, which takes
a plain nsid instead of the nvme_ns pointer.  Also add support for the
log specific field while we're at it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c     | 32 +++++++++++---------------------
 drivers/nvme/host/lightnvm.c |  5 +++--
 drivers/nvme/host/nvme.h     |  4 ++--
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f9dfc6c620b2..0177122cb4aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2254,21 +2254,16 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
-int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		     u8 log_page, void *log,
-		     size_t size, u64 offset)
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
+		void *log, size_t size, u64 offset)
 {
 	struct nvme_command c = { };
 	unsigned long dwlen = size / 4 - 1;
 
 	c.get_log_page.opcode = nvme_admin_get_log_page;
-
-	if (ns)
-		c.get_log_page.nsid = cpu_to_le32(ns->head->ns_id);
-	else
-		c.get_log_page.nsid = cpu_to_le32(NVME_NSID_ALL);
-
+	c.get_log_page.nsid = cpu_to_le32(nsid);
 	c.get_log_page.lid = log_page;
+	c.get_log_page.lsp = lsp;
 	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
 	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
 	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
@@ -2277,12 +2272,6 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
-static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log,
-			size_t size)
-{
-	return nvme_get_log_ext(ctrl, NULL, log_page, log, size, 0);
-}
-
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 {
 	int ret;
@@ -2293,8 +2282,8 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 	if (!ctrl->effects)
 		return 0;
 
-	ret = nvme_get_log(ctrl, NVME_LOG_CMD_EFFECTS, ctrl->effects,
-					sizeof(*ctrl->effects));
+	ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CMD_EFFECTS, 0,
+			ctrl->effects, sizeof(*ctrl->effects), 0);
 	if (ret) {
 		kfree(ctrl->effects);
 		ctrl->effects = NULL;
@@ -3213,7 +3202,8 @@ static void nvme_clear_changed_ns_log(struct nvme_ctrl *ctrl)
 	 * raced with us in reading the log page, which could cause us to miss
 	 * updates.
 	 */
-	error = nvme_get_log(ctrl, NVME_LOG_CHANGED_NS, log, log_size);
+	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CHANGED_NS, 0, log,
+			log_size, 0);
 	if (error)
 		dev_warn(ctrl->device,
 			"reading changed ns log failed: %d\n", error);
@@ -3330,9 +3320,9 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	if (!log)
 		return;
 
-	if (nvme_get_log(ctrl, NVME_LOG_FW_SLOT, log, sizeof(*log)))
-		dev_warn(ctrl->device,
-				"Get FW SLOT INFO log error\n");
+	if (nvme_get_log(ctrl, NVME_NSID_ALL, 0, NVME_LOG_FW_SLOT, log,
+			sizeof(*log), 0))
+		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
 	kfree(log);
 }
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 41279da799ed..5fc695e37a88 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -598,8 +598,9 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
 	while (left) {
 		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
 
-		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
-				dev_meta, len, offset);
+		ret = nvme_get_log(ctrl, ns->head->ns_id,
+				NVME_NVM_LOG_REPORT_CHUNK, 0, dev_meta, len,
+				offset);
 		if (ret) {
 			dev_err(ctrl->device, "Get REPORT CHUNK log error\n");
 			break;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 34df07d44f80..b6ec91ff9332 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -436,8 +436,8 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
-int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		u8 log_page, void *log, size_t size, u64 offset);
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
+		void *log, size_t size, u64 offset);
 
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
-- 
2.17.1
