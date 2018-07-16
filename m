From: hare@suse.de (Hannes Reinecke)
Date: Mon, 16 Jul 2018 12:58:34 +0200
Subject: [PATCH 2/5] nvmet: fixup crash on NULL device path
In-Reply-To: <20180716105837.101125-1-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
Message-ID: <20180716105837.101125-3-hare@suse.de>

When writing an empty string into the device_path attribute the kernel
will crash with

nvmet: failed to open block device (null): (-22)
BUG: unable to handle kernel NULL pointer dereference at 0000000000000000

This patch sanitizes the error handling for invalid device path settings.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/configfs.c | 6 ++++++
 drivers/nvme/target/core.c     | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 094d216ae62a..76efc8120c00 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -295,6 +295,12 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
 	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
 	if (!ns->device_path)
 		goto out_unlock;
+	if (!strlen(ns->device_path)) {
+		kfree(ns->device_path);
+		ns->device_path = NULL;
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 
 	mutex_unlock(&subsys->lock);
 	return count;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0aeccbddd716..956d293d293d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -373,8 +373,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
+	if (!ns->device_path) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
 	ret = nvmet_bdev_ns_enable(ns);
-	if (ret)
+	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
 	if (ret)
 		goto out_unlock;
-- 
2.12.3
