From: axboe@fb.com (Jens Axboe)
Date: Fri, 14 Nov 2014 09:48:36 -0700
Subject: [PATCH] NVMe: limit max completion iterations in nvme_process_cq()
Message-ID: <20141114164836.GB12860@kernel.dk>

This is an unbounded loop. If we have per-cpu queues this is
usually not a problem, but if CPUs share a queue, then we could
have some of them continually queueing IO and the loop could take
forever to exit.

Limit max iterations to the queue depth of the given completion
queue, which seems like a nice number to use.

Signed-off-by: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f2964dfcea6c..fc2fc53992cb 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -697,12 +697,13 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
+	unsigned int max_iter = nvmeq->q_depth;
 	u16 head, phase;
 
 	head = nvmeq->cq_head;
 	phase = nvmeq->cq_phase;
 
-	for (;;) {
+	while (max_iter--) {
 		void *ctx;
 		nvme_completion_fn fn;
 		struct nvme_completion cqe = nvmeq->cqes[head];
-- 
1.9.1

-- 
Jens Axboe
