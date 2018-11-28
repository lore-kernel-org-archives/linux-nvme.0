From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Nov 2018 06:35:37 -0700
Subject: [PATCH 6/7] blk-mq: use bd->last == true for list inserts
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Message-ID: <20181128133538.20329-7-axboe@kernel.dk>

If we are issuing a list of requests, we know if we're at the last one.
If we fail issuing, ensure that we call ->commits_rqs() to flush any
potential previous requests.

Reviewed-by: Omar Sandoval <osandov at fb.com>
Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 block/blk-core.c |  2 +-
 block/blk-mq.c   | 16 ++++++++--------
 block/blk-mq.h   |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d107d016b92b..3f6f5e6c2fe4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1334,7 +1334,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 	 * bypass a potential scheduler on the bottom device for
 	 * insert.
 	 */
-	return blk_mq_request_issue_directly(rq);
+	return blk_mq_request_issue_directly(rq, true);
 }
 EXPORT_SYMBOL_GPL(blk_insert_cloned_request);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 18ff47a85ad3..9e1045152e45 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1743,12 +1743,12 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
 static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 					    struct request *rq,
-					    blk_qc_t *cookie)
+					    blk_qc_t *cookie, bool last)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
-		.last = true,
+		.last = last,
 	};
 	blk_qc_t new_cookie;
 	blk_status_t ret;
@@ -1783,7 +1783,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass_insert)
+						bool bypass_insert, bool last)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
@@ -1812,7 +1812,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
+	return __blk_mq_issue_directly(hctx, rq, cookie, last);
 insert:
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
@@ -1831,7 +1831,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	hctx_lock(hctx, &srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
+	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false, true);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_sched_insert_request(rq, false, true, false);
 	else if (ret != BLK_STS_OK)
@@ -1840,7 +1840,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	hctx_unlock(hctx, srcu_idx);
 }
 
-blk_status_t blk_mq_request_issue_directly(struct request *rq)
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 {
 	blk_status_t ret;
 	int srcu_idx;
@@ -1848,7 +1848,7 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true, last);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
@@ -1863,7 +1863,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
+		ret = blk_mq_request_issue_directly(rq, list_empty(list));
 		if (ret != BLK_STS_OK) {
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ae8e9f8f8b1..7291e5379358 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -69,7 +69,7 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
 /* Used by blk_insert_cloned_request() to issue request directly */
-blk_status_t blk_mq_request_issue_directly(struct request *rq);
+blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last);
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				    struct list_head *list);
 
-- 
2.17.1
