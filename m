From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Oct 2017 17:07:56 -0600
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
Message-ID: <20171027230756.GA17245@localhost.localdomain>

On Fri, Oct 27, 2017@10:35:58AM -0600, Jens Axboe wrote:
> @@ -1013,10 +1013,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	if (cmd.timeout_ms)
>  		timeout = msecs_to_jiffies(cmd.timeout_ms);
>  
> +	/*
> +	 * Freeze current access to the device, and prevent new ones, around
> +	 * a format operation.
> +	 */
> +	if (cmd.opcode == nvme_admin_format_nvm) {
> +		nvme_start_freeze(ctrl);
> +		nvme_wait_freeze(ctrl);
> +	}
> +
>  	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
>  			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
>  			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
>  			0, &cmd.result, timeout);
> +
> +	if (cmd.opcode == nvme_admin_format_nvm)
> +		nvme_unfreeze(ctrl);
> +

Testing some obscure vendor specific IO commands, I noticed this
will deadlock if an IO command opcode happens to be the same as an
nvme_admin_format_nvm command since the IO queues are all frozen.

You can check 'ns == NULL' before checking the opcode.

I also have this patch that's more generic and will perform actions
based on the controller's command effects:

---
commit 760052c4f2d697c19e0f3a78f2f9bc36b2b6b92f
Author: Keith Busch <keith.busch at intel.com>
Date:   Fri Oct 27 10:35:58 2017 -0600

    nvme: Check admin passthru command effects
    
    This patch saves the effects log page if the controller supports it,
    and performs appropriate actions before and after an admin passthrough
    command is completed.
    
    The NVMe standard provides a command effects log page so the host is
    aware of actions it may need to do in response to a particular passthrough
    command. For example, the command may need to run with IO quiesced to
    prevent timeouts or undefined behavior, or it may change the logical
    block formats that alter how the host needs to construct commands.
    
    If the controller does not support the command effects log page, the
    driver will define the effects for known opcodes. The nvme format is
    the only such command in this patch with known effects.
    
    Signed-off-by: Keith Busch <keith.busch at intel.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37f9039bb9ca..9b352541672d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -76,6 +76,10 @@ static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
+static void nvme_scan(struct nvme_ctrl *ctrl);
+static void nvme_ns_remove(struct nvme_ns *ns);
+static int nvme_revalidate_disk(struct gendisk *disk);
+
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
 {
 	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
@@ -982,12 +986,68 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, io.slba, NULL, 0);
 }
 
+static void nvme_get_admin_effects(struct nvme_ctrl *ctrl, u8 opcode, u32 *effects)
+{
+	if (ctrl->effects)
+		*effects = le32_to_cpu(ctrl->effects->acs[opcode]);
+
+	if (*effects != 0)
+		return;
+
+	/*
+	 * Set known effects for opcodes if the controller doesn't support
+	 * reporting the command's effects.
+	 */
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+		*effects = NVME_CMD_FX_CSUPP | NVME_CMD_FX_LBCC |
+					NVME_CMD_FX_CSE_MASK;
+		break;
+	default:
+		break;
+	}
+}
+
+static void nvme_passthru_start(struct nvme_ctrl *ctrl, u32 effects)
+{
+	if (effects & (NVME_CMD_FX_LBCC | NVME_CMD_FX_CSE_MASK)) {
+		nvme_start_freeze(ctrl);
+		nvme_wait_freeze(ctrl);
+	}
+}
+
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
+{
+	/*
+	 * Revaildate LBA changes prior to unfreezing. This is necessary to
+	 * prevent memory corruption if a logical block size was changed by
+	 * this command.
+	 */
+	if (effects & NVME_CMD_FX_LBCC) {
+		struct nvme_ns *ns;
+
+		mutex_lock(&ctrl->namespaces_mutex);
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			if (ns->disk && nvme_revalidate_disk(ns->disk))
+				nvme_ns_remove(ns);
+		}
+		mutex_unlock(&ctrl->namespaces_mutex);
+	}
+	if (effects & (NVME_CMD_FX_LBCC | NVME_CMD_FX_CSE_MASK))
+		nvme_unfreeze(ctrl);
+	if (effects & NVME_CMD_FX_CCC)
+		nvme_init_identify(ctrl);
+	if (effects & (NVME_CMD_FX_NIC | NVME_CMD_FX_NCC))
+		nvme_scan(ctrl);
+}
+
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
+	u32 effects = 0;
 	int status;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -997,6 +1057,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.flags)
 		return -EINVAL;
 
+	if (ns != NULL)
+		nvme_get_admin_effects(ctrl, cmd.opcode, &effects);
+
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
 	c.common.flags = cmd.flags;
@@ -1013,10 +1076,13 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
+	nvme_passthru_start(ctrl, effects);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
 			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
 			0, &cmd.result, timeout);
+	nvme_passthru_end(ctrl, effects);
+
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
 			return -EFAULT;
@@ -1762,6 +1828,37 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memset(ctrl->subnqn + off, 0, sizeof(ctrl->subnqn) - off);
 }
 
+static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log, size_t size)
+{
+	struct nvme_command c = { };
+
+
+	c.common.opcode = nvme_admin_get_log_page;
+	c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
+	c.common.cdw10[0] = nvme_get_log_dw10(log_page, size);
+
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
+}
+
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
+	ret = nvme_get_log(ctrl, NVME_LOG_CMD_FX, ctrl->effects,
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
@@ -1797,6 +1894,12 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
+	if (id->lpa & NVME_CTRL_LPA_CMD_FX_LOG) {
+		ret = nvme_get_effects_log(ctrl);
+		if (ret < 0)
+			return ret;
+	}
+
 	nvme_init_subnqn(ctrl, id);
 
 	if (!ctrl->identified) {
@@ -2522,10 +2625,8 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
 
-static void nvme_scan_work(struct work_struct *work)
+static void nvme_scan(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *ctrl =
-		container_of(work, struct nvme_ctrl, scan_work);
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
@@ -2549,6 +2650,14 @@ static void nvme_scan_work(struct work_struct *work)
 	kfree(id);
 }
 
+static void nvme_scan_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, scan_work);
+
+	nvme_scan(ctrl);
+}
+
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -2615,18 +2724,13 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 
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
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d3f3c4447515..69dd8d2cf05c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -172,6 +172,7 @@ struct nvme_ctrl {
 	bool subsystem;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
+	struct nvme_effects_log *effects;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9310ce77d8e1..cad7bde44f8e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -267,6 +267,7 @@ enum {
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
+	NVME_CTRL_LPA_CMD_FX_LOG		= 1 << 1,
 };
 
 struct nvme_lbaf {
@@ -396,6 +397,22 @@ struct nvme_fw_slot_info_log {
 };
 
 enum {
+	NVME_CMD_FX_CSUPP	= 1 << 0,
+	NVME_CMD_FX_LBCC	= 1 << 1,
+	NVME_CMD_FX_NCC		= 1 << 2,
+	NVME_CMD_FX_NIC		= 1 << 3,
+	NVME_CMD_FX_CCC		= 1 << 4,
+	NVME_CMD_FX_CSE_MASK	= 3 << 16,
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
@@ -712,6 +729,7 @@ enum {
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_CMD_FX		= 0x05,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
 	NVME_FWACT_REPL		= (0 << 3),
--
