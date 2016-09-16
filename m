From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:28 +0200
Subject: [PATCH RFC 17/21] blk-mq: Introduce a 1:N hardware contexts
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <a8acc747b1925a9991c016a674595a8a406679a5.1474014910.git.agordeev@redhat.com>

This is 1st change in a bid to enable mapping of multiple
device hardware queues to a single CPU.

It introduces concepts of 1:1 low-level hardware context
(1 low-level hardware context to 1 device hardware queue)
and opposed to 1:N hardware context (1 hardware context to
N device hardware queues). Basically, it replaces what is
now 1:1 hardware context.

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org
Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 block/blk-core.c                  |  3 ++-
 block/blk-mq.c                    | 32 +++++++++++++++++++++++---------
 drivers/block/loop.c              |  2 +-
 drivers/block/mtip32xx/mtip32xx.c |  3 ++-
 drivers/block/null_blk.c          | 11 +++++------
 drivers/block/rbd.c               |  2 +-
 drivers/block/virtio_blk.c        |  5 +++--
 drivers/block/xen-blkfront.c      |  5 +++--
 drivers/md/dm-rq.c                |  3 ++-
 drivers/nvme/host/pci.c           | 27 +++++++++++++++------------
 drivers/scsi/scsi_lib.c           |  3 ++-
 include/linux/blk-mq.h            | 27 +++++++++++++++++++++------
 12 files changed, 80 insertions(+), 43 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 36c7ac3..bf4f196 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3314,11 +3314,12 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 	while (!need_resched()) {
 		unsigned int queue_num = blk_qc_t_to_queue_num(cookie);
 		struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[queue_num];
+		struct blk_mq_llhw_ctx *llhw_ctx = &hctx->llhw_ctxs[0];
 		int ret;
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, blk_qc_t_to_tag(cookie));
+		ret = q->mq_ops->poll(llhw_ctx, blk_qc_t_to_tag(cookie));
 		if (ret > 0) {
 			hctx->poll_success++;
 			set_current_state(TASK_RUNNING);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c27e64e..274eab8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -838,7 +838,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 		bd.list = dptr;
 		bd.last = list_empty(&rq_list);
 
-		ret = q->mq_ops->queue_rq(hctx, &bd);
+		ret = q->mq_ops->queue_rq(&hctx->llhw_ctxs[0], &bd);
 		switch (ret) {
 		case BLK_MQ_RQ_QUEUE_OK:
 			queued++;
@@ -1266,7 +1266,7 @@ static int blk_mq_direct_issue_request(struct request *rq, blk_qc_t *cookie)
 	 * error (busy), just add it to our list as we previously
 	 * would have done
 	 */
-	ret = q->mq_ops->queue_rq(hctx, &bd);
+	ret = q->mq_ops->queue_rq(&hctx->llhw_ctxs[0], &bd);
 	if (ret == BLK_MQ_RQ_QUEUE_OK) {
 		*cookie = new_cookie;
 		return 0;
@@ -1661,6 +1661,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
+	int i;
+
 	blk_mq_tag_idle(hctx);
 
 	if (set->ops->exit_request)
@@ -1669,7 +1671,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 				       BLK_MQ_MAX_DEPTH + hctx_idx);
 
 	if (set->ops->exit_hctx)
-		set->ops->exit_hctx(hctx, hctx_idx);
+		for (i = 0; i < hctx->nr_llhw_ctx; i++)
+			set->ops->exit_hctx(&hctx->llhw_ctxs[i]);
 
 	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
 	blk_free_flush_queue(hctx->fq);
@@ -1696,13 +1699,16 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set, unsigned hctx_idx)
 {
 	struct blk_mq_hw_ctx *hctx;
+	unsigned int nr_llhw_ctx = 1;
 	int node;
+	int i;
 
 	node = blk_mq_hw_queue_to_node(q->mq_map, hctx_idx);
 	if (node == NUMA_NO_NODE)
 		node = set->numa_node;
 
-	hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
+	hctx = kzalloc_node(sizeof(*hctx) +
+		nr_llhw_ctx * sizeof(hctx->llhw_ctxs[0]), GFP_KERNEL, node);
 	if (!hctx)
 		return NULL;
 
@@ -1734,6 +1740,7 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	hctx->queue = q;
 	hctx->queue_num = hctx_idx;
 	hctx->nr_ctx = 0;
+	hctx->nr_llhw_ctx = nr_llhw_ctx;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
 	hctx->tags = set->tags[hctx_idx];
 
@@ -1741,9 +1748,16 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 					blk_mq_hctx_notify, hctx);
 	blk_mq_register_cpu_notifier(&hctx->cpu_notifier);
 
-	if (set->ops->init_hctx &&
-	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto unregister_cpu_notifier;
+	for (i = 0; i < hctx->nr_llhw_ctx; i++) {
+		struct blk_mq_llhw_ctx *llhw_ctx = &hctx->llhw_ctxs[i];
+
+		llhw_ctx->index = i;
+		llhw_ctx->queue_id = hctx_idx;
+
+		if (set->ops->init_hctx &&
+		    set->ops->init_hctx(llhw_ctx, set->driver_data))
+			goto exit_hctx;
+	}
 
 	if (set->ops->init_request &&
 	    set->ops->init_request(set->driver_data,
@@ -1755,8 +1769,8 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 
  exit_hctx:
 	if (set->ops->exit_hctx)
-		set->ops->exit_hctx(hctx, hctx_idx);
- unregister_cpu_notifier:
+		for (i--; i >= 0; i--)
+			set->ops->exit_hctx(&hctx->llhw_ctxs[i]);
 	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
 	kfree(hctx->fq);
  free_bitmap:
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cbdb3b1..f290c64 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1637,7 +1637,7 @@ int loop_unregister_transfer(int number)
 EXPORT_SYMBOL(loop_register_transfer);
 EXPORT_SYMBOL(loop_unregister_transfer);
 
-static int loop_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int loop_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 		const struct blk_mq_queue_data *bd)
 {
 	struct loop_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 3cc92e9..5d7c17d 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3805,9 +3805,10 @@ static bool mtip_check_unal_depth(struct blk_mq_hw_ctx *hctx,
 	return false;
 }
 
-static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int mtip_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 			 const struct blk_mq_queue_data *bd)
 {
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
 	struct request *rq = bd->rq;
 	int ret;
 
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 7d3b7d6..1747040 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -351,7 +351,7 @@ static void null_request_fn(struct request_queue *q)
 	}
 }
 
-static int null_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int null_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 			 const struct blk_mq_queue_data *bd)
 {
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
@@ -361,7 +361,7 @@ static int null_queue_rq(struct blk_mq_hw_ctx *hctx,
 		cmd->timer.function = null_cmd_timer_expired;
 	}
 	cmd->rq = bd->rq;
-	cmd->nq = hctx->driver_data;
+	cmd->nq = llhw_ctx->driver_data;
 
 	blk_mq_start_request(bd->rq);
 
@@ -378,13 +378,12 @@ static void null_init_queue(struct nullb *nullb, struct nullb_queue *nq)
 	nq->queue_depth = nullb->queue_depth;
 }
 
-static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-			  unsigned int index)
+static int null_init_hctx(struct blk_mq_llhw_ctx *llhw_ctx, void *data)
 {
 	struct nullb *nullb = data;
-	struct nullb_queue *nq = &nullb->queues[index];
+	struct nullb_queue *nq = &nullb->queues[llhw_ctx->queue_id];
 
-	hctx->driver_data = nq;
+	llhw_ctx->driver_data = nq;
 	null_init_queue(nullb, nq);
 	nullb->nr_queues++;
 
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c1f84df..7dd5e0e 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3383,7 +3383,7 @@ err:
 	blk_mq_end_request(rq, result);
 }
 
-static int rbd_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int rbd_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 		const struct blk_mq_queue_data *bd)
 {
 	struct request *rq = bd->rq;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2dc5c96..9cc26c7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -157,15 +157,16 @@ static void virtblk_done(struct virtqueue *vq)
 	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
-static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int virtio_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 			   const struct blk_mq_queue_data *bd)
 {
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct request *req = bd->rq;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	unsigned long flags;
 	unsigned int num;
-	int qid = hctx->queue_num;
+	int qid = llhw_ctx->queue_id;
 	int err;
 	bool notify = false;
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 9908597..784c4d5 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -872,11 +872,12 @@ static inline bool blkif_request_flush_invalid(struct request *req,
 		 !info->feature_fua));
 }
 
-static int blkif_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int blkif_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 			  const struct blk_mq_queue_data *qd)
 {
 	unsigned long flags;
-	int qid = hctx->queue_num;
+	int qid = llhw_ctx->queue_id;
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
 	struct blkfront_info *info = hctx->queue->queuedata;
 	struct blkfront_ring_info *rinfo = NULL;
 
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index d1c3645..b074137 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -855,9 +855,10 @@ static int dm_mq_init_request(void *data, struct request *rq,
 	return 0;
 }
 
-static int dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int dm_mq_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 			  const struct blk_mq_queue_data *bd)
 {
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
 	struct request *rq = bd->rq;
 	struct dm_rq_target_io *tio = blk_mq_rq_to_pdu(rq);
 	struct mapped_device *md = tio->md;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 086fd7e..eef2e40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -201,9 +201,10 @@ static unsigned int nvme_cmd_size(struct nvme_dev *dev)
 		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
 }
 
-static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-				unsigned int hctx_idx)
+static int nvme_admin_init_hctx(struct blk_mq_llhw_ctx *llhw_ctx, void *data)
 {
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
+	unsigned int hctx_idx = llhw_ctx->queue_id;
 	struct nvme_dev *dev = data;
 	struct nvme_queue *nvmeq = dev->queues[0];
 
@@ -211,14 +212,14 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
 	WARN_ON(nvmeq->tags);
 
-	hctx->driver_data = nvmeq;
+	llhw_ctx->driver_data = nvmeq;
 	nvmeq->tags = &dev->admin_tagset.tags[0];
 	return 0;
 }
 
-static void nvme_admin_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+static void nvme_admin_exit_hctx(struct blk_mq_llhw_ctx *llhw_ctx)
 {
-	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_queue *nvmeq = llhw_ctx->driver_data;
 
 	nvmeq->tags = NULL;
 }
@@ -236,9 +237,10 @@ static int nvme_admin_init_request(void *data, struct request *req,
 	return 0;
 }
 
-static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
-			  unsigned int hctx_idx)
+static int nvme_init_hctx(struct blk_mq_llhw_ctx *llhw_ctx, void *data)
 {
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
+	unsigned int hctx_idx = llhw_ctx->queue_id;
 	struct nvme_dev *dev = data;
 	struct nvme_queue *nvmeq = dev->queues[hctx_idx + 1];
 
@@ -246,7 +248,7 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		nvmeq->tags = &dev->tagset.tags[hctx_idx];
 
 	WARN_ON(dev->tagset.tags[hctx_idx] != hctx->tags);
-	hctx->driver_data = nvmeq;
+	llhw_ctx->driver_data = nvmeq;
 	return 0;
 }
 
@@ -558,11 +560,12 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 /*
  * NOTE: ns is NULL when called on the admin queue.
  */
-static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int nvme_queue_rq(struct blk_mq_llhw_ctx *llhw_ctx,
 			 const struct blk_mq_queue_data *bd)
 {
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
 	struct nvme_ns *ns = hctx->queue->queuedata;
-	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_queue *nvmeq = llhw_ctx->driver_data;
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *req = bd->rq;
 	struct nvme_command cmnd;
@@ -742,9 +745,9 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
+static int nvme_poll(struct blk_mq_llhw_ctx *llhw_ctx, unsigned int tag)
 {
-	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_queue *nvmeq = llhw_ctx->driver_data;
 
 	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
 		spin_lock_irq(&nvmeq->q_lock);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2cca9cf..0019213 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1876,9 +1876,10 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
 	blk_mq_complete_request(cmd->request, cmd->request->errors);
 }
 
-static int scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
+static int scsi_queue_rq(struct blk_mq_llhw_ctx	*llhw_ctx,
 			 const struct blk_mq_queue_data *bd)
 {
+	struct blk_mq_hw_ctx *hctx = blk_mq_to_hctx(llhw_ctx);
 	struct request *req = bd->rq;
 	struct request_queue *q = req->q;
 	struct scsi_device *sdev = q->queuedata;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 6c7ee56..2c3392b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -18,6 +18,12 @@ struct blk_mq_ctxmap {
 	struct blk_align_bitmap *map;
 };
 
+struct blk_mq_llhw_ctx {
+	int			index;
+	int			queue_id;
+	void			*driver_data;
+};
+
 struct blk_mq_hw_ctx {
 	struct {
 		spinlock_t		lock;
@@ -36,8 +42,6 @@ struct blk_mq_hw_ctx {
 	struct request_queue	*queue;
 	struct blk_flush_queue	*fq;
 
-	void			*driver_data;
-
 	struct blk_mq_ctxmap	ctx_map;
 
 	unsigned int		nr_ctx;
@@ -62,8 +66,19 @@ struct blk_mq_hw_ctx {
 
 	unsigned long		poll_invoked;
 	unsigned long		poll_success;
+
+	unsigned int		nr_llhw_ctx;
+	struct blk_mq_llhw_ctx	llhw_ctxs[0];
 };
 
+static inline
+struct blk_mq_hw_ctx *blk_mq_to_hctx(struct blk_mq_llhw_ctx *llhw_ctx)
+{
+	struct blk_mq_llhw_ctx *llhw_ctx_0 = llhw_ctx - llhw_ctx->index;
+
+	return (void *)llhw_ctx_0 - offsetof(struct blk_mq_hw_ctx, llhw_ctxs);
+}
+
 struct blk_mq_tag_set {
 	struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
@@ -87,11 +102,11 @@ struct blk_mq_queue_data {
 	bool last;
 };
 
-typedef int (queue_rq_fn)(struct blk_mq_hw_ctx *, const struct blk_mq_queue_data *);
+typedef int (queue_rq_fn)(struct blk_mq_llhw_ctx *, const struct blk_mq_queue_data *);
 typedef struct blk_mq_hw_ctx *(map_queue_fn)(struct request_queue *, const int);
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
-typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
-typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef int (init_hctx_fn)(struct blk_mq_llhw_ctx *, void *);
+typedef void (exit_hctx_fn)(struct blk_mq_llhw_ctx *);
 typedef int (init_request_fn)(void *, struct request *, unsigned int,
 		unsigned int, unsigned int);
 typedef void (exit_request_fn)(void *, struct request *, unsigned int,
@@ -101,7 +116,7 @@ typedef int (reinit_request_fn)(void *, struct request *);
 typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
 typedef void (busy_tag_iter_fn)(struct request *, void *, bool);
-typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef int (poll_fn)(struct blk_mq_llhw_ctx *, unsigned int);
 
 
 struct blk_mq_ops {
-- 
1.8.3.1
