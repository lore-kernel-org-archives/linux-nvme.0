From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Dec 2014 17:54:13 -0700
Subject: [PATCH 1/4] blk-mq: Exit queue on alloc failure
In-Reply-To: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
Message-ID: <1419036856-16275-2-git-send-email-keith.busch@intel.com>

Fixes usage counter when a request could not be allocated.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6cd94ba..68050ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -258,8 +258,10 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw, gfp_t gfp,
 		ctx = alloc_data.ctx;
 	}
 	blk_mq_put_ctx(ctx);
-	if (!rq)
+	if (!rq) {
+		blk_mq_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
+	}
 	return rq;
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
-- 
1.7.10.4
