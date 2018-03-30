From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 30 Mar 2018 02:57:40 -0400
Subject: [RFC PATCH 1/8] nvme-core: add new interfaces
In-Reply-To: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180330065747.20962-2-chaitanya.kulkarni@wdc.com>

The new interface nvme_get_ctrl_by_name() allows to
search the nvme ctrl by its pathname. On success, it increments
the refcount of the ctrl and associated subsystem.
The caller needs to decrement the ctrl and
subsystem refcount by calling nvme_put_ctrl_by_name() once the
work is done.

This is a preparation patch for implementing NVMe Over Fabric
target passthru feature.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 61 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7aeca5db7916..c605bad46ebf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -99,12 +99,64 @@ static struct class *nvme_subsys_class;
 
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
+static int nvme_get_subsystem(struct nvme_subsystem *subsys);
+static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
 {
 	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
 }
 
+int nvme_get_ctrl_by_name(char *ctrl_name, struct nvme_ctrl **ctrl)
+{
+	int ret = -ENODEV;
+	char str[256] = "/dev/";
+	struct nvme_ctrl *ictrl = NULL;
+	struct nvme_subsystem *isubsys = NULL;
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(isubsys, &nvme_subsystems, entry) {
+		if (!nvme_get_subsystem(isubsys)) {
+			pr_info("failed to get the subsystem for ctrl %s\n",
+					ctrl_name);
+			goto out;
+		}
+		mutex_unlock(&nvme_subsystems_lock);
+
+		list_for_each_entry(ictrl, &isubsys->ctrls, subsys_entry) {
+			spin_lock(&ictrl->lock);
+			nvme_get_ctrl(ictrl);
+			strcat(str, kobject_name(&ictrl->device->kobj));
+			if (strncmp(str, ctrl_name, strlen(ctrl_name)) == 0) {
+				*ctrl = ictrl;
+				if (try_module_get(ictrl->ops->module)) {
+					spin_unlock(&ictrl->lock);
+					mutex_lock(&nvme_subsystems_lock);
+					ret = 0;
+					goto out;
+				}
+			}
+			nvme_put_ctrl(ictrl);
+			strcpy(str, "/dev/");
+			spin_unlock(&ictrl->lock);
+		}
+		mutex_lock(&nvme_subsystems_lock);
+		nvme_put_subsystem(isubsys);
+	}
+out:
+	mutex_unlock(&nvme_subsystems_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_get_ctrl_by_name);
+
+void nvme_put_ctrl_by_name(struct nvme_ctrl *ctrl)
+{
+	nvme_put_ctrl(ctrl);
+	module_put(ctrl->ops->module);
+	nvme_put_subsystem(ctrl->subsys);
+}
+EXPORT_SYMBOL_GPL(nvme_put_ctrl_by_name);
+
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -2024,6 +2076,13 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
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
index d733b14ede9d..d7c6ea850156 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -401,6 +401,8 @@ int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 
+int nvme_get_ctrl_by_name(char *name, struct nvme_ctrl **ctrl);
+void nvme_put_ctrl_by_name(struct nvme_ctrl *ctrl);
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
-- 
2.14.1
