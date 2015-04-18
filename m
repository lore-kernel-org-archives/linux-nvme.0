From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 18 Apr 2015 13:11:11 -0700
Subject: [PATCH] NVMe: allow discard timeouts to be configurable
In-Reply-To: <20150417213148.GA22587@kernel.dk>
References: <20150417213148.GA22587@kernel.dk>
Message-ID: <20150418201111.GA20311@infradead.org>

>  static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
>  				nvme_completion_fn handler)
>  {
> +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> +
>  	cmd->fn = handler;
>  	cmd->ctx = ctx;
>  	cmd->aborted = 0;
> -	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
> +
> +	if (rq->cmd_flags & REQ_DISCARD)
> +		rq->timeout = nvme_discard_timeout * HZ;
> +

Can you move this to the discard-specific branch of nvme_queue_rq
please?
