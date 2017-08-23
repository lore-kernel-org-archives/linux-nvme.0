From: hch@lst.de (Christoph Hellwig)
Date: Wed, 23 Aug 2017 19:58:14 +0200
Subject: [PATCH 09/10] blk-mq: add a blk_steal_bios helper
In-Reply-To: <20170823175815.3646-1-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
Message-ID: <20170823175815.3646-10-hch@lst.de>

This helpers allows to bounce steal the uncompleted bios from a request so
that they can be reissued on another path.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-core.c       | 20 ++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index e91f3477538f..db18e3befdd5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2702,6 +2702,26 @@ struct request *blk_fetch_request(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_fetch_request);
 
+/*
+ * Steal bios from a request.  The request must not have been partially
+ * completed before.
+ */
+void blk_steal_bios(struct bio_list *list, struct request *rq)
+{
+	if (rq->bio) {
+		if (list->tail)
+			list->tail->bi_next = rq->bio;
+		else
+			list->head = rq->bio;
+		list->tail = rq->biotail;
+	}
+
+	rq->bio = NULL;
+	rq->biotail = NULL;
+	rq->__data_len = 0;
+}
+EXPORT_SYMBOL_GPL(blk_steal_bios);
+
 /**
  * blk_update_request - Special helper function for request stacking drivers
  * @req:      the request being processed
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5f81151d181a..e8c11ad68809 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1112,6 +1112,8 @@ extern struct request *blk_peek_request(struct request_queue *q);
 extern void blk_start_request(struct request *rq);
 extern struct request *blk_fetch_request(struct request_queue *q);
 
+void blk_steal_bios(struct bio_list *list, struct request *rq);
+
 /*
  * Request completion related functions.
  *
-- 
2.11.0
