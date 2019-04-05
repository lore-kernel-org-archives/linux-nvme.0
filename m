From: keith.busch@intel.com (Keith Busch)
Date: Fri,  5 Apr 2019 15:59:20 -0600
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
Message-ID: <20190405215920.27085-1-keith.busch@intel.com>

Managed interrupts can not migrate affinity when their CPUs are offline.
If the CPU is allowed to shutdown before they're returned, commands
dispatched to managed queues won't be able to complete through their
irq handlers.

Introduce per-hctx reference counting so we can block the CPU dead
notification for all allocated requests to complete if an hctx's last
CPU is being taken offline.

Cc: Ming Lei <ming.lei at redhat.com>
Cc: Thomas Gleixner <tglx at linutronix.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq-sched.c   |  2 ++
 block/blk-mq-sysfs.c   |  1 +
 block/blk-mq-tag.c     |  1 +
 block/blk-mq.c         | 36 ++++++++++++++++++++++++++++--------
 block/blk-mq.h         | 10 +++++++++-
 include/linux/blk-mq.h |  3 +++
 6 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 40905539afed..d1179e3d0fd1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -326,6 +326,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 	enum hctx_type type;
 
 	if (e && e->type->ops.bio_merge) {
+		blk_mq_unmap_queue(hctx);
 		blk_mq_put_ctx(ctx);
 		return e->type->ops.bio_merge(hctx, bio);
 	}
@@ -339,6 +340,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 		spin_unlock(&ctx->lock);
 	}
 
+	blk_mq_unmap_queue(hctx);
 	blk_mq_put_ctx(ctx);
 	return ret;
 }
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3f9c3f4ac44c..e85e702fbaaf 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -34,6 +34,7 @@ static void blk_mq_hw_sysfs_release(struct kobject *kobj)
 	struct blk_mq_hw_ctx *hctx = container_of(kobj, struct blk_mq_hw_ctx,
 						  kobj);
 	free_cpumask_var(hctx->cpumask);
+	percpu_ref_exit(&hctx->mapped);
 	kfree(hctx->ctxs);
 	kfree(hctx);
 }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc7be8a..df36af944e4a 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -162,6 +162,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 
 		if (data->ctx)
 			blk_mq_put_ctx(data->ctx);
+		blk_mq_unmap_queue(data->hctx);
 
 		bt_prev = bt;
 		io_schedule();
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ff3d7b49969..6b2fbe895c6b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -385,6 +385,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
+		blk_mq_unmap_queue(data->hctx);
 		if (put_ctx_on_error) {
 			blk_mq_put_ctx(data->ctx);
 			data->ctx = NULL;
@@ -516,6 +517,7 @@ void blk_mq_free_request(struct request *rq)
 	ctx->rq_completed[rq_is_sync(rq)]++;
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
+	blk_mq_unmap_queue(hctx);
 
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->backing_dev_info);
@@ -2222,14 +2224,19 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
 
-	if (list_empty(&tmp))
-		return 0;
-
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	if (!list_empty(&tmp)) {
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&tmp, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+	}
 
 	blk_mq_run_hw_queue(hctx, true);
+
+	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) >= nr_cpu_ids) {
+		percpu_ref_kill(&hctx->mapped);
+		wait_event(hctx->mapped_wq, percpu_ref_is_zero(&hctx->mapped));
+		percpu_ref_reinit(&hctx->mapped);
+	}
 	return 0;
 }
 
@@ -2275,6 +2282,14 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	}
 }
 
+static void hctx_mapped_release(struct percpu_ref *ref)
+{
+	struct blk_mq_hw_ctx *hctx =
+		container_of(ref, struct blk_mq_hw_ctx, mapped);
+
+	wake_up(&hctx->mapped_wq);
+}
+
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
@@ -2323,14 +2338,19 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (!hctx->fq)
 		goto exit_hctx;
 
-	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
+	init_waitqueue_head(&hctx->mapped_wq);
+	if (percpu_ref_init(&hctx->mapped, hctx_mapped_release, 0, GFP_KERNEL))
 		goto free_fq;
 
+	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
+		goto free_pcpu;
+
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
 
 	return 0;
-
+ free_pcpu:
+	percpu_ref_exit(&hctx->mapped);
  free_fq:
 	kfree(hctx->fq);
  exit_hctx:
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d704fc7766f4..1adee26a7b96 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -105,6 +105,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
 						     struct blk_mq_ctx *ctx)
 {
+	struct blk_mq_hw_ctx *hctx;
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
 
 	/*
@@ -115,7 +116,14 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 	else if ((flags & REQ_OP_MASK) == REQ_OP_READ)
 		type = HCTX_TYPE_READ;
 	
-	return ctx->hctxs[type];
+	hctx = ctx->hctxs[type];
+	percpu_ref_get(&hctx->mapped);
+	return hctx;
+}
+
+static inline void blk_mq_unmap_queue(struct blk_mq_hw_ctx *hctx)
+{
+	percpu_ref_put(&hctx->mapped);
 }
 
 /*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index cb2aa7ecafff..66e19611a46d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -58,6 +58,9 @@ struct blk_mq_hw_ctx {
 
 	atomic_t		nr_active;
 
+	wait_queue_head_t	mapped_wq;
+	struct percpu_ref	mapped;
+
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
 
-- 
2.14.4
