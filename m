From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri, 15 Mar 2019 16:57:39 +0800
Subject: [PATCH 3/8] blk-mq: use blk_mq_queue_tag_busy_iter in debugfs
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1552640264-26101-4-git-send-email-jianchao.w.wang@oracle.com>

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 block/blk-mq-debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7921573..7c4e771 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -442,8 +442,8 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	struct show_busy_params params = { .m = m, .hctx = hctx };
 
-	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
-				&params);
+	blk_mq_queue_tag_busy_iter(hctx->queue, hctx_show_busy_rq,
+				&params, true);
 
 	return 0;
 }
-- 
2.7.4
