From: keith.busch@intel.com (Keith Busch)
Date: Mon, 14 Aug 2017 16:40:11 -0400
Subject: [PATCH] blk-mq: Fix queue usage on failed request allocation
Message-ID: <1502743211-14992-1-git-send-email-keith.busch@intel.com>

blk_mq_get_request() does not release the callers queue usage counter
when allocation fails. The caller still needs to account for its own
queue usage when it is unable to allocate a request.

Fixes: 1ad43c0078b7 ("blk-mq: don't leak preempt counter/q_usage_counter when allocating rq failed")

Reported-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 535cbdf..4603b11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -360,12 +360,12 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		return ERR_PTR(ret);
 
 	rq = blk_mq_get_request(q, NULL, op, &alloc_data);
+	blk_queue_exit(q);
 
 	if (!rq)
 		return ERR_PTR(-EWOULDBLOCK);
 
 	blk_mq_put_ctx(alloc_data.ctx);
-	blk_queue_exit(q);
 
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
@@ -411,12 +411,11 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
 	rq = blk_mq_get_request(q, NULL, op, &alloc_data);
+	blk_queue_exit(q);
 
 	if (!rq)
 		return ERR_PTR(-EWOULDBLOCK);
 
-	blk_queue_exit(q);
-
 	return rq;
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
-- 
2.5.5
