From: javier@javigon.com (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Fri, 13 Apr 2018 13:43:00 +0200
Subject: [PATCH] nvme: allow lightnvm to have visibility over AER events
In-Reply-To: <1523619780-10882-1-git-send-email-javier@cnexlabs.com>
References: <1523619780-10882-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1523619780-10882-2-git-send-email-javier@cnexlabs.com>

---
 drivers/nvme/host/core.c     | 37 +++++++++++++++++++++----
 drivers/nvme/host/lightnvm.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h     |  3 ++
 include/linux/lightnvm.h     | 24 ++++++++++++++++
 include/linux/nvme.h         |  1 +
 5 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f81e3b323366..e08cd59e6049 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3263,15 +3263,31 @@ static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 	kfree(envp[0]);
 }
 
-static void nvme_async_event_work(struct work_struct *work)
+static void nvme_async_event(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *ctrl =
-		container_of(work, struct nvme_ctrl, async_event_work);
-
 	nvme_aen_uevent(ctrl);
 	ctrl->ops->submit_async_event(ctrl);
 }
 
+static void nvme_async_event_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, async_event_work);
+
+	nvme_async_event(ctrl);
+}
+
+static void nvme_aer_handle_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, aer_handle_work);
+
+	if (ctrl->aen_result & NVME_AER_NOTICE_LNVM_CHUNK)
+		nvme_nvm_aer_handle(ctrl);
+
+	nvme_async_event(ctrl);
+}
+
 static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 {
 
@@ -3362,7 +3378,16 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
-	queue_work(nvme_wq, &ctrl->async_event_work);
+
+	/* TODO: Create a flag signaling the events that require kernel handling
+	 * to make this treatment generic
+	 */
+	if (result & NVME_AER_NOTICE_LNVM_CHUNK) {
+		ctrl->aen_result = result;
+		queue_work(nvme_wq, &ctrl->aer_handle_work);
+	} else {
+		queue_work(nvme_wq, &ctrl->async_event_work);
+	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
 
@@ -3370,6 +3395,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
+	flush_work(&ctrl->aer_handle_work);
 	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 	if (ctrl->ops->stop_ctrl)
@@ -3437,6 +3463,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
+	INIT_WORK(&ctrl->aer_handle_work, nvme_aer_handle_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
 
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 41279da799ed..f51200447503 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -250,6 +250,17 @@ struct nvme_nvm_chk_meta {
 	__le64	wp;
 };
 
+struct nvme_ocssd_log {
+	__le64	notification_count;
+	__le64	lba;
+	__le32	nsid;
+	__le16	state			:5;
+	__le16	rsvd_state		:11;
+	__u8	lba_mask		:3;
+	__u8	lba_state		:5;
+	__u8	rsvd_23_63[41];
+};
+
 /*
  * Check we didn't inadvertently grow the command struct
  */
@@ -950,6 +961,60 @@ static int nvme_nvm_user_vcmd(struct nvme_ns *ns, int admin,
 	return ret;
 }
 
+void nvm_print_log_page(struct nvme_ocssd_log *log)
+{
+	printk(KERN_CRIT "cnt(%llu), ppa(0x%llx), nsid(%u), st(0x%05x), msk(0x%03x)\n",
+		log->notification_count, log->lba, log->nsid, log->state,
+		log->lba_mask);
+}
+
+void nvme_nvm_aer_handle(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *iter, *ns = NULL;
+	struct nvm_dev *nvmdev;
+	struct nvme_command c = {};
+	struct nvme_ocssd_log log;
+	struct nvm_log_page log_page;
+	int ret;
+
+	c.common.opcode = nvme_admin_get_log_page;
+	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
+	c.common.cdw10[0] = cpu_to_le32(
+			(((sizeof(struct nvme_ocssd_log) / 4) - 1) << 16) |
+			 0xd0);
+
+	memset(&log, 0, sizeof(struct nvme_ocssd_log));
+
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, &log,
+						sizeof(struct nvme_ocssd_log));
+	if (ret)
+		return;
+
+	log_page.ppa.ppa = log.lba;
+	log_page.scope = log.lba_mask & NVM_LOGPAGE_STATE_MASK;
+	log_page.severity = log.state & NVM_LOGPAGE_SEVERITY_MASK;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(iter, &ctrl->namespaces, list) {
+		if (iter->head->ns_id == log.nsid) {
+			ns = iter;
+			break;
+		}
+	}
+	up_read(&ctrl->namespaces_rwsem);
+
+	if (!ns)
+		return;
+
+	nvmdev = ns->ndev;
+
+	/* TODO: TOGO */
+	nvm_print_log_page(&log);
+
+	/* nvm_notify_log_page(nvmdev, log_page); */
+
+}
+
 int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index aa10842a6709..7d760f54b175 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -183,6 +183,7 @@ struct nvme_ctrl {
 	struct nvme_effects_log *effects;
 	struct work_struct scan_work;
 	struct work_struct async_event_work;
+	struct work_struct aer_handle_work;
 	struct delayed_work ka_work;
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
@@ -506,6 +507,7 @@ void nvme_nvm_unregister(struct nvme_ns *ns);
 int nvme_nvm_register_sysfs(struct nvme_ns *ns);
 void nvme_nvm_unregister_sysfs(struct nvme_ns *ns);
 int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd, unsigned long arg);
+void nvme_nvm_aer_handle(struct nvme_ctrl *ctrl);
 #else
 static inline void nvme_nvm_update_nvm_info(struct nvme_ns *ns) {};
 static inline int nvme_nvm_register(struct nvme_ns *ns, char *disk_name,
@@ -525,6 +527,7 @@ static inline int nvme_nvm_ioctl(struct nvme_ns *ns, unsigned int cmd,
 {
 	return -ENOTTY;
 }
+static inline void nvme_nvm_aer_handle(struct nvme_ctrl *ctrl) {};
 #endif /* CONFIG_NVM */
 
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 6e0859b9d4d2..001c64690125 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -233,6 +233,30 @@ struct nvm_addrf {
 };
 
 enum {
+	/* valid bit mask */
+	NVM_LOGPAGE_STATE_MASK		= 0x3,
+	NVM_LOGPAGE_SEVERITY_MASK	= 0x5,
+
+	/* scope */
+	NVM_LOGPAGE_SCOPE_SECTOR	= 1,
+	NVM_LOGPAGE_SCOPE_CHUNK		= 2,
+	NVM_LOGPAGE_SCOPE_LUN		= 4,
+
+	/* severity */
+	NVM_LOGPAGE_SEVERITY_LOW	= 1,
+	NVM_LOGPAGE_SEVERITY_MID	= 2,
+	NVM_LOGPAGE_SEVERITY_HIGH	= 4,
+	NVM_LOGPAGE_SEVERITY_UNREC	= 8,
+	NVM_LOGPAGE_SEVERITY_DEV	= 16,
+};
+
+struct nvm_log_page {
+	struct ppa_addr ppa;
+	u16 scope;
+	u8 severity;
+};
+
+enum {
 	/* Chunk states */
 	NVM_CHK_ST_FREE =	1 << 0,
 	NVM_CHK_ST_CLOSED =	1 << 1,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4112e2bd747f..f85053601c5b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -440,6 +440,7 @@ enum {
 	NVME_AER_VS			= 7,
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
+	NVME_AER_NOTICE_LNVM_CHUNK	= 0xd00007,
 };
 
 struct nvme_lba_range_type {
-- 
2.7.4
