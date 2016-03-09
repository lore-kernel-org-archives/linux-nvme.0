From: neilb@suse.com (NeilBrown)
Date: Thu, 10 Mar 2016 08:59:28 +1100
Subject: [PATCH 1/4] nvdimm/blk: don't allocate unused major device number
In-Reply-To: <20160309215702.20904.61407.stgit@noble>
References: <20160309215702.20904.61407.stgit@noble>
Message-ID: <20160309215928.20904.11773.stgit@noble>

When alloc_disk(0) is used ->major is completely ignored, all devices
are allocated with a "major" of BLOCK_EXT_MAJOR.

So don't allocate nd_blk_major

Signed-off-by: NeilBrown <neilb at suse.com>
---
 drivers/nvdimm/blk.c |   18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 91a336ea8c4f..e9ff9229d942 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -31,8 +31,6 @@ struct nd_blk_device {
 	u32 internal_lbasize;
 };
 
-static int nd_blk_major;
-
 static u32 nd_blk_meta_size(struct nd_blk_device *blk_dev)
 {
 	return blk_dev->nsblk->lbasize - blk_dev->sector_size;
@@ -264,7 +262,6 @@ static int nd_blk_attach_disk(struct nd_namespace_common *ndns,
 	}
 
 	disk->driverfs_dev	= &ndns->dev;
-	disk->major		= nd_blk_major;
 	disk->first_minor	= 0;
 	disk->fops		= &nd_blk_fops;
 	disk->private_data	= blk_dev;
@@ -358,25 +355,12 @@ static struct nd_device_driver nd_blk_driver = {
 
 static int __init nd_blk_init(void)
 {
-	int rc;
-
-	rc = register_blkdev(0, "nd_blk");
-	if (rc < 0)
-		return rc;
-
-	nd_blk_major = rc;
-	rc = nd_driver_register(&nd_blk_driver);
-
-	if (rc < 0)
-		unregister_blkdev(nd_blk_major, "nd_blk");
-
-	return rc;
+	return nd_driver_register(&nd_blk_driver);
 }
 
 static void __exit nd_blk_exit(void)
 {
 	driver_unregister(&nd_blk_driver.drv);
-	unregister_blkdev(nd_blk_major, "nd_blk");
 }
 
 MODULE_AUTHOR("Ross Zwisler <ross.zwisler at linux.intel.com>");
