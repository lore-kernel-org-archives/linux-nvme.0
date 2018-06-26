From: keith.busch@intel.com (Keith Busch)
Date: Tue, 26 Jun 2018 09:14:58 -0600
Subject: [PATCH] block: Fix transfer when chuck sectors exceeds max
Message-ID: <20180626151458.6675-1-keith.busch@intel.com>

A device may have boundary restrictions where the number of sectors
between boundaries exceeds its max transfer size. In this case, we need
to cap the max size to the smaller of the two limits.

Reported-by: Jitendra Bhivare <jitendra.bhivare at broadcom.com>
Tested-by: Jitendra Bhivare <jitendra.bhivare at broadcom.com>
Cc: <stable at vger.kernel.org>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 include/linux/blkdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9154570edf29..79226ca8f80f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1119,8 +1119,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 	if (!q->limits.chunk_sectors)
 		return q->limits.max_sectors;
 
-	return q->limits.chunk_sectors -
-			(offset & (q->limits.chunk_sectors - 1));
+	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
+			(offset & (q->limits.chunk_sectors - 1))));
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
-- 
2.14.3
