From: keith.busch@intel.com (Keith Busch)
Date: Wed, 23 Sep 2015 23:16:06 +0000 (UTC)
Subject: [PATCH 2/7] nvme: switch AEN processing to use
 blk_execute_rq_nowait
In-Reply-To: <1442860853-26447-3-git-send-email-hch@lst.de>
References: <1442860853-26447-1-git-send-email-hch@lst.de>
 <1442860853-26447-3-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1509232128470.23840@localhost.lm.intel.com>

On Mon, 21 Sep 2015, Christoph Hellwig wrote:
> +static int nvme_submit_aen(struct nvme_dev *dev)
> +{
> +	struct nvme_command c;
>
> 	memset(&c, 0, sizeof(c));
> 	c.common.opcode = nvme_admin_async_event;
> -	c.common.command_id = req->tag;
>
> -	blk_mq_free_request(req);
> -	__nvme_submit_cmd(nvmeq, &c);
> -	return 0;
> +	return nvme_submit_async_cmd(dev->admin_q, &c, ULONG_MAX, GFP_ATOMIC,
> +			true, aen_endio, NULL);
> }

AEN needs to release the request immediately. That's why it uses
a "reserved" tag because it is tracked by the driver instead of
the block layer: there is no guarantee the controller will ever
return it, which deadlocks blk-mq's hot cpu notification. See
1efccc9ddb98fd533169669160201b027562af7e for details.

Other than that, love the rest of the series.
