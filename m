From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri, 15 Mar 2019 16:57:41 +0800
Subject: [PATCH 5/8] nbd: use blk_mq_queue_tag_busy_iter
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1552640264-26101-6-git-send-email-jianchao.w.wang@oracle.com>

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7c9a949..9e7e828 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -747,7 +747,7 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 static void nbd_clear_que(struct nbd_device *nbd)
 {
 	blk_mq_quiesce_queue(nbd->disk->queue);
-	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
+	blk_mq_queue_tag_busy_iter(nbd->disk->queue, nbd_clear_req, NULL, true);
 	blk_mq_unquiesce_queue(nbd->disk->queue);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
-- 
2.7.4
