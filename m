From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Apr 2017 21:26:56 +0200
Subject: [PATCH 11/23] dm rq: don't pass irrelevant error code to
 blk_mq_complete_request
In-Reply-To: <20170419192708.22098-1-hch@lst.de>
References: <20170419192708.22098-1-hch@lst.de>
Message-ID: <20170419192708.22098-12-hch@lst.de>

dm never uses rq->errors, so there is no need to pass an error argument
to blk_mq_complete_request.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/md/dm-rq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index e60f1b6845be..1173be21f6f6 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -363,7 +363,7 @@ static void dm_complete_request(struct request *rq, int error)
 	if (!rq->q->mq_ops)
 		blk_complete_request(rq);
 	else
-		blk_mq_complete_request(rq, error);
+		blk_mq_complete_request(rq, 0);
 }
 
 /*
-- 
2.11.0
