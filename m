From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 20 Aug 2015 16:41:50 -0400
Subject: [PATCH 1/5] block: Move integrity kobject to struct gendisk
In-Reply-To: <1440103314-31610-1-git-send-email-martin.petersen@oracle.com>
References: <20150721120102.GB1654@infradead.org>
 <1440103314-31610-1-git-send-email-martin.petersen@oracle.com>
Message-ID: <1440103314-31610-2-git-send-email-martin.petersen@oracle.com>

The integrity kobject purely exists to support the integrity
subdirectory in sysfs and doesn't really have anything to do with the
blk_integrity data structure. Move the kobject to struct gendisk where
it belongs.

Signed-off-by: Martin K. Petersen <martin.petersen at oracle.com>
Reported-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-integrity.c  | 22 +++++++++++-----------
 include/linux/blkdev.h |  2 --
 include/linux/genhd.h  |  1 +
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index f548b64be092..6a173a7d1ec6 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -246,8 +246,8 @@ struct integrity_sysfs_entry {
 static ssize_t integrity_attr_show(struct kobject *kobj, struct attribute *attr,
 				   char *page)
 {
-	struct blk_integrity *bi =
-		container_of(kobj, struct blk_integrity, kobj);
+	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
+	struct blk_integrity *bi = blk_get_integrity(disk);
 	struct integrity_sysfs_entry *entry =
 		container_of(attr, struct integrity_sysfs_entry, attr);
 
@@ -258,8 +258,8 @@ static ssize_t integrity_attr_store(struct kobject *kobj,
 				    struct attribute *attr, const char *page,
 				    size_t count)
 {
-	struct blk_integrity *bi =
-		container_of(kobj, struct blk_integrity, kobj);
+	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
+	struct blk_integrity *bi = blk_get_integrity(disk);
 	struct integrity_sysfs_entry *entry =
 		container_of(attr, struct integrity_sysfs_entry, attr);
 	ssize_t ret = 0;
@@ -382,8 +382,8 @@ subsys_initcall(blk_dev_integrity_init);
 
 static void blk_integrity_release(struct kobject *kobj)
 {
-	struct blk_integrity *bi =
-		container_of(kobj, struct blk_integrity, kobj);
+	struct gendisk *disk = container_of(kobj, struct gendisk, integrity_kobj);
+	struct blk_integrity *bi = blk_get_integrity(disk);
 
 	kmem_cache_free(integrity_cachep, bi);
 }
@@ -426,14 +426,14 @@ int blk_integrity_register(struct gendisk *disk, struct blk_integrity *template)
 		if (!bi)
 			return -1;
 
-		if (kobject_init_and_add(&bi->kobj, &integrity_ktype,
+		if (kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
 					 &disk_to_dev(disk)->kobj,
 					 "%s", "integrity")) {
 			kmem_cache_free(integrity_cachep, bi);
 			return -1;
 		}
 
-		kobject_uevent(&bi->kobj, KOBJ_ADD);
+		kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
 
 		bi->flags |= BLK_INTEGRITY_VERIFY | BLK_INTEGRITY_GENERATE;
 		bi->interval = queue_logical_block_size(disk->queue);
@@ -476,9 +476,9 @@ void blk_integrity_unregister(struct gendisk *disk)
 
 	bi = disk->integrity;
 
-	kobject_uevent(&bi->kobj, KOBJ_REMOVE);
-	kobject_del(&bi->kobj);
-	kobject_put(&bi->kobj);
+	kobject_uevent(&disk->integrity_kobj, KOBJ_REMOVE);
+	kobject_del(&disk->integrity_kobj);
+	kobject_put(&disk->integrity_kobj);
 	disk->integrity = NULL;
 }
 EXPORT_SYMBOL(blk_integrity_unregister);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e427debc7008..e879473873d5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1431,8 +1431,6 @@ struct blk_integrity {
 	unsigned short		tag_size;
 
 	const char		*name;
-
-	struct kobject		kobj;
 };
 
 extern bool blk_integrity_is_initialized(struct gendisk *);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 2adbfa6d02bc..9e6e0dfa97ad 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -199,6 +199,7 @@ struct gendisk {
 	struct disk_events *ev;
 #ifdef  CONFIG_BLK_DEV_INTEGRITY
 	struct blk_integrity *integrity;
+	struct kobject integrity_kobj;
 #endif
 	int node_id;
 };
-- 
2.4.3
