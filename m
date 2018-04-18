From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:53 -0400
Subject: [PATCH 02/20] nvmet: add a wrapper for ns handlers
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-3-chaitanya.kulkarni@wdc.com>

This patch isolates the code for block device open and close.
This is a preparation patch for implementation of the
file backed namespaces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 54 +++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a78029e4e5f4..5f032dc7077f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -271,6 +271,37 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 	percpu_ref_put(&ns->ref);
 }
 
+static int nvmet_ns_enable_blk(struct nvmet_ns *ns)
+{
+	int blk_flags = FMODE_READ | FMODE_WRITE;
+
+	ns->bdev = blkdev_get_by_path(ns->device_path, blk_flags, NULL);
+	if (IS_ERR(ns->bdev)) {
+		pr_err("failed to open block device %s: (%ld)\n",
+				ns->device_path, PTR_ERR(ns->bdev));
+		ns->bdev = NULL;
+		return -1;
+	}
+	ns->size = i_size_read(ns->bdev->bd_inode);
+	ns->blksize_shift =
+		blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	return 0;
+}
+
+static int nvmet_ns_dev_enable(struct nvmet_ns *ns)
+{
+	return nvmet_ns_enable_blk(ns);
+}
+
+static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
+{
+	if (ns->bdev) {
+		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
+		ns->bdev = NULL;
+	}
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -281,23 +312,14 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->enabled)
 		goto out_unlock;
 
-	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
-			NULL);
-	if (IS_ERR(ns->bdev)) {
-		pr_err("failed to open block device %s: (%ld)\n",
-		       ns->device_path, PTR_ERR(ns->bdev));
-		ret = PTR_ERR(ns->bdev);
-		ns->bdev = NULL;
+	ret = nvmet_ns_dev_enable(ns);
+	if (ret)
 		goto out_unlock;
-	}
-
-	ns->size = i_size_read(ns->bdev->bd_inode);
-	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
 
 	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
 				0, GFP_KERNEL);
 	if (ret)
-		goto out_blkdev_put;
+		goto out_dev_put;
 
 	if (ns->nsid > subsys->max_nsid)
 		subsys->max_nsid = ns->nsid;
@@ -328,9 +350,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
-out_blkdev_put:
-	blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
-	ns->bdev = NULL;
+out_dev_put:
+	nvmet_ns_dev_disable(ns);
 	goto out_unlock;
 }
 
@@ -366,8 +387,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
 
-	if (ns->bdev)
-		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
+	nvmet_ns_dev_disable(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
 }
-- 
2.14.1
