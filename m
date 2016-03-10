From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu, 10 Mar 2016 13:58:48 +0200
Subject: [PATCH v3 for-4.6 3/4] mtip32xx: Convert to use
 blk_mq_tagset_busy_iter
In-Reply-To: <1457611129-8036-1-git-send-email-sagig@mellanox.com>
References: <1457611129-8036-1-git-send-email-sagig@mellanox.com>
Message-ID: <1457611129-8036-4-git-send-email-sagig@mellanox.com>

From: Keith Busch <keith.busch@intel.com>

Only a single tags array anyway.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index cc2e71d0a77f..2cc86f70c01f 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3000,14 +3000,14 @@ restart_eh:
 					"Completion workers still active!");
 
 			spin_lock(dd->queue->queue_lock);
-			blk_mq_all_tag_busy_iter(*dd->tags.tags,
+			blk_mq_tagset_busy_iter(&dd->tags,
 							mtip_queue_cmd, dd);
 			spin_unlock(dd->queue->queue_lock);
 
 			set_bit(MTIP_PF_ISSUE_CMDS_BIT, &dd->port->flags);
 
 			if (mtip_device_reset(dd))
-				blk_mq_all_tag_busy_iter(*dd->tags.tags,
+				blk_mq_tagset_busy_iter(&dd->tags,
 							mtip_abort_cmd, dd);
 
 			clear_bit(MTIP_PF_TO_ACTIVE_BIT, &dd->port->flags);
@@ -4174,7 +4174,7 @@ static int mtip_block_remove(struct driver_data *dd)
 
 	blk_mq_freeze_queue_start(dd->queue);
 	blk_mq_stop_hw_queues(dd->queue);
-	blk_mq_all_tag_busy_iter(dd->tags.tags[0], mtip_no_dev_cleanup, dd);
+	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
 
 	/*
 	 * Delete our gendisk structure. This also removes the device
-- 
1.8.4.3
