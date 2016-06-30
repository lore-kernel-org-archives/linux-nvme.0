From: famz@redhat.com (Fam Zheng)
Date: Thu, 30 Jun 2016 09:59:51 +0800
Subject: [PATCH v2 10/12] mmc: Generate uevent after attribute available
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
Message-ID: <20160630015953.6888-11-famz@redhat.com>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz at redhat.com>
---
 drivers/mmc/card/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 94cf51e..4007106 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2457,7 +2457,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	int ret;
 	struct mmc_card *card = md->queue.card;
 
-	add_disk(md->disk, true);
+	add_disk(md->disk, false);
 	md->force_ro.show = force_ro_show;
 	md->force_ro.store = force_ro_store;
 	sysfs_attr_init(&md->force_ro.attr);
@@ -2466,6 +2466,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
 	if (ret)
 		goto force_ro_fail;
+	disk_gen_uevents(md->disk);
 
 	if ((md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
 	     card->ext_csd.boot_ro_lockable) {
-- 
2.9.0
