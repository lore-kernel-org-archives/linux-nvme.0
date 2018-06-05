From: hare@suse.de (Hannes Reinecke)
Date: Tue,  5 Jun 2018 10:29:05 +0200
Subject: [PATCH] nvme: do not block connect call on inaccessible devices
Message-ID: <20180605082905.1740-1-hare@suse.de>

When a device is in ANA inaccessible state the call to 'nvme connect'
will hang as a parition scan is triggered and the I/O will be requeued
indefinitely.
Or rather, requeued until the next path is connected, but we cannot issue
any nvme ioctls anymore as the nvmf_dev_mutex is blocked by the initial
'connect' call.

This patch inhibits partition scan if no working paths are found, and
retriggers the partition scan once the device becomes active.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 14bcc51016c7..30ba3c43e541 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -275,16 +275,44 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 void nvme_mpath_add_disk(struct nvme_ns_head *head)
 {
+	struct nvme_ns *ns;
+	int nr_working = 0;
+
 	if (!head->disk)
 		return;
 
 	mutex_lock(&head->subsys->lock);
+	list_for_each_entry(ns, &head->list, siblings) {
+		if (nvme_ns_ana_state(ns) == NVME_ANA_OPTIMIZED ||
+		    nvme_ns_ana_state(ns) == NVME_ANA_NONOPTIMIZED)
+			nr_working++;
+	}
+	/* Disable partition scan if no working paths are found */
+	if (!nr_working)
+		head->disk->flags |= GENHD_FL_NO_PART_SCAN;
+	else
+		head->disk->flags &= ~GENHD_FL_NO_PART_SCAN;
+
 	if (!(head->disk->flags & GENHD_FL_UP)) {
 		device_add_disk(&head->subsys->dev, head->disk);
 		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
 				&nvme_ns_id_attr_group))
 			pr_warn("%s: failed to create sysfs group for identification\n",
 				head->disk->disk_name);
+	} else {
+		struct block_device *bdev;
+
+		/*
+		 * We need to do an explicit blkdev_get() to
+		 * re-trigger partition scan if new paths have been added.
+		 */
+		bdev = bdget_disk(head->disk, 0);
+		if (bdev) {
+			bdev->bd_invalidated = 1;
+			if (!blkdev_get(bdev, FMODE_READ, NULL))
+				blkdev_put(bdev, FMODE_READ);
+			bdput(bdev);
+		}
 	}
 	mutex_unlock(&head->subsys->lock);
 }
-- 
2.12.3
