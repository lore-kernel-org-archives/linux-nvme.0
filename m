From: keith.busch@intel.com (Keith Busch)
Date: Wed,  1 Nov 2017 12:04:00 -0600
Subject: [PATCH 2/2] nvme: Check admin passthru command effects
In-Reply-To: <20171101180400.6619-1-keith.busch@intel.com>
References: <20171101180400.6619-1-keith.busch@intel.com>
Message-ID: <20171101180400.6619-2-keith.busch@intel.com>

The NVMe standard provides a command effects log page so the host may
be aware of special requirements it may need to do in response to a
particular command. For example, the command may need to run with IO
quiesced to prevent timeouts or undefined behavior, or it may change
the logical block formats that determine how the host needs to construct
future IO commands.

This patch saves the nvme command effects log page if the controller
supports it, and performs appropriate actions before and after an admin
passthrough command is completed. If the controller does not support the
command effects log page, the driver will define the effects for known
opcodes. The nvme format and santize are the only commands in this patch
with known effects.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |   1 +
 include/linux/nvme.h     |  19 ++++++++
 3 files changed, 136 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bae987b5dc79..a3444a67b1bc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -72,6 +72,9 @@ static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 
+static void nvme_ns_remove(struct nvme_ns *ns);
+static int nvme_revalidate_disk(struct gendisk *disk);
+
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
 {
 	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
@@ -990,12 +993,96 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, io.slba, NULL, 0);
 }
 
+static u32 nvme_get_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+								u8 opcode)
+{
+	if (ctrl->effects) {
+		if (ns)
+			return le32_to_cpu(ctrl->effects->iocs[opcode]);
+		return le32_to_cpu(ctrl->effects->acs[opcode]);
+	}
+	if (ns)
+		return 0;
+
+	/*
+	 * Set known effects for opcodes if the controller doesn't support
+	 * reporting the command's effects.
+	 */
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+					NVME_CMD_EFFECTS_CSE_MASK;
+	case nvme_admin_sanitize_nvm:
+		return NVME_CMD_EFFECTS_CSE_MASK;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+								u8 opcode)
+{
+	u32 effects = nvme_get_effects(ctrl, ns, opcode);
+
+	/*
+	 * XXX: IO command effects are not handled.
+	 */
+	if (ns && (effects & ~NVME_CMD_EFFECTS_CSUPP)) {
+		dev_warn(ctrl->device,
+			 "IO command;%02x has unhandled effects:%08x\n",
+			 opcode, effects);
+		return 0;
+	}
+
+	/*
+	 * For simplicity, IO to all namespaces is quiesced even if the command
+	 * effects say only one namespace is affected.
+	 */
+	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+		nvme_start_freeze(ctrl);
+		nvme_wait_freeze(ctrl);
+	}
+	return effects;
+}
+
+static void nvme_update_formats(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (ns->disk && nvme_revalidate_disk(ns->disk))
+			nvme_ns_remove(ns);
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+								u32 effects)
+{
+	/*
+	 * Revaildate LBA changes prior to unfreezing. This is necessary to
+	 * prevent memory corruption if a logical block size was changed by
+	 * this command.
+	 */
+	if (effects & NVME_CMD_EFFECTS_LBCC)
+		nvme_update_formats(ctrl);
+	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK))
+		nvme_unfreeze(ctrl);
+	if (effects & NVME_CMD_EFFECTS_CCC)
+		nvme_init_identify(ctrl);
+	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
+		nvme_queue_scan(ctrl);
+}
+
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
+	u32 effects;
 	int status;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1021,10 +1108,13 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
+	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
 			0, &cmd.result, timeout);
+	nvme_passthru_end(ctrl, ns, effects);
+
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
 			return -EFAULT;
@@ -1772,6 +1862,25 @@ static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log,
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
+static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
+{
+	int ret;
+
+	if (!ctrl->effects)
+		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
+
+	if (!ctrl->effects)
+		return 0;
+
+	ret = nvme_get_log(ctrl, NVME_LOG_CMD_EFFECTS, ctrl->effects,
+					sizeof(*ctrl->effects));
+	if (ret) {
+		kfree(ctrl->effects);
+		ctrl->effects = NULL;
+	}
+	return ret;
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -1807,6 +1916,12 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
+		ret = nvme_get_effects_log(ctrl);
+		if (ret < 0)
+			return ret;
+	}
+
 	nvme_init_subnqn(ctrl, id);
 
 	if (!ctrl->identified) {
@@ -2726,6 +2841,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	ida_destroy(&ctrl->ns_ida);
+	kfree(ctrl->effects);
 
 	ctrl->ops->free_ctrl(ctrl);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 35d9cee515f1..f7c21cea9485 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -174,6 +174,7 @@ struct nvme_ctrl {
 	bool subsystem;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
+	struct nvme_effects_log *effects;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9310ce77d8e1..26df3326fdbb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -267,6 +267,7 @@ enum {
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
+	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
 };
 
 struct nvme_lbaf {
@@ -396,6 +397,22 @@ struct nvme_fw_slot_info_log {
 };
 
 enum {
+	NVME_CMD_EFFECTS_CSUPP		= 1 << 0,
+	NVME_CMD_EFFECTS_LBCC		= 1 << 1,
+	NVME_CMD_EFFECTS_NCC		= 1 << 2,
+	NVME_CMD_EFFECTS_NIC		= 1 << 3,
+	NVME_CMD_EFFECTS_CCC		= 1 << 4,
+	NVME_CMD_EFFECTS_CSE_MASK	= 3 << 16,
+};
+
+struct nvme_effects_log {
+	__le32 acs[256];
+	__le32 iocs[256];
+	__u8   resv[2048];
+};
+
+
+enum {
 	NVME_SMART_CRIT_SPARE		= 1 << 0,
 	NVME_SMART_CRIT_TEMPERATURE	= 1 << 1,
 	NVME_SMART_CRIT_RELIABILITY	= 1 << 2,
@@ -681,6 +698,7 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+	nvme_admin_sanitize_nvm		= 0x84,
 };
 
 enum {
@@ -712,6 +730,7 @@ enum {
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_CMD_EFFECTS	= 0x05,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_FWACT_REPL		= (0 << 3),
-- 
2.13.6
