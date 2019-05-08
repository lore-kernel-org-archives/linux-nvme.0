From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  8 May 2019 11:36:34 -0700
Subject: [PATCH 3/3] nvme-core: add filter for user commands
In-Reply-To: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
References: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190508183634.4682-4-chaitanya.kulkarni@wdc.com>

This patch adds a filter for the user commands. Right now we only check
for the NVMe Get Log Page commands. We only allow the user to issue get
log page command with RAE == 0 where we generate uevent for the async
event associated with this log page id.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 64 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eebaeadaa800..afd303489473 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1305,6 +1305,59 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 		nvme_queue_scan(ctrl);
 }
 
+static inline bool nvme_get_log_page_allowed(struct nvme_command *c)
+{
+	bool ret;
+	u8 lid = c->get_log_page.lid;
+	int rae = le32_to_cpu(c->common.cdw10) & NVME_LOG_PAGE_RAE;
+
+	/* if rae == 1 or lid == Vendor specific allow get log page cmd */
+	if (rae || (lid >= 0xC && 0xFF <= lid))
+		return true;
+
+	switch (lid) {
+	/*
+	 * We send uevent for the following logs, See nvme_aen_uevent(), hence
+	 * allow only those log-pages to be cleared by the user for log page
+	 * rae == 0 command.
+	 */
+	case NVME_LOG_ERROR:
+	case NVME_LOG_SMART:
+	case NVME_LOG_RESERVATION:
+	case NVME_LOG_SANITIZE:
+	case NVME_LOG_DISC:
+		ret = true;
+		break;
+	default:
+		ret = false;
+	}
+	return ret;
+}
+
+static inline bool nvme_user_admin_cmd_allowed(struct nvme_command *c)
+{
+	bool ret;
+
+	switch (c->common.opcode) {
+	case nvme_admin_get_log_page:
+		ret = nvme_get_log_page_allowed(c);
+		break;
+	default:
+		ret = true;
+	}
+	return ret;
+}
+
+static inline bool nvme_user_cmd_allowed(struct nvme_ns *ns,
+		struct nvme_command *c)
+{
+	/*
+	 * Right now only check for admin commands, in future for I/O commands
+	 * please introduce nvme_user_io_cmd_allowed().
+	 */
+	return ns == NULL ? nvme_user_admin_cmd_allowed(c) : true;
+}
+
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
@@ -1337,6 +1390,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
+	/* use nvme_command to make code more readable */
+	if (!nvme_user_cmd_allowed(ns, &c))
+		return -EINVAL;
+
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
@@ -3434,10 +3491,9 @@ static void nvme_clear_changed_ns_log(struct nvme_ctrl *ctrl)
 		return;
 
 	/*
-	 * We need to read the log to clear the AEN, but we don't want to rely
-	 * on it for the changed namespace information as userspace could have
-	 * raced with us in reading the log page, which could cause us to miss
-	 * updates.
+	 * We don't allow userspace to clear this log page as we filter the user
+	 * log page command with RAE == 0, see nvme_user_admin_cmd_allowed().
+	 * Now we can rely on this updated log page information.
 	 */
 	error = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_CHANGED_NS, 0, log,
 			log_size, 0);
-- 
2.17.0
