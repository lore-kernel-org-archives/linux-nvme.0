From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 13 Nov 2017 12:29:42 +0000
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
Message-ID: <1510576183-17215-4-git-send-email-israelr@mellanox.com>

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
 drivers/nvme/target/configfs.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  8 +++++
 drivers/nvme/target/nvmet.h    | 12 +++++++
 3 files changed, 92 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b6aeb1d..2413df6 100644
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
+	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->traddr);
+}
+
+CONFIGFS_ATTR_RO(nvmet_ctrl_, traddr);
+
+static ssize_t nvmet_ctrl_trsvcid_show(struct config_item *item, char *page)
+{
+	struct nvmet_ctrl *ctrl = to_nvmet_ctrl(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n", ctrl->trsvcid);
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
 
@@ -983,6 +1030,31 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
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
+	pr_debug("Adding controller %s to configfs\n", name);
+
+	config_group_init_type_name(&ctrl->group, name, &nvmet_ctrl_type);
+
+	res = configfs_register_group(&ctrl->subsys->controllers_group,
+				      &ctrl->group);
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
index 995976e..631c0c5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -842,6 +842,12 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		/* keep-alive timeout in seconds */
 		ctrl->kato = DIV_ROUND_UP(kato, 1000);
 	}
+	memcpy(ctrl->traddr, req->port->disc_addr.traddr, NVMF_TRADDR_SIZE);
+	memcpy(ctrl->trsvcid, req->port->disc_addr.trsvcid, NVMF_TRSVCID_SIZE);
+	ret = nvmet_ctrl_configfs_create(ctrl);
+	if (ret)
+		goto out_remove_ida;
+
 	nvmet_start_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
@@ -876,6 +882,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_stop_keep_alive_timer(ctrl);
 
+	nvmet_ctrl_configfs_del(ctrl);
+
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 194ebff..c8fa32d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -134,8 +134,17 @@ struct nvmet_ctrl {
 
 	char			subsysnqn[NVMF_NQN_FIELD_LEN];
 	char			hostnqn[NVMF_NQN_FIELD_LEN];
+	char			traddr[NVMF_TRADDR_SIZE];
+	char			trsvcid[NVMF_TRSVCID_SIZE];
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
 
@@ -160,6 +169,7 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+	struct config_group	controllers_group;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -288,6 +298,8 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 		struct nvmet_req *req, struct nvmet_ctrl **ret);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
+int nvmet_ctrl_configfs_create(struct nvmet_ctrl *ctrl);
+void nvmet_ctrl_configfs_del(struct nvmet_ctrl *ctrl);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
-- 
1.8.3.1
