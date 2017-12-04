From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  4 Dec 2017 11:24:34 +0200
Subject: [PATCH rfc 1/2] nvme: support smart read-only critical warning event
In-Reply-To: <20171204092435.20000-1-sagi@grimberg.me>
References: <20171204092435.20000-1-sagi@grimberg.me>
Message-ID: <20171204092435.20000-2-sagi@grimberg.me>

In case a controller sent us a critical warning AER,
we should query the smart information and in case the
media was placed in read only mode, we need to set
all the controller namespaces (and the namespaces heads)
in read-only (or set to rw in case its not set).

Given that in fabrics we may also connect to a read-only
subsystem, we add the disk as read-only to start with.
Once the subsystem will be in rw mode, we restore
the disk rw permissions.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c      | 51 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  4 ++++
 drivers/nvme/host/nvme.h      |  2 ++
 3 files changed, 57 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25e3168cec44..eaae1b4f6a4e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2949,6 +2949,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	kfree(id);
 
+	if (ctrl->subsys->read_only)
+		set_disk_ro(ns->disk, true);
+
 	device_add_disk(ctrl->device, ns->disk);
 	if (sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group))
@@ -3192,6 +3195,49 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	kfree(log);
 }
 
+static void nvme_get_smart_log(struct nvme_ctrl *ctrl)
+{
+	struct nvme_smart_log *log;
+	struct nvme_ns *ns;
+
+	log = kmalloc(sizeof(*log), GFP_KERNEL);
+	if (!log)
+		return;
+
+	if (nvme_get_log(ctrl, NVME_LOG_SMART, log, sizeof(*log))) {
+		dev_warn(ctrl->device, "Get SMART log error\n");
+		goto out;
+	}
+
+	if (log->critical_warning & NVME_SMART_CRIT_MEDIA) {
+		dev_warn(ctrl->device,
+			"critical warning: media placed in read-only\n");
+		ctrl->subsys->read_only = true;
+	} else {
+		dev_info(ctrl->device,
+			"media placed in read-write mode\n");
+		ctrl->subsys->read_only = false;
+	}
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		set_disk_ro(ns->disk, ctrl->subsys->read_only);
+		if (ns->head->disk)
+			set_disk_ro(ns->head->disk, ctrl->subsys->read_only);
+	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+out:
+	kfree(log);
+}
+
+static void nvme_smart_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, smart_work);
+
+	nvme_get_smart_log(ctrl);
+}
+
 static void nvme_fw_act_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(work,
@@ -3251,6 +3297,9 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
+	case NVME_AER_SMART:
+		queue_work(nvme_wq, &ctrl->smart_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -3263,6 +3312,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	flush_work(&ctrl->smart_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
@@ -3328,6 +3378,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
+	INIT_WORK(&ctrl->smart_work, nvme_smart_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
 
 	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1218a9fca846..b833ba3c78cb 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -238,6 +238,10 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
+
+	if (head->subsys->read_only)
+		set_disk_ro(head->disk, true);
+
 	device_add_disk(&head->subsys->dev, head->disk);
 	if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
 			&nvme_ns_id_attr_group))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4361b71891e9..caa8f7130ec6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -181,6 +181,7 @@ struct nvme_ctrl {
 	struct nvme_id_power_state psd[32];
 	struct nvme_effects_log *effects;
 	struct work_struct scan_work;
+	struct work_struct smart_work;
 	struct work_struct async_event_work;
 	struct delayed_work ka_work;
 	struct work_struct fw_act_work;
@@ -226,6 +227,7 @@ struct nvme_subsystem {
 	u8			cmic;
 	u16			vendor_id;
 	struct ida		ns_ida;
+	bool			read_only;
 };
 
 /*
-- 
2.14.1
