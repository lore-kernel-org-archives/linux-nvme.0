From: hare@suse.de (Hannes Reinecke)
Date: Fri,  4 May 2018 13:28:41 +0200
Subject: [PATCH 1/5] nvmet: EUI64 support
In-Reply-To: <20180504112845.38820-1-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
Message-ID: <20180504112845.38820-2-hare@suse.de>

Allow the setting of an IEEE Extended Unique Identifier (EUI64) for
each namespace. As the OUI is per subsystem ensure that the OUI
part of the EUI64 value (ie the top 3 bytes) are matching for each
namespace.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c |  6 ++---
 drivers/nvme/target/configfs.c  | 58 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e0e9fcc0d4d..a53259e1082e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -187,10 +187,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->rab = 6;
 
-	/*
-	 * XXX: figure out how we can assign a IEEE OUI, but until then
-	 * the safest is to leave it as zeroes.
-	 */
+	memcpy(id->ieee, &ctrl->subsys->oui, 3);
 
 	/* we support multiple ports and multiples hosts: */
 	id->cmic = (1 << 0) | (1 << 1);
@@ -314,6 +311,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	id->nmic = (1 << 0);
 
 	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
+	memcpy(&id->eui64, &ns->eui64, sizeof(id->eui64));
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad9ff27234b5..3dc2b2ae56e5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -378,6 +378,49 @@ static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, device_nguid);
 
+static ssize_t nvmet_ns_device_eui64_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%llx\n",
+		       (unsigned long long)&to_nvmet_ns(item)->eui64);
+}
+
+static ssize_t nvmet_ns_device_eui64_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item), *n;
+	struct nvmet_subsys *subsys = ns->subsys;
+	u64 eui64;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	if (ns->enabled) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	if (sscanf(page, "%llx\n", &eui64) != 1) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	list_for_each_entry_rcu(n, &subsys->namespaces, dev_link) {
+		if ((n->eui64 >> 40) != (eui64 >> 40)) {
+			pr_warn("non-matching EUI64 company id %06x\n",
+				(unsigned int)(eui64 >> 40));
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+	}
+	ns->eui64 = eui64;
+	if (!subsys->oui)
+		subsys->oui = (eui64 >> 40);
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, device_eui64);
+
 static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
 {
 	return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
@@ -407,6 +450,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
+	&nvmet_ns_attr_device_eui64,
 	&nvmet_ns_attr_enable,
 	NULL,
 };
@@ -704,10 +748,24 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+/*
+ * OUI is set from the namespace EUI64, so we cannot set it here.
+ */
+static ssize_t nvmet_subsys_attr_oui_show(struct config_item *item,
+					     char *page)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	return snprintf(page, PAGE_SIZE, "%06x\n", subsys->oui);
+}
+
+CONFIGFS_ATTR_RO(nvmet_subsys_, attr_oui);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
+	&nvmet_subsys_attr_attr_oui,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84ab21f8..8cd42ed37314 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -47,6 +47,7 @@ struct nvmet_ns {
 	u32			blksize_shift;
 	loff_t			size;
 	u8			nguid[16];
+	u64			eui64;
 	uuid_t			uuid;
 
 	bool			enabled;
@@ -154,6 +155,7 @@ struct nvmet_subsys {
 
 	u64			ver;
 	u64			serial;
+	u32			oui;
 	char			*subsysnqn;
 
 	struct config_group	group;
-- 
2.12.3
