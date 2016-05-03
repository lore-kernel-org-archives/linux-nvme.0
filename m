From: shhuiw@foxmail.com (Wang Sheng-Hui)
Date: Tue,  3 May 2016 16:25:54 +0800
Subject: [PATCH] NVMe: eliminate potential deadlock by nvme_get_ns_from_disk
 invoking nvme_free_ns
Message-ID: <1462263954-2475-1-git-send-email-shhuiw@foxmail.com>

Release dev_list_lock before enter nvme_free_ns from
nvme_get_ns_from_disk to avoid potential deadlock.

Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>
---
 drivers/nvme/host/core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 49bc4c0..81e397b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -87,20 +87,19 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 	spin_lock(&dev_list_lock);
 	ns = disk->private_data;
 	if (ns) {
-		if (!kref_get_unless_zero(&ns->kref))
-			goto fail;
-		if (!try_module_get(ns->ctrl->ops->module))
-			goto fail_put_ns;
+		if (!kref_get_unless_zero(&ns->kref)) {
+			ns = NULL;
+			goto out;
+		}
+		if (!try_module_get(ns->ctrl->ops->module)) {
+			spin_unlock(&dev_list_lock);
+			kref_put(&ns->kref, nvme_free_ns);
+			return NULL;
+		}
 	}
+out:
 	spin_unlock(&dev_list_lock);
-
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
