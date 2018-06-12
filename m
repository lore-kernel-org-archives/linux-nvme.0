From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 12 Jun 2018 15:55:00 -0400
Subject: [PATCH V3 2/8] nvme-core: add new interfaces
In-Reply-To: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
References: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180612195506.23616-3-chaitanya.kulkarni@wdc.com>

The new interface nvme_get_ctrl_by_path() allows to
search the nvme ctrl by its pathname. On success, it increments
the refcount of the ctrl and associated subsystem.
The caller needs to decrement the ctrl and
subsystem refcount by calling nvme_put_ctrl_by_path() once the
work is done.

This is a preparation patch for implementing NVMe Over Fabric
target passthru feature.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 65 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 ++
 2 files changed, 68 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c5495dbd33d1..221771145eae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -100,6 +100,8 @@ static struct class *nvme_subsys_class;
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
+static int nvme_get_subsystem(struct nvme_subsystem *subsys);
+static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -110,6 +112,62 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
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
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -2060,6 +2118,13 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	memset(subsys->subnqn + off, 0, sizeof(subsys->subnqn) - off);
 }
 
+static int nvme_get_subsystem(struct nvme_subsystem *subsys)
+{
+	lockdep_assert_held(&nvme_subsystems_lock);
+
+	return kref_get_unless_zero(&subsys->ref);
+}
+
 static void __nvme_release_subsystem(struct nvme_subsystem *subsys)
 {
 	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 34df07d44f80..97840728dc9f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -439,6 +439,9 @@ int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		u8 log_page, void *log, size_t size, u64 offset);
 
+int nvme_get_ctrl_by_path(char *name, struct nvme_ctrl **ctrl);
+void nvme_put_ctrl_by_path(struct nvme_ctrl *ctrl);
+
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
-- 
2.17.0
