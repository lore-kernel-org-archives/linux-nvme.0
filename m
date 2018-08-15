From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:46 -0400
Subject: [PATCH V4 1/9] nvme-core: add new interfaces to access nvme-ctrl
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-2-chaitanya.kulkarni@wdc.com>

The new interface nvme_get_ctrl_by_path() allows to search the nvme ctrl
by its pathname. On success, it increments the refcount of the ctrl and
associated subsystem. The caller needs to decrement the ctrl and
subsystem refcount by calling nvme_put_ctrl_by_path() once the work is
done.

This is a preparation patch for implementing NVMe Over Fabric target
passthru feature.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 2 files changed, 66 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..efc24d441d79 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -99,6 +99,7 @@ static struct class *nvme_subsys_class;
 
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
+static int nvme_get_subsystem(struct nvme_subsystem *subsys);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
@@ -126,6 +127,61 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 		queue_work(nvme_wq, &ctrl->scan_work);
 }
 
+int nvme_get_ctrl_by_path(char *path, struct nvme_ctrl **ctrl)
+{
+	int ret = -ENODEV;
+	char *cdev = strrchr(path, '/');
+	struct nvme_ctrl *ictrl = NULL;
+	struct nvme_subsystem *isubsys = NULL;
+
+	if (!cdev) {
+		*ctrl = NULL;
+		return ret;
+	}
+	cdev++;
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(isubsys, &nvme_subsystems, entry) {
+		if (!nvme_get_subsystem(isubsys)) {
+			pr_info("failed to get the subsystem for ctrl %s\n",
+					path);
+			goto out;
+		}
+		mutex_unlock(&nvme_subsystems_lock);
+
+		list_for_each_entry(ictrl, &isubsys->ctrls, subsys_entry) {
+			spin_lock(&ictrl->lock);
+			nvme_get_ctrl(ictrl);
+			if (strcmp(cdev, kobject_name(&ictrl->device->kobj))
+					== 0) {
+				*ctrl = ictrl;
+				if (try_module_get(ictrl->ops->module)) {
+					spin_unlock(&ictrl->lock);
+					mutex_lock(&nvme_subsystems_lock);
+					ret = 0;
+					goto out;
+				}
+			}
+			nvme_put_ctrl(ictrl);
+			spin_unlock(&ictrl->lock);
+		}
+		mutex_lock(&nvme_subsystems_lock);
+		nvme_put_subsystem(isubsys);
+	}
+out:
+	mutex_unlock(&nvme_subsystems_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_get_ctrl_by_path);
+
+void nvme_put_ctrl_by_path(struct nvme_ctrl *ctrl)
+{
+	nvme_put_ctrl(ctrl);
+	module_put(ctrl->ops->module);
+	nvme_put_subsystem(ctrl->subsys);
+}
+EXPORT_SYMBOL_GPL(nvme_put_ctrl_by_path);
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -2119,6 +2175,13 @@ static void nvme_destroy_subsystem(struct kref *ref)
 	put_device(&subsys->dev);
 }
 
+static int nvme_get_subsystem(struct nvme_subsystem *subsys)
+{
+	lockdep_assert_held(&nvme_subsystems_lock);
+
+	return kref_get_unless_zero(&subsys->ref);
+}
+
 static void nvme_put_subsystem(struct nvme_subsystem *subsys)
 {
 	kref_put(&subsys->ref, nvme_destroy_subsystem);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..495eafcb9e9d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -547,6 +547,9 @@ static inline void nvme_mpath_stop(struct nvme_ctrl *ctrl)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+int nvme_get_ctrl_by_path(char *name, struct nvme_ctrl **ctrl);
+void nvme_put_ctrl_by_path(struct nvme_ctrl *ctrl);
+
 #ifdef CONFIG_NVM
 void nvme_nvm_update_nvm_info(struct nvme_ns *ns);
 int nvme_nvm_register(struct nvme_ns *ns, char *disk_name, int node);
-- 
2.14.1
