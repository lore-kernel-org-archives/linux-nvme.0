From: sagig@mellanox.com (Sagi Grimberg)
Date: Wed,  9 Mar 2016 19:23:02 +0200
Subject: [PATCH v2 for-4.6 1/3] blk-mq: Export tagset iter function
In-Reply-To: <1457544184-2838-1-git-send-email-sagig@mellanox.com>
References: <1457544184-2838-1-git-send-email-sagig@mellanox.com>
Message-ID: <1457544184-2838-2-git-send-email-sagig@mellanox.com>

Its useful to iterate on all the active tags in cases
where we will need to fail all the queues IO.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
[hch: carefully check for valid tagsets]
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq-tag.c     | 12 ++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index abdbb47405cb..2fd04286f103 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -474,6 +474,18 @@ void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 }
 EXPORT_SYMBOL(blk_mq_all_tag_busy_iter);
 
+void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv)
+{
+	int i;
+
+	for (i = 0; i < tagset->nr_hw_queues; i++) {
+		if (tagset->tags && tagset->tags[i])
+			blk_mq_all_tag_busy_iter(tagset->tags[i], fn, priv);
+	}
+}
+EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
+
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15a73d49fd1d..865ee7016b72 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -240,6 +240,8 @@ void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv);
+void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
+		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_mq_freeze_queue_start(struct request_queue *q);
-- 
1.8.4.3
