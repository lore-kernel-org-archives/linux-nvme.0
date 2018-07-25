From: hare@suse.de (Hannes Reinecke)
Date: Wed, 25 Jul 2018 08:35:17 +0200
Subject: [PATCH] nvmet: fixup crash on NULL device path
Message-ID: <20180725063517.94515-1-hare@suse.de>

When writing an empty string into the device_path attribute the kernel
will crash with

nvmet: failed to open block device (null): (-22)
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000

This patch sanitizes the error handling for invalid device path settings.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/configfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3ba5ea5c4376..b41db23260de 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -311,6 +311,7 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
 	struct nvmet_subsys *subsys = ns->subsys;
+	size_t len;
 	int ret;
 
 	mutex_lock(&subsys->lock);
@@ -318,10 +319,14 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	if (ns->enabled)
 		goto out_unlock;
 
-	kfree(ns->device_path);
+	ret = -EINVAL;
+	len = strcspn(page, "\n");
+	if (!len)
+		goto out_unlock;
 
+	kfree(ns->device_path);
 	ret = -ENOMEM;
-	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
+	ns->device_path = kstrndup(page, len, GFP_KERNEL);
 	if (!ns->device_path)
 		goto out_unlock;
 
-- 
2.12.3
