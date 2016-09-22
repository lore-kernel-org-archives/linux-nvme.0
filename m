From: hch@infradead.org ('Christoph Hellwig')
Date: Thu, 22 Sep 2016 14:02:55 -0700
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <20160916142649.GA18798@infradead.org>
References: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
 <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
 <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
 <20160916142649.GA18798@infradead.org>
Message-ID: <20160922210255.GA11015@infradead.org>

Steve,

can you test if the patch below properly fails the connect and avoids
the crash?

We could potentially also do something better than just returning the
error in that case.  From a quick look at the code even just ignoring
a EXDEV return from nvmf_connect_io_queue might do the right thing,
so feel free to try that if you have some spare cycles.

---
>From d76be818600d92341125b7c78dcab780a9833427 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 22 Sep 2016 13:56:54 -0700
Subject: blk-mq: skip unmapped queues in blk_mq_alloc_request_hctx

This provides the caller a feedback that a given hctx is not mapped and thus
no command can be sent on it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9b8007..7b430ab 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -266,17 +266,29 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	if (ret)
 		return ERR_PTR(ret);
 
+	/*
+	 * Check if the hardware context is actually mapped to anything.
+	 * If not tell the caller that it should skip this queue.
+	 */
 	hctx = q->queue_hw_ctx[hctx_idx];
+	if (!blk_mq_hw_queue_mapped(hctx)) {
+		ret = -EXDEV;
+		goto out_queue_exit;
+	}
 	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
 
 	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
 	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
 	if (!rq) {
-		blk_queue_exit(q);
-		return ERR_PTR(-EWOULDBLOCK);
+		ret = -EWOULDBLOCK;
+		goto out_queue_exit;
 	}
 
 	return rq;
+
+out_queue_exit:
+	blk_queue_exit(q);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-- 
2.1.4
