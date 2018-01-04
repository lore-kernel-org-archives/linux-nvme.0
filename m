From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu,  4 Jan 2018 17:56:13 +0200
Subject: [PATCH 1/2] nvme: Take refcount on transport module when using block
 device operations
Message-ID: <1515081374-22328-1-git-send-email-maxg@mellanox.com>

From: Nitzan Carmi <nitzanc@mellanox.com>

The block device is backed by the transport so we must ensure that the related
ops driver will not be removed until all external application (e.g. LVM)
will release the reference. Otherwise, we might end up referencing freed memory.

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
---
 drivers/nvme/host/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 839650e..cb6b08e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1217,16 +1217,27 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
 #ifdef CONFIG_NVME_MULTIPATH
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(ns->head->disk))
-		return -ENXIO;
+		goto fail;
 #endif
 	if (!kref_get_unless_zero(&ns->kref))
-		return -ENXIO;
+		goto fail;
+	if (!try_module_get(ns->ctrl->ops->module))
+		goto fail_put_ns;
+
 	return 0;
+
+fail_put_ns:
+	kref_put(&ns->kref, nvme_free_ns);
+fail:
+	return -ENXIO;
 }
 
 static void nvme_release(struct gendisk *disk, fmode_t mode)
 {
-	nvme_put_ns(disk->private_data);
+	struct nvme_ns *ns = disk->private_data;
+
+	module_put(ns->ctrl->ops->module);
+	nvme_put_ns(ns);
 }
 
 static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-- 
1.8.3.1
