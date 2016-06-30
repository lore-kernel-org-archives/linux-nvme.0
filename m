From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 09:59:47 +0800
Subject: [PATCH v2 06/12] mtip32xx: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630015953.6888-7-famz@redhat.com>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 2d09fae..8c1cf03 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4042,7 +4042,7 @@ skip_create_disk:
 	set_capacity(dd->disk, capacity);
 
 	/* Enable the block device and add it to /dev */
-	add_disk(dd->disk, true);
+	add_disk(dd->disk, false);
 
 	dd->bdev = bdget_disk(dd->disk, 0);
 	/*
@@ -4054,6 +4054,7 @@ skip_create_disk:
 		mtip_hw_sysfs_init(dd, kobj);
 		kobject_put(kobj);
 	}
+	disk_gen_uevents(dd->disk);
 
 	if (dd->mtip_svc_handler) {
 		set_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag);
-- 
2.9.0
