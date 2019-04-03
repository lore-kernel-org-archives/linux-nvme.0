From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Apr 2019 01:06:54 +0200
Subject: [PATCHv2] nvmet: make MDTS value configurable
Message-ID: <20190403230654.109698-1-hare@suse.de>

Some drivers and/or use-cases might need to set a smaller MDTS
value, so add a per-port attribute to modify the MDTS value.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c |  3 +--
 drivers/nvme/target/configfs.c  | 29 +++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  1 +
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 76250181fee0..d33e0fd248cd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -311,8 +311,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* we support multiple ports, multiples hosts and ANA: */
 	id->cmic = (1 << 0) | (1 << 1) | (1 << 3);
 
-	/* no limit on data transfer sizes for now */
-	id->mdts = 0;
+	id->mdts = req->port->mdts;
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index adb79545cdd7..a70b5e452ac3 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -299,6 +299,34 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
 
+static ssize_t nvmet_addr_mdts_show(struct config_item *item,
+					   char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%u\n", port->mdts);
+}
+
+static ssize_t nvmet_addr_mdts_store(struct config_item *item,
+					    const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	unsigned int mdts;
+	int ret;
+
+	ret = kstrtou32(page, 0, &mdts);
+	if (ret)
+		return ret;
+	if (mdts > 0xFF)
+		return -EINVAL;
+	down_write(&nvmet_config_sem);
+	port->mdts = mdts;
+	up_write(&nvmet_config_sem);
+
+	return count;
+}
+CONFIGFS_ATTR(nvmet_, addr_mdts);
+
 /*
  * Namespace structures & file operation functions below
  */
@@ -1157,6 +1185,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_addr_mdts,
 	&nvmet_attr_param_inline_data_size,
 	NULL,
 };
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 51e49efd7849..fdd3d3e6e759 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -139,6 +139,7 @@ struct nvmet_port {
 	enum nvme_ana_state		*ana_state;
 	void				*priv;
 	bool				enabled;
+	u8				mdts;
 	int				inline_data_size;
 };
 
-- 
2.16.4
