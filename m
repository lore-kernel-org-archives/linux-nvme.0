From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 May 2015 13:30:20 -0600
Subject: [PATCH 1/4] blk: Define blk_set_queue_dying in header
In-Reply-To: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
Message-ID: <1431977423-31587-2-git-send-email-keith.busch@intel.com>

The 'blk_set_queue_dying()' function is an exported symbol, but it wasn't
defined in a header so wasn't usable to other components.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 include/linux/blkdev.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5d93a66..ed44ecd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -998,6 +998,7 @@ extern struct request_queue *blk_init_queue_node(request_fn_proc *rfn,
 extern struct request_queue *blk_init_queue(request_fn_proc *, spinlock_t *);
 extern struct request_queue *blk_init_allocated_queue(struct request_queue *,
 						      request_fn_proc *, spinlock_t *);
+extern void blk_set_queue_dying(struct request_queue *q);
 extern void blk_cleanup_queue(struct request_queue *);
 extern void blk_queue_make_request(struct request_queue *, make_request_fn *);
 extern void blk_queue_bounce_limit(struct request_queue *, u64);
-- 
1.7.10.4
