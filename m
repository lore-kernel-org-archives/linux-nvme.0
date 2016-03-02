From: hch@lst.de (Christoph Hellwig)
Date: Wed,  2 Mar 2016 18:07:13 +0100
Subject: [PATCH 4/5] block: fix blk_rq_get_max_sectors for driver private
 requests
In-Reply-To: <1456938434-20387-1-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
Message-ID: <1456938434-20387-5-git-send-email-hch@lst.de>

Driver private request types should not get the artifical cap for the
FS requests.  This is important to use the full device capabilities
for internal command or NVMe pass through commands.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
Tested-by: Jeff Lien <Jeff.Lien at hgst.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d7f6bca..f831dc0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -895,7 +895,7 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	if (unlikely(rq->cmd_type == REQ_TYPE_BLOCK_PC))
+	if (unlikely(rq->cmd_type >= REQ_TYPE_BLOCK_PC))
 		return q->limits.max_hw_sectors;
 
 	if (!q->limits.chunk_sectors || (rq->cmd_flags & REQ_DISCARD))
-- 
2.1.4
