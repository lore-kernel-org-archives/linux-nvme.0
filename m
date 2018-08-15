From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:52 -0400
Subject: [PATCH V4 7/9] nvmet: add configfs interface for target passthru
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-8-chaitanya.kulkarni@wdc.com>

This patch adds configfs interface for target passthru ctrl management.

The new directory "pt" under nvmet configfs is added to configure passthru
ctrl (pt-ctrl). Once all the fields for the pt-ctrl are set user can
enable the pt-ctrl through configfs.

The new directory pt is parallel to the subsystem and has similar
attributes as default subsystem, each passthru ctrl is represented as one
subsystem. Since we allow ctrl passthru we don't export or allow user to
access the passthru namespace(s) in the configfs.

The new attribute "attr_ctrl_path" expects nvme ctrl path,
e.g. "/dev/nvmeX".

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/configfs.c | 145 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 51f5a8c092b4..a7f5b508e5fa 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -21,6 +21,7 @@
 #include "nvmet.h"
 
 static const struct config_item_type nvmet_host_type;
+static const struct config_item_type nvmet_pt_type;
 static const struct config_item_type nvmet_subsys_type;
 
 static const struct nvmet_transport_name {
@@ -570,7 +571,8 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	struct nvmet_subsys_link *link, *p;
 	int ret;
 
-	if (target->ci_type != &nvmet_subsys_type) {
+	if (!(target->ci_type == &nvmet_subsys_type ||
+				target->ci_type == &nvmet_pt_type)) {
 		pr_err("can only link subsystems into the subsystems dir.!\n");
 		return -EINVAL;
 	}
@@ -865,6 +867,141 @@ static const struct config_item_type nvmet_subsystems_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+
+/*
+ * Passthru attributes and operations.
+ */
+static ssize_t nvmet_pt_attr_ctrl_path_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->pt_ctrl_path);
+}
+
+static ssize_t nvmet_pt_attr_ctrl_path_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret = -ENOMEM;
+
+	mutex_lock(&subsys->lock);
+	kfree(subsys->pt_ctrl_path);
+
+	subsys->pt_ctrl_path = kstrdup(page, GFP_KERNEL);
+	if (!subsys->pt_ctrl_path)
+		goto out_unlock;
+
+	mutex_unlock(&subsys->lock);
+
+	return count;
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+
+}
+CONFIGFS_ATTR(nvmet_pt_, attr_ctrl_path);
+
+static ssize_t nvmet_pt_attr_enable_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_subsys(item)->pt_ctrl ? 1 : 0);
+}
+
+static ssize_t nvmet_pt_attr_enable_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	bool enable;
+	int ret = 0;
+
+	if (subsys->pt_ctrl_path == NULL) {
+		pr_err("passthru ctrl path is not initialized.\n");
+		return -EINVAL;
+	}
+
+	if (strtobool(page, &enable))
+		return -EINVAL;
+
+	if (enable)
+		ret = nvmet_pt_ctrl_enable(subsys);
+	else
+		nvmet_pt_ctrl_disable(subsys);
+
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_pt_, attr_enable);
+
+static struct configfs_attribute *nvmet_pt_attrs[] = {
+	&nvmet_pt_attr_attr_ctrl_path,
+	&nvmet_pt_attr_attr_enable,
+	&nvmet_subsys_attr_attr_allow_any_host,
+	&nvmet_subsys_attr_attr_version,
+	&nvmet_subsys_attr_attr_serial,
+	NULL,
+};
+
+/*
+ * Passthru structures & folder operation functions below
+ */
+static void nvmet_pt_release(struct config_item *item)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	nvmet_subsys_del_ctrls(subsys);
+	/*
+	 * Since we are the only one to manage the pt ctrl,
+	 * disable the pt ctrl in case user did not disable
+	 * the ctrl attribute prior to removing the passthru subsystem.
+	 */
+
+	nvmet_pt_ctrl_disable(subsys);
+
+	nvmet_subsys_put(subsys);
+}
+
+static struct configfs_item_operations nvmet_pt_item_ops = {
+	.release		= nvmet_pt_release,
+};
+
+static const struct config_item_type nvmet_pt_type = {
+	.ct_item_ops		= &nvmet_pt_item_ops,
+	.ct_attrs		= nvmet_pt_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_pt_make(struct config_group *group,
+		const char *name)
+{
+	struct nvmet_subsys *subsys;
+
+	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
+		pr_err("can't create discovery subsystem through configfs\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	if (!subsys)
+		return ERR_PTR(-ENOMEM);
+
+	config_group_init_type_name(&subsys->group, name, &nvmet_pt_type);
+
+	config_group_init_type_name(&subsys->allowed_hosts_group,
+			"allowed_hosts", &nvmet_allowed_hosts_type);
+	configfs_add_default_group(&subsys->allowed_hosts_group,
+			&subsys->group);
+
+	return &subsys->group;
+}
+
+static struct configfs_group_operations nvmet_pts_group_ops = {
+	.make_group		= nvmet_pt_make,
+};
+
+static struct config_item_type nvmet_pts_type = {
+	.ct_group_ops		= &nvmet_pts_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
 static ssize_t nvmet_referral_enable_show(struct config_item *item,
 		char *page)
 {
@@ -1178,6 +1315,7 @@ static const struct config_item_type nvmet_ports_type = {
 };
 
 static struct config_group nvmet_subsystems_group;
+static struct config_group nvmet_pts_group;
 static struct config_group nvmet_ports_group;
 
 static void nvmet_host_release(struct config_item *item)
@@ -1241,6 +1379,11 @@ int __init nvmet_init_configfs(void)
 	config_group_init(&nvmet_configfs_subsystem.su_group);
 	mutex_init(&nvmet_configfs_subsystem.su_mutex);
 
+	config_group_init_type_name(&nvmet_pts_group,
+			"passthru", &nvmet_pts_type);
+	configfs_add_default_group(&nvmet_pts_group,
+			&nvmet_configfs_subsystem.su_group);
+
 	config_group_init_type_name(&nvmet_subsystems_group,
 			"subsystems", &nvmet_subsystems_type);
 	configfs_add_default_group(&nvmet_subsystems_group,
-- 
2.14.1
