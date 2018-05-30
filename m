From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 02:18:23 +0300
Subject: [PATCH] nvmet: filter newlines from user input
Message-ID: <20180530231823.1883-1-sagi@grimberg.me>

don't consume the annoying newlines in traddr, trsvcid and
device_path as they appear when reading configfs or worse in
discovery log pages. Add minimal processing to make sure they
are gone.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c | 34 ++++++++++++++++++++++++++++------
 drivers/nvme/target/nvmet.h    |  2 +-
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index fd93c6a122d5..fe65c36557fa 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -126,6 +126,8 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	char *s, *o, *traddr;
+	int ret;
 
 	if (count > NVMF_TRADDR_SIZE) {
 		pr_err("Invalid value '%s' for traddr\n", page);
@@ -137,8 +139,16 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		pr_err("Disable the address before modifying\n");
 		return -EACCES;
 	}
-	return snprintf(port->disc_addr.traddr,
-			sizeof(port->disc_addr.traddr), "%s", page);
+
+	o = s = kstrdup(page, GFP_KERNEL);
+	if (!o)
+		return -ENOMEM;
+
+	traddr = strsep(&s, "\n");
+	ret = snprintf(port->disc_addr.traddr,
+			sizeof(port->disc_addr.traddr), "%s", traddr);
+	kfree(o);
+	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_traddr);
@@ -213,6 +223,8 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	char *s, *o, *trsvcid;
+	int ret;
 
 	if (count > NVMF_TRSVCID_SIZE) {
 		pr_err("Invalid value '%s' for trsvcid\n", page);
@@ -223,8 +235,16 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		pr_err("Disable the address before modifying\n");
 		return -EACCES;
 	}
-	return snprintf(port->disc_addr.trsvcid,
-			sizeof(port->disc_addr.trsvcid), "%s", page);
+
+	o = s = kstrdup(page, GFP_KERNEL);
+	if (!o)
+		return -ENOMEM;
+
+	trsvcid = strsep(&s, "\n");
+	ret = snprintf(port->disc_addr.trsvcid,
+			sizeof(port->disc_addr.trsvcid), "%s", trsvcid);
+	kfree(o);
+	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_trsvcid);
@@ -303,6 +323,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
 	struct nvmet_subsys *subsys = ns->subsys;
+	char *s, *o;
 	int ret;
 
 	mutex_lock(&subsys->lock);
@@ -313,10 +334,11 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	kfree(ns->device_path);
 
 	ret = -ENOMEM;
-	ns->device_path = kstrdup(page, GFP_KERNEL);
-	if (!ns->device_path)
+	o = s = kstrdup(page, GFP_KERNEL);
+	if (!o)
 		goto out_unlock;
 
+	ns->device_path = strsep(&s, "\n");
 	mutex_unlock(&subsys->lock);
 	return count;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9424f82951af..48d9a3349fd5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -52,7 +52,7 @@ struct nvmet_ns {
 
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
-	const char		*device_path;
+	char			*device_path;
 
 	struct config_group	device_group;
 	struct config_group	group;
-- 
2.14.1
