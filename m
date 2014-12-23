From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Dec 2014 21:10:31 +0000 (UTC)
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <5499AC69.2010706@fb.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
 <549860A9.7060106@fb.com> <54987A43.9000807@fb.com>
 <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>
 <alpine.LNX.2.00.1412222303100.4026@localhost.lm.intel.com>
 <5499AB17.6060805@fb.com> <5499AC69.2010706@fb.com>
Message-ID: <alpine.LNX.2.00.1412232024530.4026@localhost.lm.intel.com>

On Tue, 23 Dec 2014, Jens Axboe wrote:
> On 12/23/2014 10:49 AM, Jens Axboe wrote:
>> So that's actually a case where having the queues auto-started on
>> requeue run is harmful, since we should be able to handle this situation
>> by stopping queues, requeueing, and then having a helper to eventually
>> abort pending requeued work, if we have to. But if you simply requeue
>> them and defer kicking the requeue list it might work. At that point
>> you'd either kick the requeues (and hence start processing them) if
>> things went well on the reset, or we could have some
>> blk_mq_abort_requeues() helper that'd kill them with -EIO instead. Would
>> that work for you?
>
> Something like this.

Ok, this works when used with the driver update below. I tested disabling
the link and issuing a PCI-e FLR, so both recovery failure and success
cases covered.

There are still a couple problems that look possible, but I haven't been
able to make either happen yet. It looks like we could lose requests in
either ctx->rq_list or hctx->dispatch when recovery fails. It also looks
possible the driver's .queue_rq can still be called during controller
reset.

---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 94f5578..030fdc2 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -106,7 +106,7 @@ struct nvme_queue {
  	dma_addr_t cq_dma_addr;
  	u32 __iomem *q_db;
  	u16 q_depth;
-	u16 cq_vector;
+	s16 cq_vector;
  	u16 sq_head;
  	u16 sq_tail;
  	u16 cq_head;
@@ -432,7 +432,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
  		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
  		    && (jiffies - req->start_time) < req->timeout) {
  			blk_mq_requeue_request(req);
-			blk_mq_kick_requeue_list(req->q);
+			if (!blk_queue_stopped(req->q))
+				blk_mq_kick_requeue_list(req->q);
  			return;
  		}
  		req->errors = nvme_error_status(status);
@@ -2398,8 +2399,10 @@ static void nvme_unfreeze_queues(struct nvme_dev *dev)
  {
  	struct nvme_ns *ns;

-	list_for_each_entry(ns, &dev->namespaces, list)
+	list_for_each_entry(ns, &dev->namespaces, list) {
  		blk_mq_unfreeze_queue(ns->queue);
+		blk_mq_kick_requeue_list(ns->queue);
+	}
  }

  static void nvme_dev_shutdown(struct nvme_dev *dev)
@@ -2438,6 +2441,7 @@ static void nvme_dev_remove(struct nvme_dev *dev)
  	struct nvme_ns *ns;

  	list_for_each_entry(ns, &dev->namespaces, list) {
+		blk_mq_abort_requeue_list(ns->queue);
  		if (ns->disk->flags & GENHD_FL_UP)
  			del_gendisk(ns->disk);
  		if (!blk_queue_dying(ns->queue))
--
