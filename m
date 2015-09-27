From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:50 +0200
Subject: [PATCH 02/10] blk-mq: fix racy updates of rq->errors
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-3-git-send-email-hch@lst.de>

blk_mq_complete_request may be a no-op if the request has already
been completed by others means (e.g. a timeout or cancellation), but
currently drivers have to set rq->errors before calling
blk_mq_complete_request, which might leave us with the wrong error value.

Add an error parameter to blk_mq_complete_request so that we can
defer setting rq->errors until we known we won the race to complete the
request.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/blk-mq.c               | 12 ++++++------
 drivers/block/loop.c         | 11 +++++------
 drivers/block/null_blk.c     |  2 +-
 drivers/block/nvme-core.c    | 16 +++++++---------
 drivers/block/virtio_blk.c   |  2 +-
 drivers/block/xen-blkfront.c | 19 ++++++++++---------
 drivers/scsi/scsi_lib.c      |  2 +-
 include/linux/blk-mq.h       |  2 +-
 8 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2fd7283..698b735 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -393,14 +393,16 @@ void __blk_mq_complete_request(struct request *rq)
  *	Ends all I/O on a request. It does not handle partial completions.
  *	The actual completion happens out-of-order, through a IPI handler.
  **/
-void blk_mq_complete_request(struct request *rq)
+void blk_mq_complete_request(struct request *rq, int error)
 {
 	struct request_queue *q = rq->q;
 
 	if (unlikely(blk_should_fake_timeout(q)))
 		return;
-	if (!blk_mark_rq_complete(rq))
+	if (!blk_mark_rq_complete(rq)) {	
+		rq->errors = error;
 		__blk_mq_complete_request(rq);
+	}
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -616,10 +618,8 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		 * If a request wasn't started before the queue was
 		 * marked dying, kill it here or it'll go unnoticed.
 		 */
-		if (unlikely(blk_queue_dying(rq->q))) {
-			rq->errors = -EIO;
-			blk_mq_complete_request(rq);
-		}
+		if (unlikely(blk_queue_dying(rq->q)))
+			blk_mq_complete_request(rq, -EIO);
 		return;
 	}
 	if (rq->cmd_flags & REQ_NO_TIMEOUT)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f9889b6..674f800 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1486,17 +1486,16 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
 {
 	const bool write = cmd->rq->cmd_flags & REQ_WRITE;
 	struct loop_device *lo = cmd->rq->q->queuedata;
-	int ret = -EIO;
+	int ret = 0;
 
-	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY))
+	if (write && (lo->lo_flags & LO_FLAGS_READ_ONLY)) {
+		ret = -EIO;
 		goto failed;
+	}
 
 	ret = do_req_filebacked(lo, cmd->rq);
-
  failed:
-	if (ret)
-		cmd->rq->errors = -EIO;
-	blk_mq_complete_request(cmd->rq);
+	blk_mq_complete_request(cmd->rq, ret ? -EIO : 0);
 }
 
 static void loop_queue_write_work(struct work_struct *work)
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index a295b98..1c9e4fe 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -289,7 +289,7 @@ static inline void null_handle_cmd(struct nullb_cmd *cmd)
 	case NULL_IRQ_SOFTIRQ:
 		switch (queue_mode)  {
 		case NULL_Q_MQ:
-			blk_mq_complete_request(cmd->rq);
+			blk_mq_complete_request(cmd->rq, cmd->rq->errors);
 			break;
 		case NULL_Q_RQ:
 			blk_complete_request(cmd->rq);
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b97fc3f..ebc3138 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -618,16 +618,15 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 			spin_unlock_irqrestore(req->q->queue_lock, flags);
 			return;
 		}
+
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
 			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
-				req->errors = -EINTR;
-			else
-				req->errors = status;
+				status = -EINTR;
 		} else {
-			req->errors = nvme_error_status(status);
+			status = nvme_error_status(status);
 		}
-	} else
-		req->errors = 0;
+	}
+
 	if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
 		u32 result = le32_to_cpup(&cqe->result);
 		req->special = (void *)(uintptr_t)result;
@@ -650,7 +649,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 	}
 	nvme_free_iod(nvmeq->dev, iod);
 
-	blk_mq_complete_request(req);
+	blk_mq_complete_request(req, status);
 }
 
 /* length is in bytes.  gfp flags indicates whether we may sleep. */
@@ -863,8 +862,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ns && ns->ms && !blk_integrity_rq(req)) {
 		if (!(ns->pi_type && ns->ms == 8) &&
 					req->cmd_type != REQ_TYPE_DRV_PRIV) {
-			req->errors = -EFAULT;
-			blk_mq_complete_request(req);
+			blk_mq_complete_request(req, -EFAULT);
 			return BLK_MQ_RQ_QUEUE_OK;
 		}
 	}
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index e93899c..6ca3549 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -144,7 +144,7 @@ static void virtblk_done(struct virtqueue *vq)
 	do {
 		virtqueue_disable_cb(vq);
 		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
-			blk_mq_complete_request(vbr->req);
+			blk_mq_complete_request(vbr->req, vbr->req->errors);
 			req_done = true;
 		}
 		if (unlikely(virtqueue_is_broken(vq)))
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 0823a96..6111708 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1142,6 +1142,7 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	RING_IDX i, rp;
 	unsigned long flags;
 	struct blkfront_info *info = (struct blkfront_info *)dev_id;
+	int error;
 
 	spin_lock_irqsave(&info->io_lock, flags);
 
@@ -1182,37 +1183,37 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 			continue;
 		}
 
-		req->errors = (bret->status == BLKIF_RSP_OKAY) ? 0 : -EIO;
+		error = (bret->status == BLKIF_RSP_OKAY) ? 0 : -EIO;
 		switch (bret->operation) {
 		case BLKIF_OP_DISCARD:
 			if (unlikely(bret->status == BLKIF_RSP_EOPNOTSUPP)) {
 				struct request_queue *rq = info->rq;
 				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
 					   info->gd->disk_name, op_name(bret->operation));
-				req->errors = -EOPNOTSUPP;
+				error = -EOPNOTSUPP;
 				info->feature_discard = 0;
 				info->feature_secdiscard = 0;
 				queue_flag_clear(QUEUE_FLAG_DISCARD, rq);
 				queue_flag_clear(QUEUE_FLAG_SECDISCARD, rq);
 			}
-			blk_mq_complete_request(req);
+			blk_mq_complete_request(req, error);
 			break;
 		case BLKIF_OP_FLUSH_DISKCACHE:
 		case BLKIF_OP_WRITE_BARRIER:
 			if (unlikely(bret->status == BLKIF_RSP_EOPNOTSUPP)) {
 				printk(KERN_WARNING "blkfront: %s: %s op failed\n",
 				       info->gd->disk_name, op_name(bret->operation));
-				req->errors = -EOPNOTSUPP;
+				error = -EOPNOTSUPP;
 			}
 			if (unlikely(bret->status == BLKIF_RSP_ERROR &&
 				     info->shadow[id].req.u.rw.nr_segments == 0)) {
 				printk(KERN_WARNING "blkfront: %s: empty %s op failed\n",
 				       info->gd->disk_name, op_name(bret->operation));
-				req->errors = -EOPNOTSUPP;
+				error = -EOPNOTSUPP;
 			}
-			if (unlikely(req->errors)) {
-				if (req->errors == -EOPNOTSUPP)
-					req->errors = 0;
+			if (unlikely(error)) {
+				if (error == -EOPNOTSUPP)
+					error = 0;
 				info->feature_flush = 0;
 				xlvbd_flush(info);
 			}
@@ -1223,7 +1224,7 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 				dev_dbg(&info->xbdev->dev, "Bad return from blkdev data "
 					"request: %x\n", bret->status);
 
-			blk_mq_complete_request(req);
+			blk_mq_complete_request(req, error);
 			break;
 		default:
 			BUG();
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index cbfc599..126a48c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1957,7 +1957,7 @@ static int scsi_mq_prep_fn(struct request *req)
 static void scsi_mq_done(struct scsi_cmnd *cmd)
 {
 	trace_scsi_dispatch_cmd_done(cmd);
-	blk_mq_complete_request(cmd->request);
+	blk_mq_complete_request(cmd->request, cmd->request->errors);
 }
 
 static int scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 37d1602..4b4577a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -215,7 +215,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
 void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_abort_requeue_list(struct request_queue *q);
-void blk_mq_complete_request(struct request *rq);
+void blk_mq_complete_request(struct request *rq, int error);
 
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-- 
1.9.1
