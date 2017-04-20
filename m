From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Apr 2017 16:02:54 +0200
Subject: [PATCH 01/23] pd: don't check blk_execute_rq return value.
In-Reply-To: <20170420140316.6546-1-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
Message-ID: <20170420140316.6546-2-hch@lst.de>

The driver never sets req->errors, so blk_execute_rq will always return 0.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Bart Van Assche <Bart.VanAssche at sandisk.com>
---
 drivers/block/paride/pd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
index b05e151c9b38..7d2402f90978 100644
--- a/drivers/block/paride/pd.c
+++ b/drivers/block/paride/pd.c
@@ -739,18 +739,15 @@ static int pd_special_command(struct pd_unit *disk,
 		      enum action (*func)(struct pd_unit *disk))
 {
 	struct request *rq;
-	int err = 0;
 
 	rq = blk_get_request(disk->gd->queue, REQ_OP_DRV_IN, __GFP_RECLAIM);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 
 	rq->special = func;
-
-	err = blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
-
+	blk_execute_rq(disk->gd->queue, disk->gd, rq, 0);
 	blk_put_request(rq);
-	return err;
+	return 0;
 }
 
 /* kernel glue structures */
-- 
2.11.0
