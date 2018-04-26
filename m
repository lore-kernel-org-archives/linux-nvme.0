From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 26 Apr 2018 23:07:56 +0800
Subject: [PATCH 1/2] nvme: pci: simplify timeout handling
In-Reply-To: <20180426123956.26039-2-ming.lei@redhat.com>
References: <20180426123956.26039-1-ming.lei@redhat.com>
 <20180426123956.26039-2-ming.lei@redhat.com>
Message-ID: <b8dd2c24-a011-7e66-feca-502b0a6b10c0@oracle.com>

Hi Ming

Thanks for your wonderful solution. :)

On 04/26/2018 08:39 PM, Ming Lei wrote:
> +/*
> + * This one is called after queues are quiesced, and no in-fligh timeout
> + * and nvme interrupt handling.
> + */
> +static void nvme_pci_cancel_request(struct request *req, void *data,
> +		bool reserved)
> +{
> +	/* make sure timed-out requests are covered too */
> +	if (req->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) {
> +		req->aborted_gstate = 0;
> +		req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
> +	}
> +
> +	nvme_cancel_request(req, data, reserved);
> +}
> +
>  static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  {
>  	int i;
> @@ -2223,10 +2316,17 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
>  		nvme_suspend_queue(&dev->queues[i]);
>  
> +	/*
> +	 * safe to sync timeout after queues are quiesced, then all
> +	 * requests(include the time-out ones) will be canceled.
> +	 */
> +	nvme_sync_queues(&dev->ctrl);
> +	blk_sync_queue(dev->ctrl.admin_q);
> +
Looks like blk_sync_queue cannot drain all the timeout work.

blk_sync_queue
  -> del_timer_sync          
                          blk_mq_timeout_work
                            -> mod_timer
  -> cancel_work_sync
the timeout work may come back again.
we may need to force all the in-flight requests to be timed out with blk_abort_request

>  	nvme_pci_disable(dev);

the interrupt will not come, but there maybe running one.
a synchronize_sched() here ?

Thanks
Jianchao
>  
> -	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
> -	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
> +	blk_mq_tagset_busy_iter(&dev->tagset, nvme_pci_cancel_request, &dev->ctrl);
> +	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_pci_cancel_request, &dev->ctrl);
