From: neilb@suse.com (NeilBrown)
Date: Thu, 02 Jun 2016 16:43:18 +1000
Subject: [PATCH 1/2] memstick: don't allocate unused major for ms_block
In-Reply-To: <20160602064306.4403.72816.stgit@noble>
References: <20160602064306.4403.72816.stgit@noble>
Message-ID: <20160602064318.4403.49955.stgit@noble>

When alloc_disk(0) is used the ->major number is completely ignored.
All devices are allocated with a major of BLOCK_EXT_MAJOR.

So remove registration and deregistration of 'major'.

Signed-off-by: NeilBrown <neilb at suse.com>
---
 drivers/memstick/core/ms_block.c |   17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 3cd68152ddf8..1efc9103bfd8 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2340,23 +2340,11 @@ static struct memstick_driver msb_driver = {
 	.resume   = msb_resume
 };
 
-static int major;
-
 static int __init msb_init(void)
 {
-	int rc = register_blkdev(0, DRIVER_NAME);
-
-	if (rc < 0) {
-		pr_err("failed to register major (error %d)\n", rc);
-		return rc;
-	}
-
-	major = rc;
-	rc = memstick_register_driver(&msb_driver);
-	if (rc) {
-		unregister_blkdev(major, DRIVER_NAME);
+	int rc = memstick_register_driver(&msb_driver);
+	if (rc)
 		pr_err("failed to register memstick driver (error %d)\n", rc);
-	}
 
 	return rc;
 }
@@ -2364,7 +2352,6 @@ static int __init msb_init(void)
 static void __exit msb_exit(void)
 {
 	memstick_unregister_driver(&msb_driver);
-	unregister_blkdev(major, DRIVER_NAME);
 	idr_destroy(&msb_disk_idr);
 }
 
