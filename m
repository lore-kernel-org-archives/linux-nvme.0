From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:43 -0700
Subject: [PATCHv3 02/12] blk-mq: Export if requests were started
In-Reply-To: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
References: <1420682153-3756-1-git-send-email-keith.busch@intel.com>
Message-ID: <1420682153-3756-3-git-send-email-keith.busch@intel.com>

Drivers can iterate over all allocated request tags, but their callback
needs a way to know if the driver started the request in the first place.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c         |    6 ++++++
 include/linux/blk-mq.h |    1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c5aa4eb..d7123f3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -398,6 +398,12 @@ void blk_mq_complete_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
+int blk_mq_request_started(struct request *rq)
+{
+	return test_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_started);
+
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d0de259..addf8a1 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -194,6 +194,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *, const int ctx_index);
 struct blk_mq_hw_ctx *blk_mq_alloc_single_hw_queue(struct blk_mq_tag_set *, unsigned int, int);
 
+int blk_mq_request_started(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, int error);
 void __blk_mq_end_request(struct request *rq, int error);
-- 
1.7.10.4
