From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 27 Feb 2017 17:36:21 +0200
Subject: [PATCH 2/2] blk-mq: make sure to back-assign the request to rq_map in
 blk_mq_alloc_request_hctx
In-Reply-To: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
References: <1488209781-1084-1-git-send-email-sagi@grimberg.me>
Message-ID: <1488209781-1084-2-git-send-email-sagi@grimberg.me>

Otherwise we won't be able to retrieve the request from
the tag.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d84c66fb37b7..9611cd9920e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -312,6 +312,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 		ret = -EWOULDBLOCK;
 		goto out_queue_exit;
 	}
+	alloc_data.hctx->tags->rqs[rq->tag] = rq;
 
 	return rq;
 
-- 
2.7.4
