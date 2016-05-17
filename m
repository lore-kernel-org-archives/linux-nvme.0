From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 May 2016 11:23:59 -0400
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <20160517150511.GB14260@localhost.localdomain>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
 <1461619219-18144-2-git-send-email-mlin@kernel.org>
 <1463295520.5272.4.camel@kernel.org>
 <CAF1ivSaOMqLP=a9KgNy0Gbn9w_KkCzwbuY80e=sCJR+4Vg2kNw@mail.gmail.com>
 <20160517150511.GB14260@localhost.localdomain>
Message-ID: <20160517152359.GC14260@localhost.localdomain>

On Tue, May 17, 2016@11:05:11AM -0400, Keith Busch wrote:
> Today, though, the driver has newer checks so it doesn't crash when
> blk-mq submits a command the driver can't handle. If we change the nvme
> pci driver's nvme_queue_rq to stop hw queues before returning
> BLK_MQ_RQ_QUEUE_BUSY (scsi_queue_rq() in scsi_lib.c might be a good
> example), we could skip cancelling requeue work in "nvme_stop_queues()"
> if we're sure it won't race with the reset work's nvme_start_queues().

Untested patch below:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..13d3cf9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1552,7 +1552,6 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 		queue_flag_set(QUEUE_FLAG_STOPPED, ns->queue);
 		spin_unlock_irq(ns->queue->queue_lock);
 
-		blk_mq_cancel_requeue_work(ns->queue);
 		blk_mq_stop_hw_queues(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
@@ -1565,7 +1564,10 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		queue_flag_clear_unlocked(QUEUE_FLAG_STOPPED, ns->queue);
+		spin_lock_irq(ns->queue->queue_lock);
+		queue_flag_clear(QUEUE_FLAG_STOPPED, ns->queue);
+		spin_unlock_irq(ns->queue->queue_lock);
+
 		blk_mq_start_stopped_hw_queues(ns->queue, true);
 		blk_mq_kick_requeue_list(ns->queue);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4fd733f..b65d7d6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -690,6 +690,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	spin_unlock_irq(&nvmeq->q_lock);
 	return BLK_MQ_RQ_QUEUE_OK;
 out:
+	if (ret == BLK_MQ_RQ_QUEUE_BUSY) {
+		spin_lock_irq(ns->queue->queue_lock);
+		if (!blk_queue_stopped(req->q))
+			blk_mq_stop_hw_queues(ns->queue);
+		spin_unlock_irq(ns->queue->queue_lock);
+	}
 	nvme_free_iod(dev, req);
 	return ret;
 }
--
