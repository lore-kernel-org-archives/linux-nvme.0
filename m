From: hch@lst.de (Christoph Hellwig)
Date: Tue, 27 Nov 2018 16:46:26 +0100
Subject: [PATCH] nvme: Implement Enhanced Command Retry
In-Reply-To: <20181127153710.6328-1-keith.busch@intel.com>
References: <20181127153710.6328-1-keith.busch@intel.com>
Message-ID: <20181127154626.GA26787@lst.de>

On Tue, Nov 27, 2018@08:37:10AM -0700, Keith Busch wrote:
>  		if (!blk_queue_dying(req->q)) {
> +			unsigned long delay = 0;
> +			struct nvme_ns *ns = req->q->queuedata;
> +			u16 crd = (nvme_req(req)->status & NVME_SC_CRD) >> 11;
> +
> +			if (crd && ns)
> +				delay = ns->ctrl->crdt[crd - 1] * 100;

Do we need bounce checking for crd here?

> +
>  			nvme_req(req)->retries++;
> -			blk_mq_requeue_request(req, true);
> +			blk_mq_requeue_request(req, false);
> +			blk_mq_delay_kick_requeue_list(req->q, delay);
>  			return;

I also think it would be nice to split out this code block into
a little nvme_retry_req ala nvme_failover_req.

Otherwise this looks sensible to me.
