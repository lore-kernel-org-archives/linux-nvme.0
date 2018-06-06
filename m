From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  6 Jun 2018 12:10:49 +0300
Subject: [PATCH v2] nvmet: filter newlines from user input
Message-ID: <20180606091049.12661-1-sagi@grimberg.me>

We should avoid consuming the newlines in traddr, trsvcid and
device_path. Add minimal processing to make sure they are gone.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- use sscanf instead of kstrdup+strsep for traddr and trsvcid

 drivers/nvme/target/configfs.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index fd93c6a122d5..ad57c2cd40a1 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -126,6 +126,7 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	int ret;
 
 	if (count > NVMF_TRADDR_SIZE) {
 		pr_err("Invalid value '%s' for traddr\n", page);
@@ -137,8 +138,12 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		pr_err("Disable the address before modifying\n");
 		return -EACCES;
 	}
-	return snprintf(port->disc_addr.traddr,
-			sizeof(port->disc_addr.traddr), "%s", page);
+
+	ret = sscanf(page, "%s\n", port->disc_addr.traddr);
+	if (ret < 1)
+		return -EINVAL;
+
+	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_traddr);
@@ -213,6 +218,7 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	int ret;
 
 	if (count > NVMF_TRSVCID_SIZE) {
 		pr_err("Invalid value '%s' for trsvcid\n", page);
@@ -223,8 +229,12 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		pr_err("Disable the address before modifying\n");
 		return -EACCES;
 	}
-	return snprintf(port->disc_addr.trsvcid,
-			sizeof(port->disc_addr.trsvcid), "%s", page);
+
+	ret = sscanf(page, "%s\n", port->disc_addr.trsvcid);
+	if (ret < 1)
+		return -EINVAL;
+
+	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_trsvcid);
@@ -303,6 +313,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
 	struct nvmet_subsys *subsys = ns->subsys;
+	char *s;
 	int ret;
 
 	mutex_lock(&subsys->lock);
@@ -313,10 +324,11 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	kfree(ns->device_path);
 
 	ret = -ENOMEM;
-	ns->device_path = kstrdup(page, GFP_KERNEL);
-	if (!ns->device_path)
+	s = kstrdup(page, GFP_KERNEL);
+	if (!s)
 		goto out_unlock;
 
+	ns->device_path = strsep(&s, "\n");
 	mutex_unlock(&subsys->lock);
 	return count;
 
-- 
2.14.1
