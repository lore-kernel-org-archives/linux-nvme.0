From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 13 May 2016 18:02:47 -0600
Subject: [RFCv2 2/3] block: add helper for setting and clearing S_DAX on inode
In-Reply-To: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1463184168-3381-3-git-send-email-jonathan.derrick@intel.com>

inode->i_flags locking rules suggest using the i_mutex lock. This patch
adds a helper to do the locking and setting of S_DAX on the block device
inode.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 fs/block_dev.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d4fa725..252e459 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1159,6 +1159,18 @@ void bd_set_size(struct block_device *bdev, loff_t size)
 }
 EXPORT_SYMBOL(bd_set_size);
 
+static void bd_set_dax(struct block_device *bdev, bool enabled)
+{
+	struct inode *inode = bdev->bd_inode;
+
+	inode_lock(inode);
+	if (enabled)
+		inode->i_flags = S_DAX;
+	else
+		inode->i_flags &= ~S_DAX;
+	inode_unlock(inode);
+}
+
 static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 
 /*
@@ -1206,9 +1218,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		bdev->bd_queue = disk->queue;
 		bdev->bd_contains = bdev;
 		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
-			bdev->bd_inode->i_flags = S_DAX;
+			bd_set_dax(bdev, 1);
 		else
-			bdev->bd_inode->i_flags &= ~S_DAX;
+			bd_set_dax(bdev, 0);
 
 		if (!partno) {
 			ret = -ENXIO;
@@ -1239,7 +1251,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			if (!ret) {
 				bd_set_size(bdev,(loff_t)get_capacity(disk)<<9);
 				if (!blkdev_dax_capable(bdev))
-					bdev->bd_inode->i_flags &= ~S_DAX;
+					bd_set_dax(bdev, 0);
 			}
 
 			/*
@@ -1276,7 +1288,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			}
 			bd_set_size(bdev, (loff_t)bdev->bd_part->nr_sects << 9);
 			if (!blkdev_dax_capable(bdev))
-				bdev->bd_inode->i_flags &= ~S_DAX;
+				bd_set_dax(bdev, 0);
 		}
 	} else {
 		if (bdev->bd_contains == bdev) {
-- 
1.8.3.1
