From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 13:12:42 -0600
Subject: [PATCH 1/1] nvme: Ensure forward progress during Admin passthru
In-Reply-To: <20180622195914.18575-2-scott.bauer@intel.com>
References: <20180622195914.18575-1-scott.bauer@intel.com>
 <20180622195914.18575-2-scott.bauer@intel.com>
Message-ID: <20180627191241.GE9361@localhost.localdomain>

How about changing the reaction based on success?


---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..63fe4e130bec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1173,13 +1173,14 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	 * prevent memory corruption if a logical block size was changed by
 	 * this command.
 	 */
-	if (effects & NVME_CMD_EFFECTS_LBCC)
+	if (status == NVME_SC_SUCCESS && effects & NVME_CMD_EFFECTS_LBCC)
 		nvme_update_formats(ctrl);
 	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
 		nvme_unfreeze(ctrl);
-	if (effects & NVME_CMD_EFFECTS_CCC)
+	if (status == NVME_SC_SUCCESS && effects & NVME_CMD_EFFECTS_CCC)
 		nvme_init_identify(ctrl);
-	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
+	if (status == NVME_SUCCESS &&
+	    effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
 		nvme_queue_scan(ctrl);
 }
 
@@ -1220,7 +1221,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
 			0, &cmd.result, timeout);
-	nvme_passthru_end(ctrl, effects);
+	nvme_passthru_end(ctrl, effects, status);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
--
