From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Aug 2014 10:28:16 -0600
Subject: [PATCH] fs/block_dev.c: Use hd_part to find block inodes
Message-ID: <1408724896-3671-1-git-send-email-keith.busch@intel.com>

When using the GENHD_FL_EXT_DEVT disk flags, a newly added device may
be assigned the same major/minor as one that was previously removed but
opened, and the pesky userspace refuses to close it! The inode for the
old block_device is still open, and so bdget() finds the stale device
instead of allocating a new one. When the newly inserted drive is added,
you'll see a message like:

	nvme0n1: detected capacity change from XXX to 0

and the partitions on the disk will not be usable after that.

This patch uses the underlying disk's partition when trying to find
the block device's opened inode so that two different disks that have
a major/minor collision can coexist.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Maybe this is terrible idea!?

This came from proposals to the nvme driver that remove the dynamic
partitioning that was recently added, and I wanted to know why exactly
it was failing.

I don't know if there is a good reason to avoid having two devices opened
with the same major/minor, but I think this is safe and tests out okay
when I force that condition.

In all cases, it appears getting the block device will eventually fail
if either the disk or part do not exist, so should be okay to bail and
assign these even earlier.

 fs/block_dev.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6d72746..9ba2bc8 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -546,12 +546,15 @@ static inline unsigned long hash(dev_t dev)
 
 static int bdev_test(struct inode *inode, void *data)
 {
-	return BDEV_I(inode)->bdev.bd_dev == *(dev_t *)data;
+	return BDEV_I(inode)->bdev.bd_part == (struct hd_struct *)data;
 }
 
 static int bdev_set(struct inode *inode, void *data)
 {
-	BDEV_I(inode)->bdev.bd_dev = *(dev_t *)data;
+	struct hd_struct *part = (struct hd_struct *)data;;
+
+	BDEV_I(inode)->bdev.bd_part = part;
+	BDEV_I(inode)->bdev.bd_dev = part_devt(part);
 	return 0;
 }
 
@@ -561,9 +564,20 @@ struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
+	struct gendisk *disk;
+	struct hd_struct *part;
+	int partno;
+
+	disk = get_gendisk(dev, &partno);
+	if (!disk)
+		return NULL;
+
+	part = disk_get_part(disk, partno);
+	if (!part)
+		return NULL;
 
 	inode = iget5_locked(blockdev_superblock, hash(dev),
-			bdev_test, bdev_set, &dev);
+			bdev_test, bdev_set, part);
 
 	if (!inode)
 		return NULL;
-- 
1.7.10.4
