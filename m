From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu, 24 Dec 2015 13:24:01 +0200
Subject: [PATCH RFC 4/4] blk-mq: Make blk_mq_all_tag_busy_iter static
In-Reply-To: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
References: <1450956241-4626-1-git-send-email-sagig@mellanox.com>
Message-ID: <1450956241-4626-5-git-send-email-sagig@mellanox.com>

No caller outside the blk-mq code so we can settle with it static.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-mq-tag.c     |    5 ++---
 include/linux/blk-mq.h |    2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 39660ca..be635fa 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -464,15 +464,14 @@ static void bt_tags_for_each(struct blk_mq_tags *tags,
 	}
 }
 
-void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
-		void *priv)
+static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
 		bt_tags_for_each(tags, &tags->breserved_tags, 0, fn, priv, true);
 	bt_tags_for_each(tags, &tags->bitmap_tags, tags->nr_reserved_tags, fn, priv,
 			false);
 }
-EXPORT_SYMBOL(blk_mq_all_tag_busy_iter);
 
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 97a4652..b5e6af4 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -240,8 +240,6 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
-void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
-		void *priv);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
-- 
1.7.1
