From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 24 May 2018 09:39:50 -0600
Subject: [PATCH V6 02/11] nvme: pci: cover timeout for admin commands
 running in EH
In-Reply-To: <20180516040313.13596-3-ming.lei@redhat.com>
References: <20180516040313.13596-1-ming.lei@redhat.com>
 <20180516040313.13596-3-ming.lei@redhat.com>
Message-ID: <20180524153949.GK11037@localhost.localdomain>

On Wed, May 16, 2018@12:03:04PM +0800, Ming Lei wrote:
> +static void nvme_set_host_mem_end_io(struct request *rq, blk_status_t sts)
> +{
> +	struct completion *waiting = rq->end_io_data;
> +
> +	rq->end_io_data = NULL;
> +	blk_mq_free_request(rq);
> +
> +	/*
> +	 * complete last, if this is a stack request the process (and thus
> +	 * the rq pointer) could be invalid right after this complete()
> +	 */
> +	complete(waiting);
> +}
> +
> +/*
> + * This function can only be used inside nvme_dev_disable() when timeout
> + * may not work, then this function has to cover the timeout by itself.
> + *
> + * When wait_for_completion_io_timeout() returns 0 and timeout happens,
> + * this request will be completed after controller is shutdown.
> + */
> +static int nvme_set_host_mem_timeout(struct nvme_dev *dev, u32 bits)
> +{
> +	DECLARE_COMPLETION_ONSTACK(wait);
> +	struct nvme_command c;
> +	struct request_queue *q = dev->ctrl.admin_q;
> +	struct request *req;
> +	int ret;
> +
> +	nvme_init_set_host_mem_cmd(dev, &c, bits);
> +
> +	req = nvme_alloc_request(q, &c, 0, NVME_QID_ANY);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	req->timeout = ADMIN_TIMEOUT;
> +	req->end_io_data = &wait;
> +
> +	blk_execute_rq_nowait(q, NULL, req, false,
> +			nvme_set_host_mem_end_io);
> +	ret = wait_for_completion_io_timeout(&wait, ADMIN_TIMEOUT);
> +	if (ret > 0) {
> +		if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
> +			ret = -EINTR;
> +		else
> +			ret = nvme_req(req)->status;
> +	} else
> +		ret = -EINTR;
> +
> +	return ret;
> +}

This function doesn't need to return anything at all. The caller doesn't
care about the success in order to decide what to do next.

Now let's say it does time out. The command will be be completed later
through nvme_cancel_request, but your completion callback will reference
a now invalid stack variable.

>  static void nvme_free_host_mem(struct nvme_dev *dev)
>  {
>  	int i;
> @@ -2225,7 +2284,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  		 * but I'd rather be safe than sorry..
>  		 */
>  		if (dev->host_mem_descs)
> -			nvme_set_host_mem(dev, 0);
> +			nvme_set_host_mem_timeout(dev, 0);
>  		nvme_disable_io_queues(dev);
>  		nvme_disable_admin_queue(dev, shutdown);
>  	}
