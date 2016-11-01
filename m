From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 1 Nov 2016 16:32:57 +0200
Subject: [PATCH, resend2] nvme-rdma: reject non-connect commands before
 the queue is live
In-Reply-To: <1478007890-18934-1-git-send-email-hch@lst.de>
References: <1478007890-18934-1-git-send-email-hch@lst.de>
Message-ID: <deb127eb-c468-79bf-e602-ba56932066b9@grimberg.me>


> @@ -1394,10 +1398,18 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>
>  	WARN_ON_ONCE(rq->tag < 0);
>
> +	c = (struct nvme_command *)rq->cmd;
> +	if (!test_bit(NVME_RDMA_Q_LIVE, &queue->flags) &&
> +	    rq->cmd_type != REQ_TYPE_DRV_PRIV &&
> +	    (c->common.opcode != nvme_fabrics_command ||
> +	     c->fabrics.fctype != nvme_fabrics_type_connect))
> +		return BLK_MQ_RQ_QUEUE_BUSY;
> +

Can we hide this mess in a static inline nvme_rdma_chk_ready()?
