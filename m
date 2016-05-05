From: shhuiw@foxmail.com (Wang Sheng-Hui)
Date: Thu,  5 May 2016 09:17:35 +0800
Subject: [PATCH v3] NVMe: eliminate potential deadlock bynvme_get_ns_from_disk
 invoking nvme_free_ns
Message-ID: <1462411055-6197-1-git-send-email-shhuiw@foxmail.com>

Release dev_list_lock before enter nvme_free_ns from
nvme_get_ns_from_disk to avoid potential deadlock.

The change is finally made by Keith Busch, which
improve v1/v2 version:
    * Smaller change
    * Fix the module reference drop issue in v2 version
    * Remove gotos

Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>
---
 drivers/nvme/host/core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..8788ef3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -87,20 +87,16 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 	spin_lock(&dev_list_lock);
 	ns = disk->private_data;
 	if (ns) {
-		if (!kref_get_unless_zero(&ns->kref))
-			goto fail;
 		if (!try_module_get(ns->ctrl->ops->module))
-			goto fail_put_ns;
+			ns = NULL;
+		else if (!kref_get_unless_zero(&ns->kref)) {
+			module_put(ns->ctrl->ops->module);
+			ns = NULL;
+		}
 	}
 	spin_unlock(&dev_list_lock);
 
 	return ns;
-
-fail_put_ns:
-	kref_put(&ns->kref, nvme_free_ns);
-fail:
-	spin_unlock(&dev_list_lock);
-	return NULL;
 }
 
 void nvme_requeue_req(struct request *req)
-- 
2.7.4
