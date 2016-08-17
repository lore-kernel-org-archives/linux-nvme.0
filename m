From: famz@redhat.com (Fam Zheng)
Date: Wed, 17 Aug 2016 15:15:10 +0800
Subject: [PATCH 10/15] mtd: Pass attribute group to device_add_disk
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
Message-ID: <1471418115-3654-11-git-send-email-famz@redhat.com>

Previously after device_add_disk returns, the KOBJ_ADD uevent is already
emitted. Adding attributes after that is a poor usage of kobject, and
in practice may result in race conditions with userspace, for
example udev checks availability of certain attributes and initializes
/dev entries conditionally.

device_add_disk can handle adding attribute group better, so use it.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/mtd/mtd_blkdevs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 4ff9381..fc9265d 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -434,13 +434,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
-	device_add_disk(&new->mtd->dev, gd, NULL);
-
-	if (new->disk_attributes) {
-		ret = sysfs_create_group(&disk_to_dev(gd)->kobj,
-					new->disk_attributes);
-		WARN_ON(ret);
-	}
+	device_add_disk(&new->mtd->dev, gd, new->disk_attributes);
 	return 0;
 error4:
 	blk_cleanup_queue(new->rq);
-- 
2.7.4
