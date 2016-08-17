From: famz@redhat.com (Fam Zheng)
Date: Wed, 17 Aug 2016 15:15:02 +0800
Subject: [PATCH 02/15] genhd: Return error from register_disk()
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
Message-ID: <1471418115-3654-3-git-send-email-famz@redhat.com>

Several operations in register_disk can fail, but the caller currently
cannot check for error due to missing return code. Change the function
return type and return -errno if any error happens.

Also add some documentation.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 block/genhd.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index fcd6d4f..3dcecaa 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -506,7 +506,15 @@ static int exact_lock(dev_t devt, void *data)
 	return 0;
 }
 
-static void register_disk(struct device *parent, struct gendisk *disk)
+/**
+ * register_disk - register a gendisk to a parent device
+ * @parent: parent device for the disk
+ * @disk: per-device partitioning information
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+static int register_disk(struct device *parent, struct gendisk *disk)
 {
 	struct device *ddev = disk_to_dev(disk);
 	struct block_device *bdev;
@@ -521,14 +529,16 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
 
-	if (device_add(ddev))
-		return;
+	err = device_add(ddev);
+	if (err)
+		return err;
+
 	if (!sysfs_deprecated) {
 		err = sysfs_create_link(block_depr, &ddev->kobj,
 					kobject_name(&ddev->kobj));
 		if (err) {
 			device_del(ddev);
-			return;
+			return err;
 		}
 	}
 
@@ -547,12 +557,16 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 		goto exit;
 
 	/* No such device (e.g., media were just removed) */
-	if (!get_capacity(disk))
+	if (!get_capacity(disk)) {
+		err = -ENOMEDIUM;
 		goto exit;
+	}
 
 	bdev = bdget_disk(disk, 0);
-	if (!bdev)
+	if (!bdev) {
+		err = -ENOMEDIUM;
 		goto exit;
+	}
 
 	bdev->bd_invalidated = 1;
 	err = blkdev_get(bdev, FMODE_READ, NULL);
@@ -570,6 +584,7 @@ exit:
 	while ((part = disk_part_iter_next(&piter)))
 		kobject_uevent(&part_to_dev(part)->kobj, KOBJ_ADD);
 	disk_part_iter_exit(&piter);
+	return err;
 }
 
 /**
-- 
2.7.4
