From: a.dawn@samsung.com (Arnav Dawn)
Date: Wed, 12 Jul 2017 16:11:53 +0530
Subject: [PATCH v5 2/2] nvme: Define NVME_NSID_ALL
In-Reply-To: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
References: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
 <CGME20170712104016epcas5p2f0a41b2c647aac7008f340d5b0c1ee0f@epcas5p2.samsung.com>
Message-ID: <1499856113-29397-1-git-send-email-a.dawn@samsung.com>

Define the constant "0xffffffff" (used as nsid for all namespaces)
as NVME_NSID_ALL.

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 6 +++---
 include/linux/nvme.h     | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 39fdb57..4a07a98 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -312,7 +312,7 @@ static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 	memset(&c, 0, sizeof(c));
 
 	c.directive.opcode = nvme_admin_directive_send;
-	c.directive.nsid = cpu_to_le32(0xffffffff);
+	c.directive.nsid = cpu_to_le32(NVME_NSID_ALL);
 	c.directive.doper = NVME_DIR_SND_ID_OP_ENABLE;
 	c.directive.dtype = NVME_DIR_IDENTIFY;
 	c.directive.tdtype = NVME_DIR_STREAMS;
@@ -362,7 +362,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ret = nvme_get_stream_params(ctrl, &s, 0xffffffff);
+	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
 	if (ret)
 		return ret;
 
@@ -2552,7 +2552,7 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 		return;
 
 	c.common.opcode = nvme_admin_get_log_page;
-	c.common.nsid = cpu_to_le32(0xffffffff);
+	c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
 	c.common.cdw10[0] = nvme_get_log_dw10(NVME_LOG_FW_SLOT, sizeof(*log));
 
 	if (!nvme_submit_sync_cmd(ctrl->admin_q, &c, log, sizeof(*log)))
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 220fa58..983975b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -32,6 +32,8 @@
 
 #define NVME_RDMA_IP_PORT	4420
 
+#define NVME_NSID_ALL		0xffffffff
+
 enum nvme_subsys_type {
 	NVME_NQN_DISC	= 1,		/* Discovery type target subsystem */
 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
-- 
1.9.1
