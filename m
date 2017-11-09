From: hare@suse.de (Hannes Reinecke)
Date: Thu,  9 Nov 2017 17:57:06 +0100
Subject: [PATCH] nvme: Create 'slaves' and 'holders' entries
Message-ID: <1510246626-63259-1-git-send-email-hare@suse.de>

When creating nvme multipath devices we should populate the
'slaves' and 'holders' directorys properly to aid userspace
topology detection.

Patch is relative to hch's nvme-mpath branch

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 block/genhd.c            | 14 +++++++-------
 drivers/nvme/host/core.c | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 835e907..3de1671 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -585,14 +585,14 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 	 */
 	pm_runtime_set_memalloc_noio(ddev, true);
 
+	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
+	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
+
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		dev_set_uevent_suppress(ddev, 0);
 		return;
 	}
 
-	disk->part0.holder_dir = kobject_create_and_add("holders", &ddev->kobj);
-	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
-
 	/* No minors to use for partitions */
 	if (!disk_part_scan_enabled(disk))
 		goto exit;
@@ -728,11 +728,11 @@ void del_gendisk(struct gendisk *disk)
 		WARN_ON(1);
 	}
 
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+	if (!(disk->flags & GENHD_FL_HIDDEN))
 		blk_unregister_region(disk_devt(disk), disk->minors);
-		kobject_put(disk->part0.holder_dir);
-		kobject_put(disk->slave_dir);
-	}
+
+	kobject_put(disk->part0.holder_dir);
+	kobject_put(disk->slave_dir);
 
 	part_stat_set_all(&disk->part0, 0);
 	disk->part0.stamp = 0;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9209b8b..6e9effa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2756,6 +2756,22 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	if (new)
 		nvme_mpath_add_disk(ns->head);
+
+	if (ns->head->disk) {
+		struct kobject *slave_disk_kobj, *holder_disk_kobj;
+
+		slave_disk_kobj = &disk_to_dev(ns->disk)->kobj;
+		if (sysfs_create_link(ns->head->disk->slave_dir,
+				      slave_disk_kobj,
+				      kobject_name(slave_disk_kobj)))
+			return;
+		holder_disk_kobj = &disk_to_dev(ns->head->disk)->kobj;
+		if (sysfs_create_link(ns->disk->part0.holder_dir,
+				      holder_disk_kobj,
+				      kobject_name(holder_disk_kobj)))
+			sysfs_remove_link(ns->head->disk->slave_dir,
+					  kobject_name(slave_disk_kobj));
+	}
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2779,6 +2795,16 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
+		if (head->disk) {
+			struct kobject *holder_disk_kobj =
+				&disk_to_dev(head->disk)->kobj;
+			struct kobject *slave_disk_kobj =
+				&disk_to_dev(ns->disk)->kobj;
+			sysfs_remove_link(ns->disk->part0.holder_dir,
+					  kobject_name(holder_disk_kobj));
+			sysfs_remove_link(ns->head->disk->slave_dir,
+					  kobject_name(slave_disk_kobj));
+		}
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvme_ns_id_attr_group);
 		if (ns->ndev)
-- 
1.8.5.6
