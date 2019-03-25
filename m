From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 25 Mar 2019 13:38:34 +0800
Subject: [PATCH V2 4/8] mtip32xx: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1553492318-1810-5-git-send-email-jianchao.w.wang@oracle.com>

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 83302ec..103e691 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2771,12 +2771,12 @@ static int mtip_service_thread(void *data)
 
 			blk_mq_quiesce_queue(dd->queue);
 
-			blk_mq_tagset_busy_iter(&dd->tags, mtip_queue_cmd, dd);
+			blk_mq_queue_tag_inflight_iter(dd->queue, mtip_queue_cmd, dd);
 
 			set_bit(MTIP_PF_ISSUE_CMDS_BIT, &dd->port->flags);
 
 			if (mtip_device_reset(dd))
-				blk_mq_tagset_busy_iter(&dd->tags,
+				blk_mq_queue_tag_inflight_iter(dd->queue,
 							mtip_abort_cmd, dd);
 
 			clear_bit(MTIP_PF_TO_ACTIVE_BIT, &dd->port->flags);
@@ -3903,7 +3903,7 @@ static int mtip_block_remove(struct driver_data *dd)
 
 	blk_freeze_queue_start(dd->queue);
 	blk_mq_quiesce_queue(dd->queue);
-	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
+	blk_mq_queue_tag_inflight_iter(dd->queue, mtip_no_dev_cleanup, dd);
 	blk_mq_unquiesce_queue(dd->queue);
 
 	/*
-- 
2.7.4
