From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 14 Jun 2018 08:54:48 -0600
Subject: Read request exceeding max_hw_sectors_kb
In-Reply-To: <0ba3cccb9d2ee7cba50a91bfc92b373a@mail.gmail.com>
References: <0ba3cccb9d2ee7cba50a91bfc92b373a@mail.gmail.com>
Message-ID: <20180614145447.GB8129@localhost.localdomain>

On Wed, Jun 13, 2018@04:11:56PM +0530, Jitendra Bhivare wrote:
> So something like resolves the issue:
> static void nvme_set_chunk_size(struct nvme_ns *ns)
> {
> 	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
> 
> 	chunk_size = rounddown_pow_of_two(chunk_size);
> 	chunk_size = min(ns->ctrl->max_hw_sectors, chunk_size);
> 	blk_queue_chunk_sectors(ns->queue,
> rounddown_pow_of_two(chunk_size));
> }

That doesn't look right. The io boundary may have nothing to do with max
transfer size, so throttling the chunk size may cause lots of
unnecessary splits.

Isn't the reason it's failing is the block layer allowed a command to
form to the chunk size boundary instead of capping it to the max transfer
limit? How about this patch instead?

---
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bca3a92eb55f..9c57b49a4132 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1118,8 +1118,8 @@ static inline unsigned int blk_max_size_offset(struct request_queue *q,
 	if (!q->limits.chunk_sectors)
 		return q->limits.max_sectors;
 
-	return q->limits.chunk_sectors -
-			(offset & (q->limits.chunk_sectors - 1));
+	return min(q->limits.max_sectors, (unsigned int)(q->limits.chunk_sectors -
+			(offset & (q->limits.chunk_sectors - 1))));
 }
 
 static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
--
