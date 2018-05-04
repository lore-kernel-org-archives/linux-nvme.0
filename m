From: hare@suse.de (Hannes Reinecke)
Date: Fri,  4 May 2018 13:28:45 +0200
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180504112845.38820-1-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
Message-ID: <20180504112845.38820-6-hare@suse.de>

Add ANA support to the nvme host. If ANA is supported the state
and the group id are displayed in new sysfs attributes 'ana_state' and
'ana_group'.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      | 123 +++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c |  12 ++++-
 drivers/nvme/host/nvme.h      |   3 ++
 3 files changed, 136 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62262fac7a5d..14dff8e96899 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -99,6 +99,7 @@ static struct class *nvme_subsys_class;
 
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
+static void nvme_get_ana_log(struct nvme_ctrl *ctrl, struct nvme_ns *ns);
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -1488,6 +1489,9 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
+	if (ctrl->subsys->cmic & (1 << 3))
+		nvme_get_ana_log(ctrl, ns);
+
 	__nvme_revalidate_disk(disk, id);
 	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
 	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
@@ -2276,6 +2280,61 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static void nvme_get_ana_log(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	int i, j;
+	struct nvmf_ana_rsp_page_header *ana_log;
+	size_t ana_log_size = 4096;
+
+	ana_log = kzalloc(ana_log_size, GFP_KERNEL);
+	if (!ana_log)
+		return;
+
+	if (nvme_get_log(ctrl, NVME_LOG_ANA, ana_log, ana_log_size))
+		dev_warn(ctrl->device,
+			 "Get ANA log error\n");
+	for (i = 0; i < ana_log->grpid_num; i++) {
+		struct nvmf_ana_group_descriptor *desc =
+			&ana_log->desc[i];
+		for (j = 0; j < desc->nsid_num; j++) {
+			if (desc->nsid[j] == ns->head->ns_id) {
+				ns->ana_state = desc->ana_state;
+				ns->ana_group = desc->groupid;
+			}
+		}
+	}
+	kfree(ana_log);
+}
+
+static void nvme_get_full_ana_log(struct nvme_ctrl *ctrl)
+{
+	int i, j;
+	struct nvme_ns *ns;
+	struct nvmf_ana_rsp_page_header *ana_log;
+	size_t ana_log_size = 4096;
+
+	ana_log = kzalloc(ana_log_size, GFP_KERNEL);
+	if (!ana_log)
+		return;
+
+	if (nvme_get_log(ctrl, NVME_LOG_ANA, ana_log, ana_log_size))
+		dev_warn(ctrl->device,
+			 "Get ANA log error\n");
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		for (i = 0; i < ana_log->grpid_num; i++) {
+			struct nvmf_ana_group_descriptor *desc =
+				&ana_log->desc[i];
+			for (j = 0; j < desc->nsid_num; j++) {
+				if (desc->nsid[j] == ns->head->ns_id) {
+					ns->ana_state = desc->ana_state;
+					ns->ana_group = desc->groupid;
+				}
+			}
+		}
+	}
+	kfree(ana_log);
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -2631,12 +2690,45 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	switch (ns->ana_state & 0x0f) {
+	case NVME_ANA_STATE_OPTIMIZED:
+		return sprintf(buf, "optimized\n");
+	case NVME_ANA_STATE_NONOPTIMIZED:
+		return sprintf(buf, "non-optimized\n");
+	case NVME_ANA_STATE_INACCESSIBLE:
+		return sprintf(buf, "inaccessible\n");
+	case NVME_ANA_STATE_PERSISTENT_LOSS:
+		return sprintf(buf, "persistent-loss\n");
+	case NVME_ANA_STATE_CHANGE_STATE:
+		return sprintf(buf, "change-state\n");
+	default:
+		return sprintf(buf, "<reserved>\n");
+	}
+}
+static DEVICE_ATTR_RO(ana_state);
+
+static ssize_t ana_group_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_disk(dev)->private_data;
+	return sprintf(buf, "%d\n", ns->ana_group);
+
+}
+static DEVICE_ATTR_RO(ana_group);
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_ana_state.attr,
+	&dev_attr_ana_group.attr,
 	NULL,
 };
 
@@ -2645,6 +2737,7 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
 		if (uuid_is_null(&ids->uuid) &&
@@ -2659,6 +2752,12 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
+	if ((a == &dev_attr_ana_state.attr) ||
+	    (a == &dev_attr_ana_group.attr)) {
+		if (!ns->ctrl || !ns->ctrl->subsys ||
+		    !(ns->ctrl->subsys->cmic & (1 << 3)))
+			return 0;
+	}
 	return a->mode;
 }
 
@@ -2984,6 +3083,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
+	ns->ana_state = NVME_ANA_STATE_OPTIMIZED;
 
 	kref_init(&ns->kref);
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
@@ -3001,7 +3101,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_init_ns_head(ns, nsid, id))
 		goto out_free_id;
 	nvme_setup_streams_ns(ctrl, ns);
-	
+
+	if (ctrl->subsys->cmic & (1 << 3))
+		nvme_get_ana_log(ctrl, ns);
 #ifdef CONFIG_NVME_MULTIPATH
 	/*
 	 * If multipathing is enabled we need to always use the subsystem
@@ -3343,6 +3445,19 @@ static void nvme_fw_act_work(struct work_struct *work)
 	nvme_get_fw_slot_info(ctrl);
 }
 
+static void nvme_ana_change_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, ana_change_work);
+
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+
+	down_read(&ctrl->namespaces_rwsem);
+	nvme_get_full_ana_log(ctrl);
+	up_read(&ctrl->namespaces_rwsem);
+}
+
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
@@ -3370,6 +3485,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
+	case NVME_AER_NOTICE_ANA_CHANGE:
+		dev_info(ctrl->device, "ANA state change\n");
+		queue_work(nvme_wq, &ctrl->ana_change_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -3383,6 +3502,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
 	cancel_work_sync(&ctrl->fw_act_work);
+	cancel_work_sync(&ctrl->ana_change_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
 }
@@ -3449,6 +3569,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
+	INIT_WORK(&ctrl->ana_change_work, nvme_ana_change_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
 
 	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 956e0b8e9c4d..077b56f1739a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -56,8 +56,18 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
 
+	/* First round: select from all ANA optimized paths */
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (ns->ctrl->state == NVME_CTRL_LIVE) {
+		if (ns->ctrl->state == NVME_CTRL_LIVE &&
+		    ns->ana_state == NVME_ANA_STATE_OPTIMIZED) {
+			rcu_assign_pointer(head->current_path, ns);
+			return ns;
+		}
+	}
+	/* Second round: select from all ANA non-optimized paths */
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (ns->ctrl->state == NVME_CTRL_LIVE &&
+		    ns->ana_state == NVME_ANA_STATE_NONOPTIMIZED) {
 			rcu_assign_pointer(head->current_path, ns);
 			return ns;
 		}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecfd44f5..75182a5cc166 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -187,6 +187,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
+	struct work_struct ana_change_work;
 
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
@@ -289,6 +290,8 @@ struct nvme_ns {
 	u32 sws;
 	bool ext;
 	u8 pi_type;
+	u8 ana_state;
+	u32 ana_group;
 	unsigned long flags;
 #define NVME_NS_REMOVING 0
 #define NVME_NS_DEAD     1
-- 
2.12.3
