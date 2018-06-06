From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  6 Jun 2018 15:27:48 +0300
Subject: [PATCH v3] nvmet: filter newlines from user input
Message-ID: <20180606122748.20872-1-sagi@grimberg.me>

We should avoid consuming the newlines in traddr, trsvcid and
device_path. Add minimal processing to make sure they are gone.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v2:
- use strcspn to break from device_path '\n' instead of strsep
- prettify sscanf statements

Changes from v1:
- use sscanf instead of kstrdup+strsep for traddr and trsvcid

 drivers/nvme/target/configfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index fd93c6a122d5..ce7fb63bd3ed 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -137,8 +137,10 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 		pr_err("Disable the address before modifying\n");
 		return -EACCES;
 	}
-	return snprintf(port->disc_addr.traddr,
-			sizeof(port->disc_addr.traddr), "%s", page);
+
+	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1)
+		return -EINVAL;
+	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_traddr);
@@ -223,8 +225,10 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 		pr_err("Disable the address before modifying\n");
 		return -EACCES;
 	}
-	return snprintf(port->disc_addr.trsvcid,
-			sizeof(port->disc_addr.trsvcid), "%s", page);
+
+	if (sscanf(page, "%s\n", port->disc_addr.trsvcid) != 1)
+		return -EINVAL;
+	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_trsvcid);
@@ -313,7 +317,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	kfree(ns->device_path);
 
 	ret = -ENOMEM;
-	ns->device_path = kstrdup(page, GFP_KERNEL);
+	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
 	if (!ns->device_path)
 		goto out_unlock;
 
-- 
2.14.1
