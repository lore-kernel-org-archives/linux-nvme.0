From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 21 Oct 2015 13:20:23 -0400
Subject: [PATCH v3 11/12] block: blk_flush_integrity() for bio-based drivers
In-Reply-To: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20151021172023.6456.31801.stgit@dwillia2-desk3.amr.corp.intel.com>

Since they lack requests to pin the request_queue active, synchronous
bio-based drivers may have in-flight integrity work from
bio_integrity_endio() that is not flushed by blk_freeze_queue().  Flush
that work to prevent races to free the queue and the final usage of the
blk_integrity profile.

This is temporary unless/until bio-based drivers start to generically
take a q_usage_counter reference while a bio is in-flight.

Cc: Martin K. Petersen <martin.petersen at oracle.com>
[martin: fix the CONFIG_BLK_DEV_INTEGRITY=n case]
Tested-by: Ross Zwisler <ross.zwisler at linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams at intel.com>
---
 block/bio-integrity.c |    5 +++++
 block/blk-core.c      |    3 +++
 block/blk.h           |    8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 6a90eca9cea1..f6325d573c10 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -32,6 +32,11 @@
 static struct kmem_cache *bip_slab;
 static struct workqueue_struct *kintegrityd_wq;
 
+void blk_flush_integrity(void)
+{
+	flush_workqueue(kintegrityd_wq);
+}
+
 /**
  * bio_integrity_alloc - Allocate integrity payload and attach it to bio
  * @bio:	bio to attach integrity metadata to
diff --git a/block/blk-core.c b/block/blk-core.c
index 9b4d735cb5b8..6ebe33ed5154 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -561,6 +561,9 @@ void blk_cleanup_queue(struct request_queue *q)
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
 
+	/* for synchronous bio-based driver finish in-flight integrity i/o */
+	blk_flush_integrity();
+
 	/* @q won't process any more request, flush async actions */
 	del_timer_sync(&q->backing_dev_info.laptop_mode_wb_timer);
 	blk_sync_queue(q);
diff --git a/block/blk.h b/block/blk.h
index 5b2cd393afbe..157c93d54dc9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -87,6 +87,14 @@ static inline void blk_queue_enter_live(struct request_queue *q)
 	percpu_ref_get(&q->q_usage_counter);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+void blk_flush_integrity(void);
+#else
+static inline void blk_flush_integrity(void)
+{
+}
+#endif
+
 void blk_rq_timed_out_timer(unsigned long data);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
