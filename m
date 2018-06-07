From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 09:35:53 +0200
Subject: [PATCH 1/4] nvmet: make ANATT configurable
In-Reply-To: <20180607073556.39050-1-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
Message-ID: <20180607073556.39050-2-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c |  2 +-
 drivers/nvme/target/configfs.c  | 34 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 8de264ece826..a49e1435fa54 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -315,7 +315,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->msdbd = ctrl->ops->msdbd;
 
 	id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
-	id->anatt = 10; /* random value */
+	id->anatt = req->port->anatt;
 	id->anagrpmax = cpu_to_le32(NVMET_MAX_ANAGRPS);
 	id->nanagrpid = cpu_to_le32(NVMET_MAX_ANAGRPS);
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index c5a770ac2f34..cca4de356818 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -265,6 +265,38 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
 
+static ssize_t nvmet_anatt_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", port->anatt);
+}
+
+static ssize_t nvmet_anatt_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int ret;
+	u8 ana_tt;
+
+	ret = kstrtou8(page, 0, &ana_tt);
+	if (ret || ana_tt == 0)
+		return -EINVAL;
+
+	if (port->enabled) {
+		pr_err("Cannot modify ANA transition timeout while enabled\n");
+		return -EACCES;
+	}
+	down_write(&nvmet_config_sem);
+	port->anatt = ana_tt;
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, anatt);
+
 /*
  * Namespace structures & file operation functions below
  */
@@ -1033,6 +1065,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_anatt,
 	NULL,
 };
 
@@ -1077,6 +1110,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
+	port->anatt = NVMET_DEFAULT_ANATT;
 
 	port->disc_addr.portid = cpu_to_le16(portid);
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1f562732baf3..948209d5f803 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -132,6 +132,7 @@ struct nvmet_port {
 	enum nvme_ana_state		*ana_state;
 	void				*priv;
 	bool				enabled;
+	u8				anatt;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -399,6 +400,7 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
  */
 #define NVMET_MAX_ANAGRPS	128
 #define NVMET_DEFAULT_ANA_GRPID	1
+#define NVMET_DEFAULT_ANATT	10
 
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO		120
-- 
2.12.3
