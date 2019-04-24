From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Apr 2019 19:02:19 +0800
Subject: [PATCH V7 7/9] blk-mq: move cancel of hctx->run_work into
 blk_mq_hw_sysfs_release
In-Reply-To: <20190424110221.17435-1-ming.lei@redhat.com>
References: <20190424110221.17435-1-ming.lei@redhat.com>
Message-ID: <20190424110221.17435-8-ming.lei@redhat.com>

hctx is always released after requeue is freed.

With holding queue's kobject refcount, it is safe for driver to run queue,
so one run queue might be scheduled after blk_sync_queue() is done.

So moving the cancel of hctx->run_work into blk_mq_hw_sysfs_release()
for avoiding run released queue.

Cc: Dongli Zhang <dongli.zhang at oracle.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Bart Van Assche <bart.vanassche at wdc.com>
Cc: linux-scsi at vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen at oracle.com>,
Cc: Christoph Hellwig <hch at lst.de>,
Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,
Reviewed-by: Bart Van Assche <bvanassche at acm.org>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Tested-by: James Smart <james.smart at broadcom.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 block/blk-core.c     | 8 --------
 block/blk-mq-sysfs.c | 2 ++
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 2dd94b3e9ece..f5b5f21ae4fd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -232,14 +232,6 @@ void blk_sync_queue(struct request_queue *q)
 {
 	del_timer_sync(&q->timeout);
 	cancel_work_sync(&q->timeout_work);
-
-	if (queue_is_mq(q)) {
-		struct blk_mq_hw_ctx *hctx;
-		int i;
-
-		queue_for_each_hw_ctx(q, hctx, i)
-			cancel_delayed_work_sync(&hctx->run_work);
-	}
 }
 EXPORT_SYMBOL(blk_sync_queue);
 
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 4040e62c3737..25c0d0a6a556 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -35,6 +35,8 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 
+	cancel_delayed_work_sync(&hctx->run_work);
+
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		cleanup_srcu_struct(hctx->srcu);
 	blk_free_flush_queue(hctx->fq);
-- 
2.9.5
