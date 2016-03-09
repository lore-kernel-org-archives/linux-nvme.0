From: keith.busch@intel.com (Keith Busch)
Date: Wed, 9 Mar 2016 20:54:36 +0000
Subject: [PATCH v2 for-4.6 3/3] blk-mq: Make blk_mq_all_tag_busy_iter
 static
In-Reply-To: <1457544184-2838-4-git-send-email-sagig@mellanox.com>
References: <1457544184-2838-1-git-send-email-sagig@mellanox.com>
 <1457544184-2838-4-git-send-email-sagig@mellanox.com>
Message-ID: <20160309205436.GA22470@localhost.localdomain>

On Wed, Mar 09, 2016@07:23:04PM +0200, Sagi Grimberg wrote:
> No caller outside the blk-mq code so we can settle
> with it static.

Hi Sagi,

The mtip32xx driver in linux-block/for-next is using
blk_mq_all_tag_busy_iter. This looks like the equivalent change for
that driver:

---
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 1c330b6..71bb370 100644
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
@@ -4175,7 +4175,7 @@ static int mtip_block_remove(struct driver_data *dd)
 
 	blk_mq_freeze_queue_start(dd->queue);
 	blk_mq_stop_hw_queues(dd->queue);
-	blk_mq_all_tag_busy_iter(dd->tags.tags[0], mtip_no_dev_cleanup, dd);
+	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
 
 	/*
 	 * Delete our gendisk structure. This also removes the device
--
