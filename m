From: sagi@lightbits.io (Sagi Grimberg)
Date: Wed, 8 Jun 2016 14:17:03 +0300
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <20160527074020.GB950@infradead.org>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
 <20160523105807.GC26331@infradead.org>
 <20160523134116.GA17208@localhost.localdomain>
 <20160523143631.GA28107@infradead.org>
 <20160523145556.GB17208@localhost.localdomain>
 <CAF1ivSbWrkNUu0HgDdvev6yOV9bSbOjkDQ8mtS0VSq=k9SEqng@mail.gmail.com>
 <20160524195921.GB24347@localhost.localdomain>
 <20160525081842.GA22766@infradead.org>
 <20160525175736.GB28668@localhost.localdomain>
 <20160527074020.GB950@infradead.org>
Message-ID: <5757FEAF.5000404@lightbits.io>


>>>> AFAICT, the patch is fine as-is if Christoph is okay with it.
>>>
>>> I still don't why we need to delay the call to blk_mq_stop_hw_queues
>>> to ->queue_rq.
>>
>> Eh? It's still stopped in the same place as always, so it's not
>> delayed. We just call it again from queue_rq because requeue_work can
>> start h/w queues on its own. This is very similar to scsi's queue_rq
>> in scsi_lib.c.
>
> The rationale in SCSI is that we stop the queue when we are above
> the hosts or targets queuing limit, and only I/O ocmpletions will
> wake it up again.  Kicking of the sotpped queues in blk_mq_requeue_work
> is SCSI specific behavior that leaked into the core, and it's my fault..
>
> Well' let's get the fix in as-is for now, but I really need to sort
> this out properly, so maybe add some comments.

I really don't like this patch (sorry), having queue_rq being aware
of what requeue_work *might* do looks backwards to me...
now I'm thinking what I need to do in fabrics rdma and loop. This is
why I didn't like the NVME_NS_DEAD check in queue_rq as well.

I'd really prefer to not propagate this backwards logic into
other transports...

But, if this is mandatory for now, does this patch makes sense for
rdma?
-- 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 938e7d55c4a8..60aaa1b4d021 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1450,6 +1450,12 @@ static int nvme_rdma_queue_rq(struct 
blk_mq_hw_ctx *hctx,
                 goto err;
         }

+       /* XXX: This is really not the correct layer to check this */
+       if (ns && !test_bit(NVME_NS_DEAD, &ns->flags)) {
+               ret = -EAGAIN;
+               goto err;
+       }
+
         ib_dma_sync_single_for_device(dev, sqe->dma,
                         sizeof(struct nvme_command), DMA_TO_DEVICE);

@@ -1464,8 +1470,14 @@ static int nvme_rdma_queue_rq(struct 
blk_mq_hw_ctx *hctx,

         return BLK_MQ_RQ_QUEUE_OK;
  err:
-       return (ret == -ENOMEM || ret == -EAGAIN) ?
-               BLK_MQ_RQ_QUEUE_BUSY : BLK_MQ_RQ_QUEUE_ERROR;
+       if (ret == -ENOMEM || ret == -EAGAIN) {
+               spin_lock_irq(ns->queue->queue_lock);
+               if (blk_queue_stopped(rq->q))
+                       blk_mq_stop_hw_queues(ns->queue);
+               spin_unlock_irq(ns->queue->queue_lock);
+               return BLK_MQ_RQ_QUEUE_BUSY;
+       }
+       return BLK_MQ_RQ_QUEUE_ERROR;
  }

  static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
-- 
