From: hare@suse.de (Hannes Reinecke)
Date: Mon,  2 Oct 2017 15:55:56 +0200
Subject: [PATCH 3/6] nvme: claim block devices
In-Reply-To: <1506952559-1588-1-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
Message-ID: <1506952559-1588-4-git-send-email-hare@suse.de>

When setting up a multipath device we need to claim the underlying
block devices to avoid other systems and/or programs to access it.
And we should be using the standard holders/slave sysfs relationship
instead of the hand-crafted 'mpath' links.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++----------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f52f0ab..8924f48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2805,6 +2805,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev);
 	bool new = true;
+	static char *_nvme_claim_ptr = "NVMe shared namespace path";
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -2885,15 +2886,26 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 				ns->head->disk->disk_name);
 	}
 
-	if (sysfs_create_link(&disk_to_dev(ns->disk)->kobj,
-			&disk_to_dev(ns->head->disk)->kobj, "mpath"))
-		pr_warn("%s: failed to create sysfs link to mpath device\n",
+	ns->bdev = bdget_disk(ns->disk, 0);
+	if (!ns->bdev) {
+		pr_warn("%s: failed to get bdev\n", ns->disk->disk_name);
+		return;
+	}
+	if (blkdev_get(ns->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL,
+		       _nvme_claim_ptr) < 0) {
+		pr_warn("%s: failed to claim bdev\n",
 			ns->disk->disk_name);
-	if (sysfs_create_link(&disk_to_dev(ns->head->disk)->kobj,
-			&disk_to_dev(ns->disk)->kobj, ns->disk->disk_name))
-		pr_warn("%s: failed to create sysfs link from mpath device\n",
+		bdput(ns->bdev);
+		ns->bdev = NULL;
+		nvme_put_ns_head(ns->head);
+		return;
+	}
+	if (bd_link_disk_holder(ns->bdev, ns->head->disk)) {
+		pr_warn("%s: failed to create sysfs link to mpath device\n",
 			ns->disk->disk_name);
-
+		blkdev_put(ns->bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		ns->bdev = NULL;
+	}
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2921,11 +2933,13 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			blk_integrity_unregister(ns->disk);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group);
-		sysfs_remove_link(&disk_to_dev(ns->disk)->kobj, "mpath");
-		sysfs_remove_link(&disk_to_dev(ns->head->disk)->kobj,
-				ns->disk->disk_name);
 		if (ns->ndev)
 			nvme_nvm_unregister_sysfs(ns);
+		if (ns->bdev) {
+			bd_unlink_disk_holder(ns->bdev, ns->head->disk);
+			blkdev_put(ns->bdev,
+				   FMODE_READ | FMODE_WRITE | FMODE_EXCL);
+		}
 		del_gendisk(ns->disk);
 		blk_cleanup_queue(ns->queue);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 10fffbc..a8a79bc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -252,6 +252,7 @@ struct nvme_ns {
 	struct nvme_ctrl *ctrl;
 	struct request_queue *queue;
 	struct gendisk *disk;
+	struct block_device *bdev;
 	struct list_head siblings;
 	struct nvm_dev *ndev;
 	struct kref kref;
-- 
1.8.5.6
