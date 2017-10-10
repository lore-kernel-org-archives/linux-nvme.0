From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 10 Oct 2017 14:40:32 +0300
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
Message-ID: <1507635633-16665-4-git-send-email-israelr@mellanox.com>

The commit show all the controllers and some info about them.
This will allow the user to monitor the created controllers from target
point of view.
The "controllers" folder was added per subsystem under:
/config/nvmet/subsystems/<SUBSYSTEM_NAME>/controllers/<CTRL_ID>/

<CTRL_ID> folder consists of:
 - hostnqn: Host NQN
 - port_traddr: Port Transport Address
 - port_trsvcid: Port Transport Service ID

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/configfs.c | 73 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  6 ++++
 drivers/nvme/target/nvmet.h    | 10 ++++++
 3 files changed, 89 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b6aeb1d..a0942c3 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -469,6 +469,49 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
 	.ct_owner		= THIS_MODULE,
 };
 
+static ssize_t nvmet_ctrl_hostnqn_show(struct config_item *item, char *page)
+{
+	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->hostnqn);
+}
+
+CONFIGFS_ATTR_RO(nvmet_ctrl_, hostnqn);
+
+static ssize_t nvmet_ctrl_traddr_show(struct config_item *item, char *page)
+{
+	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->port->disc_addr.traddr);
+}
+
+CONFIGFS_ATTR_RO(nvmet_ctrl_, traddr);
+
+static ssize_t nvmet_ctrl_trsvcid_show(struct config_item *item, char *page)
+{
+	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->port->disc_addr.trsvcid);
+}
+
+CONFIGFS_ATTR_RO(nvmet_ctrl_, trsvcid);
+
+static struct configfs_attribute *nvmet_ctrl_attrs[] = {
+	&nvmet_ctrl_attr_hostnqn,
+	&nvmet_ctrl_attr_traddr,
+	&nvmet_ctrl_attr_trsvcid,
+	NULL,
+};
+
+static struct config_item_type nvmet_ctrl_type = {
+	.ct_attrs		= nvmet_ctrl_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_item_type nvmet_controllers_type = {
+	.ct_owner		= THIS_MODULE,
+};
+
 static int nvmet_port_subsys_allow_link(struct config_item *parent,
 		struct config_item *target)
 {
@@ -760,6 +803,10 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 	configfs_add_default_group(&subsys->allowed_hosts_group,
 			&subsys->group);
 
+	config_group_init_type_name(&subsys->controllers_group,
+			"controllers", &nvmet_controllers_type);
+	configfs_add_default_group(&subsys->controllers_group, &subsys->group);
+
 	return &subsys->group;
 }
 
@@ -983,6 +1030,32 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
 	},
 };
 
+void nvmet_ctrl_configfs_del(struct nvmet_ctrl *ctrl)
+{
+	if (d_inode(ctrl->group.cg_item.ci_dentry))
+		configfs_unregister_group(&ctrl->group);
+}
+
+int nvmet_ctrl_configfs_create(struct nvmet_ctrl *ctrl)
+{
+	int res = 0;
+	char name[CONFIGFS_ITEM_NAME_LEN];
+
+	sprintf(name, "%d", ctrl->cntlid);
+	pr_info("Adding controller %s to configfs\n", name);
+
+	config_group_init_type_name(&ctrl->group, name, &nvmet_ctrl_type);
+
+	res = configfs_register_group(&ctrl->subsys->controllers_group,
+				      &ctrl->group);
+
+	if (res)
+		pr_err("failed to register configfs group for controller %s\n",
+		       name);
+
+	return res;
+}
+
 int __init nvmet_init_configfs(void)
 {
 	int ret;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 711df73..99bbf49 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -820,6 +820,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		ctrl->kato = DIV_ROUND_UP(kato, 1000);
 	}
 	ctrl->port = req->port;
+	ret = nvmet_ctrl_configfs_create(ctrl);
+	if (ret)
+		goto out_remove_ida;
+
 	nvmet_start_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
@@ -854,6 +858,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_stop_keep_alive_timer(ctrl);
 
+	nvmet_ctrl_configfs_del(ctrl);
+
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc586e7..1d49873 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -135,8 +135,15 @@ struct nvmet_ctrl {
 
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
+
+	struct config_group	group;
 };
 
+static inline struct nvmet_ctrl *to_nvmet_ctrl(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_ctrl, group);
+}
+
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
 
@@ -161,6 +168,7 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+	struct config_group	controllers_group;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -285,6 +293,8 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 		struct nvmet_req *req, struct nvmet_ctrl **ret);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
+int nvmet_ctrl_configfs_create(struct nvmet_ctrl *ctrl);
+void nvmet_ctrl_configfs_del(struct nvmet_ctrl *ctrl);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
-- 
1.8.4.3
