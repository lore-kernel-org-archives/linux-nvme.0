From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 22 Jul 2019 13:39:50 +0800
Subject: [PATCH 1/5] blk-mq: introduce blk_mq_request_completed()
In-Reply-To: <20190722053954.25423-1-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
Message-ID: <20190722053954.25423-2-ming.lei@redhat.com>

NVMe needs this function to decide if one request to be aborted has
been completed in normal IO path already.

So introduce it.

Cc: Max Gurtovoy <maxg at mellanox.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at lst.de>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..e1d0b4567388 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -665,6 +665,12 @@ int blk_mq_request_started(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
+int blk_mq_request_completed(struct request *rq)
+{
+	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
+}
+EXPORT_SYMBOL_GPL(blk_mq_request_completed);
+
 void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3fa1fa59f9b2..baac2926e54a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -296,6 +296,7 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 
 
 int blk_mq_request_started(struct request *rq);
+int blk_mq_request_completed(struct request *rq);
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
-- 
2.20.1
