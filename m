From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 09:59:52 +0800
Subject: [PATCH v2 11/12] mtd: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630015953.6888-12-famz@redhat.com>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/mtd/mtd_blkdevs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index ab3bc22..6848141 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -436,13 +436,14 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
-	add_disk(gd, true);
+	add_disk(gd, false);
 
 	if (new->disk_attributes) {
 		ret = sysfs_create_group(&disk_to_dev(gd)->kobj,
 					new->disk_attributes);
 		WARN_ON(ret);
 	}
+	disk_gen_uevents(gd);
 	return 0;
 error4:
 	blk_cleanup_queue(new->rq);
-- 
2.9.0
