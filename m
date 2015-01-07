From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Jan 2015 03:08:12 +0000 (UTC)
Subject: [PATCHv2 08/10] NVMe: Start and stop h/w queues on reset
In-Reply-To: <1420599484-21582-9-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
 <1420599484-21582-9-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1501070303300.4026@localhost.lm.intel.com>

On Tue, 6 Jan 2015, Keith Busch wrote:
> @@ -433,7 +433,10 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
> 		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
> 		    && (jiffies - req->start_time) < req->timeout) {
> 			blk_mq_requeue_request(req);
> -			blk_mq_kick_requeue_list(req->q);
> +			spin_lock(req->q->queue_lock);
> +			if (!blk_queue_stopped(req->q))
> +				blk_mq_kick_requeue_list(req->q);
> +			spin_unlock(req->q->queue_lock);
> 			return;
> 		}

Ugh, been at this too long and screwed up my hand-merge when
squashing and splitting into managable patches. The above should use
irq save/restore locks.

@@ -433,7 +433,10 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
   		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
   		    && (jiffies - req->start_time) < req->timeout) {
+ 			int flags;
   			blk_mq_requeue_request(req);
-			blk_mq_kick_requeue_list(req->q);
+			spin_lock_irqsave(req->q->queue_lock, flags);
+			if (!blk_queue_stopped(req->q))
+				blk_mq_kick_requeue_list(req->q);
+			spin_unlock_irqrestore(req->q->queue_lock, flags);
  			return;
  		}
