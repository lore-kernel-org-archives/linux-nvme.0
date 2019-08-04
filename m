From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  4 Aug 2019 16:19:02 +0900
Subject: [PATCH] nvme: simplify nvme_req_qid()
Message-ID: <20190804071902.31872-1-minwoo.im.dev@gmail.com>

blk_mq_unique_tag() just makes a unique tag which holds not only the
tag, but also the queue_num of the hctx.  With this unique tag,
blk_mq_unique_tag_to_hwq is nothing but removing the tag from it.

Therefore the qid or the I/O queues can simply be:
	(struct blk_mq_hw_ctx *)->queue_num + 1

Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 26b563f9985b..2e76198f5833 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -126,7 +126,7 @@ static inline u16 nvme_req_qid(struct request *req)
 {
 	if (!req->rq_disk)
 		return 0;
-	return blk_mq_unique_tag_to_hwq(blk_mq_unique_tag(req)) + 1;
+	return req->mq_hctx->queue_num + 1;
 }
 
 /* The below value is the specific amount of delay needed before checking
-- 
2.17.1
