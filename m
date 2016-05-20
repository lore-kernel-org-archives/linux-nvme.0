From: khoroshilov@ispras.ru (Alexey Khoroshilov)
Date: Sat, 21 May 2016 01:36:00 +0300
Subject: [PATCH] NVMe: fix deadlock on failure branch in
 nvme_get_ns_from_disk()
Message-ID: <1463783760-5851-1-git-send-email-khoroshilov@ispras.ru>

kref_put(&ns->kref, nvme_free_ns) is called in nvme_get_ns_from_disk()
under dev_list_lock spinlock, while nvme_free_ns() locks the spinlock
by itself. This can lead to a deadlock.

The patch moves try_module_get() and its error handling
out of spinlock section.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov at ispras.ru>
Fixes: e439bb12e75c ("nvme/host: reference the fabric module for each bdev open callout")
---
 drivers/nvme/host/core.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457131c2..761d4c73a233 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -83,24 +83,25 @@ static void nvme_put_ns(struct nvme_ns *ns)
 static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
 {
 	struct nvme_ns *ns;
+	struct module *module;
 
 	spin_lock(&dev_list_lock);
 	ns = disk->private_data;
 	if (ns) {
-		if (!kref_get_unless_zero(&ns->kref))
-			goto fail;
-		if (!try_module_get(ns->ctrl->ops->module))
-			goto fail_put_ns;
+		if (!kref_get_unless_zero(&ns->kref)) {
+			spin_unlock(&dev_list_lock);
+			return NULL;
+		}
+		module = ns->ctrl->ops->module;
 	}
 	spin_unlock(&dev_list_lock);
 
-	return ns;
+	if (!try_module_get(module)) {
+		nvme_put_ns(ns);
+		return NULL;
+	}
 
-fail_put_ns:
-	kref_put(&ns->kref, nvme_free_ns);
-fail:
-	spin_unlock(&dev_list_lock);
-	return NULL;
+	return ns;
 }
 
 void nvme_requeue_req(struct request *req)
-- 
1.9.1
