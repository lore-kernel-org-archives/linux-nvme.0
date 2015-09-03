From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu,  3 Sep 2015 19:28:23 +0300
Subject: [PATCH 4/4] block: Copy a user iovec if it includes gaps
In-Reply-To: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
Message-ID: <1441297703-10753-5-git-send-email-sagig@mellanox.com>

For drivers that don't support gaps in the SG lists handed to
them we must bounce (copy the user buffers) and pass a bio that
does not include gaps. This doesn't matter for any current user,
but will help to allow iser which can't handle gaps to use the
block virtual boundary instead of using driver-local bounce
buffering when handling SG_IO commands.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-map.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index da310a105429..ac581a674b9b 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -9,6 +9,24 @@
 
 #include "blk.h"
 
+static bool iovec_gap_to_prv(struct request_queue *q,
+			     struct iovec *prv, struct iovec *cur)
+{
+	unsigned long prev_end;
+
+	if (!queue_virt_boundary(q))
+		return false;
+
+	if (prv->iov_base == NULL && prv->iov_len == 0)
+		/* prv is not set - don't check */
+		return false;
+
+	prev_end = (unsigned long)(prv->iov_base + prv->iov_len);
+
+	return (((unsigned long)cur->iov_base & queue_virt_boundary(q)) ||
+		prev_end & queue_virt_boundary(q));
+}
+
 int blk_rq_append_bio(struct request_queue *q, struct request *rq,
 		      struct bio *bio)
 {
@@ -67,7 +85,7 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	struct bio *bio;
 	int unaligned = 0;
 	struct iov_iter i;
-	struct iovec iov;
+	struct iovec iov, prv = {.iov_base = NULL, .iov_len = 0};
 
 	if (!iter || !iter->count)
 		return -EINVAL;
@@ -81,8 +99,12 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 		/*
 		 * Keep going so we check length of all segments
 		 */
-		if (uaddr & queue_dma_alignment(q))
+		if ((uaddr & queue_dma_alignment(q)) ||
+		    iovec_gap_to_prv(q, &prv, &iov))
 			unaligned = 1;
+
+		prv.iov_base = iov.iov_base;
+		prv.iov_len = iov.iov_len;
 	}
 
 	if (unaligned || (q->dma_pad_mask & iter->count) || map_data)
-- 
1.8.4.3
