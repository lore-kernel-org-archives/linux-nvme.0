From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:03 -0400
Subject: [PATCH 12/20] nvmet: add a configfs entry for subsys mount path
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-13-chaitanya.kulkarni@wdc.com>

This patch adds new directory "fs" parallel to subsystems.
This new directory contains an additional attribute to
initialize the mount_path for the file backed subsystems.
This is actually a subsystem and uses all the existing
attributes from the subsystem.

The main difference is for file-backed namespaces we don't
allow the user to create namespaces on the target side, the user can
only create/delete namespaces from the host side with nvme
create-ns/delete-ns commands. So in the configfs, we don't provide
the namespaces directory with newly added "fs" directory.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/configfs.c | 105 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index bc95be1276c6..f571dffbecdc 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -21,6 +21,7 @@
 #include "nvmet.h"
 
 static const struct config_item_type nvmet_host_type;
+static const struct config_item_type nvmet_fs_type;
 static const struct config_item_type nvmet_subsys_type;
 
 /*
@@ -504,7 +505,8 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	struct nvmet_subsys_link *link, *p;
 	int ret;
 
-	if (target->ci_type != &nvmet_subsys_type) {
+	if (!(target->ci_type == &nvmet_subsys_type ||
+				target->ci_type == &nvmet_fs_type)) {
 		pr_err("can only link subsystems into the subsystems dir.!\n");
 		return -EINVAL;
 	}
@@ -799,6 +801,101 @@ static const struct config_item_type nvmet_subsystems_type = {
 	.ct_owner		= THIS_MODULE,
 };
 
+
+/*
+ * File backed subsys attributes and operations.
+ */
+static ssize_t nvmet_fs_attr_mount_path_show(struct config_item *item,
+			char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", subsys->mount_path);
+}
+
+static ssize_t nvmet_fs_attr_mount_path_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	int ret = count;
+
+	mutex_lock(&subsys->lock);
+	kfree(subsys->mount_path);
+
+	subsys->mount_path = kstrdup(page, GFP_KERNEL);
+	if (!subsys->mount_path)
+		ret = -ENOMEM;
+
+	mutex_unlock(&subsys->lock);
+
+	return ret;
+}
+
+CONFIGFS_ATTR(nvmet_fs_, attr_mount_path);
+
+static struct configfs_attribute *nvmet_fs_attrs[] = {
+	&nvmet_fs_attr_attr_mount_path,
+	&nvmet_subsys_attr_attr_allow_any_host,
+	&nvmet_subsys_attr_attr_version,
+	&nvmet_subsys_attr_attr_serial,
+	NULL,
+};
+
+/*
+ * File backed subsys structures & folder operation functions below.
+ */
+static void nvmet_fs_release(struct config_item *item)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	nvmet_subsys_del_ctrls(subsys);
+
+	nvmet_subsys_put(subsys);
+}
+
+static struct configfs_item_operations nvmet_fs_item_ops = {
+	.release		= nvmet_fs_release,
+};
+
+static const struct config_item_type nvmet_fs_type = {
+	.ct_item_ops		= &nvmet_fs_item_ops,
+	.ct_attrs		= nvmet_fs_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_fs_make(struct config_group *group,
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
+	config_group_init_type_name(&subsys->group, name, &nvmet_fs_type);
+
+	config_group_init_type_name(&subsys->allowed_hosts_group,
+			"allowed_hosts", &nvmet_allowed_hosts_type);
+	configfs_add_default_group(&subsys->allowed_hosts_group,
+			&subsys->group);
+
+	return &subsys->group;
+}
+
+static struct configfs_group_operations nvmet_fss_group_ops = {
+	.make_group		= nvmet_fs_make,
+};
+
+static struct config_item_type nvmet_fss_type = {
+	.ct_group_ops		= &nvmet_fss_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
 static ssize_t nvmet_referral_enable_show(struct config_item *item,
 		char *page)
 {
@@ -954,6 +1051,7 @@ static const struct config_item_type nvmet_ports_type = {
 };
 
 static struct config_group nvmet_subsystems_group;
+static struct config_group nvmet_fss_group;
 static struct config_group nvmet_ports_group;
 
 static void nvmet_host_release(struct config_item *item)
@@ -1017,6 +1115,11 @@ int __init nvmet_init_configfs(void)
 	config_group_init(&nvmet_configfs_subsystem.su_group);
 	mutex_init(&nvmet_configfs_subsystem.su_mutex);
 
+	config_group_init_type_name(&nvmet_fss_group,
+			"fs", &nvmet_fss_type);
+	configfs_add_default_group(&nvmet_fss_group,
+			&nvmet_configfs_subsystem.su_group);
+
 	config_group_init_type_name(&nvmet_subsystems_group,
 			"subsystems", &nvmet_subsystems_type);
 	configfs_add_default_group(&nvmet_subsystems_group,
-- 
2.14.1
