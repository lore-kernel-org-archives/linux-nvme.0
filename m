From: mlin@kernel.org (Ming Lin)
Date: Wed,  8 Jun 2016 15:48:11 -0400
Subject: [PATCH 1/2] blk-mq: add a function to return number of hw queues
 mapped
In-Reply-To: <1465415292-9416-1-git-send-email-mlin@kernel.org>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
Message-ID: <1465415292-9416-2-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Signed-off-by: Ming Lin <ming.l at samsung.com>
---
 block/blk-mq.c         | 15 +++++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b59d2ef..4c80046 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1888,6 +1888,21 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 	}
 }
 
+/* The number of hw queues that are mapped by sw queues */
+int blk_mq_hctx_mapped(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned int i;
+	int mapped = 0;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		if (blk_mq_hw_queue_mapped(hctx))
+			mapped++;
+
+	return mapped;
+}
+EXPORT_SYMBOL_GPL(blk_mq_hctx_mapped);
+
 static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 9a5d581..7cc4d51 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -250,6 +250,7 @@ void blk_mq_freeze_queue_start(struct request_queue *q);
 int blk_mq_reinit_tagset(struct blk_mq_tag_set *set);
 
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
+int blk_mq_hctx_mapped(struct request_queue *q);
 
 /*
  * Driver command data is immediately after the request. So subtract request
-- 
1.9.1
