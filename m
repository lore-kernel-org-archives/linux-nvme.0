From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 25 Mar 2019 13:28:04 +0800
Subject: [PATCH V2 3/8] blk-mq: use blk_mq_queue_tag_inflight_iter in debugfs
In-Reply-To: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1553491689-1730-4-git-send-email-jianchao.w.wang@oracle.com>

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ec1d18c..b7f2538 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -438,7 +438,7 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	struct show_busy_params params = { .m = m, .hctx = hctx };
 
-	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
+	blk_mq_queue_tag_inflight_iter(hctx->queue, hctx_show_busy_rq,
 				&params);
 
 	return 0;
-- 
2.7.4
