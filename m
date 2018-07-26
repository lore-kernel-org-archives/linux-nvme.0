From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 17:35:05 +0200
Subject: [PATCH 9/9] nvmet: support configuring ANA groups
In-Reply-To: <20180726153505.4153-1-hch@lst.de>
References: <20180726153505.4153-1-hch@lst.de>
Message-ID: <20180726153505.4153-10-hch@lst.de>

Allow creating non-default ANA groups (group ID > 1).  Groups are created
either by assigning the group ID to a namespace, or by creating a configfs
group object under a specific port.  All namespaces assigned to a group
that doesn't have a configfs object for a given port are marked as
inaccessible.

Allow changing the ANA state on a per-port basis by creating an
ana_groups directory under each port, and another directory with an
ana_state file in it.  The default ANA group 1 directory is created
automatically for each port.

For all changes in ANA configuration the ANA change AEN is sent.  We only
keep a global changecount instead of additional per-group changecounts to
keep the implementation as simple as possible.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c |   1 +
 drivers/nvme/target/configfs.c  | 182 +++++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c      |  27 +++++
 drivers/nvme/target/nvmet.h     |  30 +++++-
 4 files changed, 236 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b98d38c4e579..d1de639786ee 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -235,6 +235,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 	hdr.chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
 	hdr.ngrps = cpu_to_le16(ngrps);
+	clear_bit(NVME_AEN_CFG_ANA_CHANGE, &req->sq->ctrl->aen_masked);
 	up_read(&nvmet_ana_sem);
 
 	kfree(desc);
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3c62b41b2ae..51f5a8c092b4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -411,6 +411,39 @@ static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_nguid);
 
+static ssize_t nvmet_ns_ana_grpid_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%u\n", to_nvmet_ns(item)->anagrpid);
+}
+
+static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	u32 oldgrpid, newgrpid;
+	int ret;
+
+	ret = kstrtou32(page, 0, &newgrpid);
+	if (ret)
+		return ret;
+
+	if (newgrpid < 1 || newgrpid > NVMET_MAX_ANAGRPS)
+		return -EINVAL;
+
+	down_write(&nvmet_ana_sem);
+	oldgrpid = ns->anagrpid;
+	nvmet_ana_group_enabled[newgrpid]++;
+	ns->anagrpid = newgrpid;
+	nvmet_ana_group_enabled[oldgrpid]--;
+	nvmet_ana_chgcnt++;
+	up_write(&nvmet_ana_sem);
+
+	nvmet_send_ana_event(ns->subsys, NULL);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, ana_grpid);
+
 static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
@@ -468,6 +501,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
+	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
 	NULL,
@@ -916,6 +950,134 @@ static const struct config_item_type nvmet_referrals_type = {
 	.ct_group_ops	= &nvmet_referral_group_ops,
 };
 
+static struct {
+	enum nvme_ana_state	state;
+	const char		*name;
+} nvmet_ana_state_names[] = {
+	{ NVME_ANA_OPTIMIZED,		"optimized" },
+	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
+	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
+	{ NVME_ANA_PERSISTENT_LOSS,	"persistent-loss" },
+	{ NVME_ANA_CHANGE,		"change" },
+};
+
+static ssize_t nvmet_ana_group_ana_state_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_ana_group *grp = to_ana_group(item);
+	enum nvme_ana_state state = grp->port->ana_state[grp->grpid];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state_names); i++) {
+		if (state != nvmet_ana_state_names[i].state)
+			continue;
+		return sprintf(page, "%s\n", nvmet_ana_state_names[i].name);
+	}
+
+	return sprintf(page, "\n");
+}
+
+static ssize_t nvmet_ana_group_ana_state_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ana_group *grp = to_ana_group(item);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_ana_state_names); i++) {
+		if (sysfs_streq(page, nvmet_ana_state_names[i].name))
+			goto found;
+	}
+
+	pr_err("Invalid value '%s' for ana_state\n", page);
+	return -EINVAL;
+
+found:
+	down_write(&nvmet_ana_sem);
+	grp->port->ana_state[grp->grpid] = nvmet_ana_state_names[i].state;
+	nvmet_ana_chgcnt++;
+	up_write(&nvmet_ana_sem);
+
+	nvmet_port_send_ana_event(grp->port);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ana_group_, ana_state);
+
+static struct configfs_attribute *nvmet_ana_group_attrs[] = {
+	&nvmet_ana_group_attr_ana_state,
+	NULL,
+};
+
+static void nvmet_ana_group_release(struct config_item *item)
+{
+	struct nvmet_ana_group *grp = to_ana_group(item);
+
+	if (grp == &grp->port->ana_default_group)
+		return;
+
+	down_write(&nvmet_ana_sem);
+	grp->port->ana_state[grp->grpid] = NVME_ANA_INACCESSIBLE;
+	nvmet_ana_group_enabled[grp->grpid]--;
+	up_write(&nvmet_ana_sem);
+
+	nvmet_port_send_ana_event(grp->port);
+	kfree(grp);
+}
+
+static struct configfs_item_operations nvmet_ana_group_item_ops = {
+	.release		= nvmet_ana_group_release,
+};
+
+static const struct config_item_type nvmet_ana_group_type = {
+	.ct_item_ops		= &nvmet_ana_group_item_ops,
+	.ct_attrs		= nvmet_ana_group_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_ana_groups_make_group(
+		struct config_group *group, const char *name)
+{
+	struct nvmet_port *port = ana_groups_to_port(&group->cg_item);
+	struct nvmet_ana_group *grp;
+	u32 grpid;
+	int ret;
+
+	ret = kstrtou32(name, 0, &grpid);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	if (grpid <= 1 || grpid > NVMET_MAX_ANAGRPS)
+		goto out;
+
+	ret = -ENOMEM;
+	grp = kzalloc(sizeof(*grp), GFP_KERNEL);
+	if (!grp)
+		goto out;
+	grp->port = port;
+	grp->grpid = grpid;
+
+	down_write(&nvmet_ana_sem);
+	nvmet_ana_group_enabled[grpid]++;
+	up_write(&nvmet_ana_sem);
+
+	nvmet_port_send_ana_event(grp->port);
+
+	config_group_init_type_name(&grp->group, name, &nvmet_ana_group_type);
+	return &grp->group;
+out:
+	return ERR_PTR(ret);
+}
+
+static struct configfs_group_operations nvmet_ana_groups_group_ops = {
+	.make_group		= nvmet_ana_groups_make_group,
+};
+
+static const struct config_item_type nvmet_ana_groups_type = {
+	.ct_group_ops		= &nvmet_ana_groups_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
 /*
  * Ports definitions.
  */
@@ -952,6 +1114,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 {
 	struct nvmet_port *port;
 	u16 portid;
+	u32 i;
 
 	if (kstrtou16(name, 0, &portid))
 		return ERR_PTR(-EINVAL);
@@ -967,7 +1130,12 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	port->ana_state[NVMET_DEFAULT_ANA_GRPID] = NVME_ANA_OPTIMIZED;
+	for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
+		if (i == NVMET_DEFAULT_ANA_GRPID)
+			port->ana_state[1] = NVME_ANA_OPTIMIZED;
+		else
+			port->ana_state[i] = NVME_ANA_INACCESSIBLE;
+	}
 
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
@@ -985,6 +1153,18 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 			"referrals", &nvmet_referrals_type);
 	configfs_add_default_group(&port->referrals_group, &port->group);
 
+	config_group_init_type_name(&port->ana_groups_group,
+			"ana_groups", &nvmet_ana_groups_type);
+	configfs_add_default_group(&port->ana_groups_group, &port->group);
+
+	port->ana_default_group.port = port;
+	port->ana_default_group.grpid = NVMET_DEFAULT_ANA_GRPID;
+	config_group_init_type_name(&port->ana_default_group.group,
+			__stringify(NVMET_DEFAULT_ANA_GRPID),
+			&nvmet_ana_group_type);
+	configfs_add_default_group(&port->ana_default_group.group,
+			&port->ana_groups_group);
+
 	return &port->group;
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 43a755f7baa5..3ceb7a03bb2a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -194,6 +194,33 @@ static void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 	}
 }
 
+void nvmet_send_ana_event(struct nvmet_subsys *subsys,
+		struct nvmet_port *port)
+{
+	struct nvmet_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (port && ctrl->port != port)
+			continue;
+		if (nvmet_aen_disabled(ctrl, NVME_AEN_CFG_ANA_CHANGE))
+			continue;
+		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+				NVME_AER_NOTICE_ANA, NVME_LOG_ANA);
+	}
+	mutex_unlock(&subsys->lock);
+}
+
+void nvmet_port_send_ana_event(struct nvmet_port *port)
+{
+	struct nvmet_subsys_link *p;
+
+	down_read(&nvmet_config_sem);
+	list_for_each_entry(p, &port->subsystems, entry)
+		nvmet_send_ana_event(p->subsys, port);
+	up_read(&nvmet_config_sem);
+}
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
 {
 	int ret = 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f7d622fc1aa7..22941045f46e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -30,12 +30,11 @@
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
 
-
 /*
  * Supported optional AENs:
  */
 #define NVMET_AEN_CFG_OPTIONAL \
-	NVME_AEN_CFG_NS_ATTR
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE)
 
 /*
  * Plus mandatory SMART AENs (we'll never send them, but allow enabling them):
@@ -99,6 +98,18 @@ struct nvmet_sq {
 	struct completion	confirm_done;
 };
 
+struct nvmet_ana_group {
+	struct config_group	group;
+	struct nvmet_port	*port;
+	u32			grpid;
+};
+
+static inline struct nvmet_ana_group *to_ana_group(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_ana_group,
+			group);
+}
+
 /**
  * struct nvmet_port -	Common structure to keep port
  *				information for the target.
@@ -116,6 +127,8 @@ struct nvmet_port {
 	struct list_head		subsystems;
 	struct config_group		referrals_group;
 	struct list_head		referrals;
+	struct config_group		ana_groups_group;
+	struct nvmet_ana_group		ana_default_group;
 	enum nvme_ana_state		*ana_state;
 	void				*priv;
 	bool				enabled;
@@ -128,6 +141,13 @@ static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
 			group);
 }
 
+static inline struct nvmet_port *ana_groups_to_port(
+		struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_port,
+			ana_groups_group);
+}
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_cq		**cqs;
@@ -345,6 +365,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns);
 struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_ns_free(struct nvmet_ns *ns);
 
+void nvmet_send_ana_event(struct nvmet_subsys *subsys,
+		struct nvmet_port *port);
+void nvmet_port_send_ana_event(struct nvmet_port *port);
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
 void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
 
@@ -378,7 +402,7 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
  * ANA Group 1 exists without manual intervention, has namespaces assigned to it
  * by default, and is available in an optimized state through all ports.
  */
-#define NVMET_MAX_ANAGRPS	1
+#define NVMET_MAX_ANAGRPS	128
 #define NVMET_DEFAULT_ANA_GRPID	1
 
 #define NVMET_KAS		10
-- 
2.18.0
