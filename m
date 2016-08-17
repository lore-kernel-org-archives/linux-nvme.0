From: famz@redhat.com (Fam Zheng)
Date: Wed, 17 Aug 2016 15:15:03 +0800
Subject: [PATCH 03/15] genhd: Return error from blk_register_region
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
Message-ID: <1471418115-3654-4-git-send-email-famz@redhat.com>

blk_register_region can fail (-ENOMEM), return the error to the caller.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 block/genhd.c         |  4 ++--
 include/linux/genhd.h | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 3dcecaa..8c7510d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -474,11 +474,11 @@ static char *bdevt_str(dev_t devt, char *buf)
  * range must be nonzero
  * The hash chain is sorted on range, so that subranges can override.
  */
-void blk_register_region(dev_t devt, unsigned long range, struct module *module,
+int blk_register_region(dev_t devt, unsigned long range, struct module *module,
 			 struct kobject *(*probe)(dev_t, int *, void *),
 			 int (*lock)(dev_t, void *), void *data)
 {
-	kobj_map(bdev_map, devt, range, module, probe, lock, data);
+	return kobj_map(bdev_map, devt, range, module, probe, lock, data);
 }
 
 EXPORT_SYMBOL(blk_register_region);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 889b1bb..b6fd666 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -617,11 +617,11 @@ extern struct gendisk *alloc_disk_node(int minors, int node_id);
 extern struct gendisk *alloc_disk(int minors);
 extern struct kobject *get_disk(struct gendisk *disk);
 extern void put_disk(struct gendisk *disk);
-extern void blk_register_region(dev_t devt, unsigned long range,
-			struct module *module,
-			struct kobject *(*probe)(dev_t, int *, void *),
-			int (*lock)(dev_t, void *),
-			void *data);
+extern int blk_register_region(dev_t devt, unsigned long range,
+			       struct module *module,
+			       struct kobject *(*probe)(dev_t, int *, void *),
+			       int (*lock)(dev_t, void *),
+			       void *data);
 extern void blk_unregister_region(dev_t devt, unsigned long range);
 
 extern ssize_t part_size_show(struct device *dev,
-- 
2.7.4
