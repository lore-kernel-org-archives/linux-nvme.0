From: keith.busch@intel.com (Keith Busch)
Date: Wed,  1 Nov 2017 12:03:59 -0600
Subject: [PATCH 1/2] nvme: Factor get log into a helper
Message-ID: <20171101180400.6619-1-keith.busch@intel.com>

And fix the warning on a successful firmware log.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07b9f4e1c283..bae987b5dc79 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1760,6 +1760,18 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memset(ctrl->subnqn + off, 0, sizeof(ctrl->subnqn) - off);
 }
 
+static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log,
+								size_t size)
+{
+	struct nvme_command c = { };
+
+	c.common.opcode = nvme_admin_get_log_page;
+	c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
+	c.common.cdw10[0] = nvme_get_log_dw10(log_page, size);
+
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -2592,18 +2604,13 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 
 static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 {
-	struct nvme_command c = { };
 	struct nvme_fw_slot_info_log *log;
 
 	log = kmalloc(sizeof(*log), GFP_KERNEL);
 	if (!log)
 		return;
 
-	c.common.opcode = nvme_admin_get_log_page;
-	c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
-	c.common.cdw10[0] = nvme_get_log_dw10(NVME_LOG_FW_SLOT, sizeof(*log));
-
-	if (!nvme_submit_sync_cmd(ctrl->admin_q, &c, log, sizeof(*log)))
+	if (nvme_get_log(ctrl, NVME_LOG_FW_SLOT, log, sizeof(*log)))
 		dev_warn(ctrl->device,
 				"Get FW SLOT INFO log error\n");
 	kfree(log);
-- 
2.13.6
