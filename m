From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Thu,  6 Dec 2018 14:48:12 -0200
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181206164812.30925-1-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
Message-ID: <20181206164812.30925-5-cascardo@canonical.com>

Without this exposure, lsblk will fail as it tries to find out the
device's dev_t numbers. This causes a real problem for nvme multipath
devices, as their slaves are hidden.

Exposing them fixes the problem, even though trying to open the devices
returns an error in the case of nvme multipath. So, right now, it's the
driver's responsibility to return a failure to open hidden devices.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo at canonical.com>
---
 block/genhd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7674fce32fca..65a7fa664188 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -687,6 +687,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_alloc_events(disk);
 
+	disk_to_dev(disk)->devt = devt;
 	if (disk->flags & GENHD_FL_HIDDEN) {
 		/*
 		 * Don't let hidden disks show up in /proc/partitions,
@@ -698,13 +699,12 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 		int ret;
 
 		/* Register BDI before referencing it from bdev */
-		disk_to_dev(disk)->devt = devt;
 		ret = bdi_register_owner(disk->queue->backing_dev_info,
 						disk_to_dev(disk));
 		WARN_ON(ret);
-		blk_register_region(disk_devt(disk), disk->minors, NULL,
-				    exact_match, exact_lock, disk);
 	}
+	blk_register_region(disk_devt(disk), disk->minors, NULL,
+			    exact_match, exact_lock, disk);
 	register_disk(parent, disk, groups);
 	if (register_queue)
 		blk_register_queue(disk);
@@ -776,8 +776,7 @@ void del_gendisk(struct gendisk *disk)
 		WARN_ON(1);
 	}
 
-	if (!(disk->flags & GENHD_FL_HIDDEN))
-		blk_unregister_region(disk_devt(disk), disk->minors);
+	blk_unregister_region(disk_devt(disk), disk->minors);
 
 	kobject_put(disk->part0.holder_dir);
 	kobject_put(disk->slave_dir);
-- 
2.19.1
