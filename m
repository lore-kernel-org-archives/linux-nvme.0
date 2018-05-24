From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 May 2018 22:45:06 +0200
Subject: [PATCHv3 9/9] nvme-pci: Don't wait for HMB completion on shutdown
In-Reply-To: <20180524203500.14081-10-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-10-keith.busch@intel.com>
Message-ID: <20180524204506.GA29048@lst.de>

On Thu, May 24, 2018@02:35:00PM -0600, Keith Busch wrote:
> 
> An nvme controller reset can't depend on the timeout handling to
> complete timed out commands since we're already trying to disable the
> controller. The HMB disabling is the only command in this path that was
> not handling its own timeout, so this patch fixes that by putting a time
> limit on how long it will wait for completion.

What does 'did not handle its own timeout' mean?

> +static void nvme_set_host_mem_end_io(struct request *rq, blk_status_t sts)
> +{
> +	struct completion *wait = rq->end_io_data;
> +
> +	rq->end_io_data = NULL;
> +	blk_mq_free_request(rq);
> +	complete(wait);
> +}
> +
> +/*
> + * Use 'wait' when sending this command in a context can't complete blocks the
> + * reset handler, as required for device shutdown.
> + */
> +static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits,
> +			     struct completion *wait)
>  {
>  	u64 dma_addr = dev->host_mem_descs_dma;
> +	struct request_queue *q = dev->ctrl.admin_q;
> +	struct request *req;
>  	struct nvme_command c;
>  	int ret;
>  
> @@ -1780,7 +1796,19 @@ static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
>  	c.features.dword14	= cpu_to_le32(upper_32_bits(dma_addr));
>  	c.features.dword15	= cpu_to_le32(dev->nr_host_mem_descs);
>  
> -	ret = nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0);
> +	if (!wait) {
> +		ret = nvme_submit_sync_cmd(q, &c, NULL, 0);
> +	} else {
> +		req = nvme_alloc_request(q, &c, 0, NVME_QID_ANY);
> +		if (IS_ERR(req))
> +			return PTR_ERR(req);
> +		req->timeout = ADMIN_TIMEOUT;
> +		req->end_io_data = wait;
> +		blk_execute_rq_nowait(q, NULL, req, false,
> +				      nvme_set_host_mem_end_io);
> +		ret = wait_for_completion_io_timeout(wait, ADMIN_TIMEOUT);
> +	}
> +

None of this is intimately related to the HMB code.  If we really have
to we could handle this either in __nvme_submit_sync_cmd or all the
way down in blk_execute_rq, but why doesn't the block layer timeout
code kill the command once we've reached the timeout?

Also if we really need to reset the controller submitting any command
just doesn't seem very helpful.  We might as well just skip trying
to disable the HMB, as the controller needs to come up in a clean
state anyway.
