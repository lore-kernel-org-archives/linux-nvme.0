From: hch@bombadil.infradead.org (Christoph Hellwig)
Date: Tue, 18 Apr 2017 08:52:16 -0700
Subject: dm rq: don't pass irrelevant error code to blk_mq_complete_request
In-Reply-To: <20170418155229.5977-1-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
Message-ID: <20170418155229.5977-11-hch@bombadil.infradead.org>

From: Christoph Hellwig <hch@lst.de>

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
