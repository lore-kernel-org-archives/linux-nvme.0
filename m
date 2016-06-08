From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Jun 2016 10:43:54 -0400
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <5757FEAF.5000404@lightbits.io>
References: <20160523105807.GC26331@infradead.org>
 <20160523134116.GA17208@localhost.localdomain>
 <20160523143631.GA28107@infradead.org>
 <20160523145556.GB17208@localhost.localdomain>
 <CAF1ivSbWrkNUu0HgDdvev6yOV9bSbOjkDQ8mtS0VSq=k9SEqng@mail.gmail.com>
 <20160524195921.GB24347@localhost.localdomain>
 <20160525081842.GA22766@infradead.org>
 <20160525175736.GB28668@localhost.localdomain>
 <20160527074020.GB950@infradead.org>
 <5757FEAF.5000404@lightbits.io>
Message-ID: <20160608144354.GB1430@localhost.localdomain>

On Wed, Jun 08, 2016@02:17:03PM +0300, Sagi Grimberg wrote:
> I really don't like this patch (sorry), having queue_rq being aware
> of what requeue_work *might* do looks backwards to me...
> now I'm thinking what I need to do in fabrics rdma and loop. This is
> why I didn't like the NVME_NS_DEAD check in queue_rq as well.

I agree, but I didn't find another card we can play to get the right
sequence.
 
> I'd really prefer to not propagate this backwards logic into
> other transports...
> 
> But, if this is mandatory for now, does this patch makes sense for
> rdma?

Looks right to me.


> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 938e7d55c4a8..60aaa1b4d021 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1450,6 +1450,12 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx
> *hctx,
>                 goto err;
>         }
> 
> +       /* XXX: This is really not the correct layer to check this */
> +       if (ns && !test_bit(NVME_NS_DEAD, &ns->flags)) {
> +               ret = -EAGAIN;
> +               goto err;
> +       }
> +
>         ib_dma_sync_single_for_device(dev, sqe->dma,
>                         sizeof(struct nvme_command), DMA_TO_DEVICE);
> 
> @@ -1464,8 +1470,14 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx
> *hctx,
> 
>         return BLK_MQ_RQ_QUEUE_OK;
>  err:
> -       return (ret == -ENOMEM || ret == -EAGAIN) ?
> -               BLK_MQ_RQ_QUEUE_BUSY : BLK_MQ_RQ_QUEUE_ERROR;
> +       if (ret == -ENOMEM || ret == -EAGAIN) {
> +               spin_lock_irq(ns->queue->queue_lock);
> +               if (blk_queue_stopped(rq->q))
> +                       blk_mq_stop_hw_queues(ns->queue);
> +               spin_unlock_irq(ns->queue->queue_lock);
> +               return BLK_MQ_RQ_QUEUE_BUSY;
> +       }
> +       return BLK_MQ_RQ_QUEUE_ERROR;
>  }
> 
>  static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
> -- 
