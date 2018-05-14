From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 09:56:46 +0200
Subject: [PATCH 11/11] nvmet: support configuring additional ANA groups
In-Reply-To: <20180514075646.28823-1-hch@lst.de>
References: <20180514075646.28823-1-hch@lst.de>
Message-ID: <20180514075646.28823-12-hch@lst.de>

Mostly configfs boilerplate.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/configfs.c | 170 ++++++++++++++++++++++++++++++++-
 drivers/nvme/target/core.c     |  21 ++++
 drivers/nvme/target/nvmet.h    |  26 ++++-
 3 files changed, 215 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7aa5488dc453..ddc3fa9fd92f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -378,6 +378,39 @@ static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
 
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
+	nvmet_send_ana_event(ns->subsys);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, ana_grpid);
+
 static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
@@ -407,6 +440,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
+	&nvmet_ns_attr_ana_grpid,
 	&nvmet_ns_attr_enable,
 	NULL,
 };
@@ -854,6 +888,131 @@ static const struct config_item_type nvmet_referrals_type = {
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
@@ -889,6 +1048,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 {
 	struct nvmet_port *port;
 	u16 portid;
+	u32 i;
 
 	if (kstrtou16(name, 0, &portid))
 		return ERR_PTR(-EINVAL);
@@ -904,7 +1064,12 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
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
@@ -921,6 +1086,9 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 			"referrals", &nvmet_referrals_type);
 	configfs_add_default_group(&port->referrals_group, &port->group);
 
+	config_group_init_type_name(&port->ana_groups_group,
+			"ana_groups", &nvmet_ana_groups_type);
+	configfs_add_default_group(&port->ana_groups_group, &port->group);
 	return &port->group;
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1ee31cb60f7c..a7a14fa9cd3b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -161,6 +161,27 @@ static void nvmet_send_ns_changed_event(struct nvmet_subsys *subsys)
 				NVME_AER_NOTICE_NS_CHANGED, 0);
 }
 
+void nvmet_send_ana_event(struct nvmet_subsys *subsys)
+{
+	struct nvmet_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+				NVME_AER_NOTICE_ANA, NVME_LOG_ANA);
+	mutex_unlock(&subsys->lock);
+}
+
+void nvmet_port_send_ana_event(struct nvmet_port *port)
+{
+	struct nvmet_subsys_link *p;
+
+	down_read(&nvmet_config_sem);
+	list_for_each_entry(p, &port->subsystems, entry)
+		nvmet_send_ana_event(p->subsys);
+	up_read(&nvmet_config_sem);
+}
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
 {
 	int ret = 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f8394e61d3b9..442776c8470f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -24,6 +24,7 @@
 #include <linux/uuid.h>
 #include <linux/nvme.h>
 #include <linux/configfs.h>
+#include <linux/refcount.h>
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
 
@@ -97,6 +98,7 @@ struct nvmet_port {
 	struct list_head		subsystems;
 	struct config_group		referrals_group;
 	struct list_head		referrals;
+	struct config_group		ana_groups_group;
 	enum nvme_ana_state		*ana_state;
 	void				*priv;
 	bool				enabled;
@@ -108,6 +110,13 @@ static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
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
@@ -191,6 +200,18 @@ static inline char *nvmet_host_name(struct nvmet_host *host)
 	return config_item_name(&host->group.cg_item);
 }
 
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
 struct nvmet_host_link {
 	struct list_head	entry;
 	struct nvmet_host	*host;
@@ -306,6 +327,9 @@ void nvmet_ns_disable(struct nvmet_ns *ns);
 struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_ns_free(struct nvmet_ns *ns);
 
+void nvmet_send_ana_event(struct nvmet_subsys *subsys);
+void nvmet_port_send_ana_event(struct nvmet_port *port);
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
 void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
 
@@ -339,7 +363,7 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
  * ANA Group 1 exists without manual intervention, has namespaces assigned to it
  * by default, and is available in an optimized state through all ports.
  */
-#define NVMET_MAX_ANAGRPS	1
+#define NVMET_MAX_ANAGRPS	128
 #define NVMET_DEFAULT_ANA_GRPID	1
 
 #define NVMET_KAS		10
-- 
2.17.0
