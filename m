From: hch@bombadil.infradead.org (Christoph Hellwig)
Date: Tue, 18 Apr 2017 08:52:27 -0700
Subject: pd: remove bogus check for req->errors
In-Reply-To: <20170418155229.5977-1-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
Message-ID: <20170418155229.5977-22-hch@bombadil.infradead.org>

From: Christoph Hellwig <hch@lst.de>

The driver never sets req->errors
---
 drivers/block/paride/pd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index 82c6d02193ae..3b0ab214fe74 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -739,7 +739,6 @@ static int pd_special_command(struct pd_unit *disk,
 		      enum action (*func)(struct pd_unit *disk))
 {
 	struct request *rq;
-	int err = 0;
 
 	rq = blk_get_request(disk->gd->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
 	if (IS_ERR(rq))
@@ -748,10 +747,9 @@ static int pd_special_command(struct pd_unit *disk,
 	rq->special = func;
 
 	blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
-	err = req->errors ? -EIO : 0;
 
 	blk_put_request(rq);
-	return err;
+	return 0;
 }
 
 /* kernel glue structures */
-- 
2.11.0
