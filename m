From: hch@lst.de (Christoph Hellwig)
Date: Thu, 11 Aug 2016 17:21:54 +0200
Subject: [PATCH RFC 2/4] nvme-rdma: fix sqsize/hsqsize/hrqsize per spec
In-Reply-To: <1470888438-823-3-git-send-email-james_p_freyensee@linux.intel.com>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470888438-823-3-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <20160811152154.GB19738@lst.de>

I think having different notations for hsqsize vs hrqsize is highly
confusing, and I've asked for a clarification of the hrqsize definition
which is ambious at it's best at the moment.  But independent of
that a few more comments:

> @@ -1907,7 +1920,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>  	spin_lock_init(&ctrl->lock);
>  
>  	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
> -	ctrl->ctrl.sqsize = opts->queue_size;
> +	ctrl->ctrl.sqsize = opts->queue_size-1;

We should keep our own sqsize in normal notation in core, and just
convert to strange notations on the wire.  Especially as we use it
to driver all the resource allocation as Sagi said.


> +	if (priv.qid == 0) {
> +		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize);
> +		priv.hrqsize = cpu_to_le16(queue->ctrl->ctrl.admin_sqsize+1);

Based on that priv.hsqsize should have a - 1 here  and hrqsize should
be kept as-is.  Also always use spaces around the operators.

And while we're at it - the fix to use the separate AQ values should
go into the first patch.
