From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 13 May 2016 18:02:46 -0600
Subject: [RFCv2 1/3] block: allow other bd i_node flags when DAX is disabled
In-Reply-To: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1463184168-3381-2-git-send-email-jonathan.derrick@intel.com>

When DAX is not compiled into the kernel or the device does not support
direct-access, the block device file's inode flags are fully cleared.
This patch changes it to only clear the S_DAX flag when DAX is disabled.

This reverts to i_flags behavior prior to
bbab37ddc20bae4709bca8745c128c4f46fe63c5

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 20a2c02..d4fa725 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1208,7 +1208,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		if (IS_ENABLED(CONFIG_BLK_DEV_DAX) && disk->fops->direct_access)
 			bdev->bd_inode->i_flags = S_DAX;
 		else
-			bdev->bd_inode->i_flags = 0;
+			bdev->bd_inode->i_flags &= ~S_DAX;
 
 		if (!partno) {
 			ret = -ENXIO;
-- 
1.8.3.1
