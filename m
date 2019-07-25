From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:33 -0600
Subject: [PATCH v6 14/16] block: don't check blk_rq_is_passthrough() in
 blk_do_io_stat()
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-15-logang@deltatee.com>

Instead of checking blk_rq_is_passthruough() for every call to
blk_do_io_stat(), don't set RQF_IO_STAT for passthrough requests.
This should be equivalent, and opens the possibility of passthrough
requests specifically requesting statistics tracking.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 block/blk-mq.c | 2 +-
 block/blk.h    | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..b8d41d6824f6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -318,7 +318,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->cmd_flags = op;
 	if (data->flags & BLK_MQ_REQ_PREEMPT)
 		rq->rq_flags |= RQF_PREEMPT;
-	if (blk_queue_io_stat(data->q))
+	if (blk_queue_io_stat(data->q) && !blk_rq_is_passthrough(rq))
 		rq->rq_flags |= RQF_IO_STAT;
 	INIT_LIST_HEAD(&rq->queuelist);
 	INIT_HLIST_NODE(&rq->hash);
diff --git a/block/blk.h b/block/blk.h
index de6b2e146d6e..554efa769bfe 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -234,13 +234,12 @@ int blk_dev_init(void);
  *
  *	a) it's attached to a gendisk, and
  *	b) the queue had IO stats enabled when this request was started, and
- *	c) it's a file system request
+ *	c) it's a file system request (RQF_IO_STAT will not be set otherwise)
  */
 static inline bool blk_do_io_stat(struct request *rq)
 {
 	return rq->rq_disk &&
-	       (rq->rq_flags & RQF_IO_STAT) &&
-		!blk_rq_is_passthrough(rq);
+	       (rq->rq_flags & RQF_IO_STAT);
 }
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
-- 
2.20.1
