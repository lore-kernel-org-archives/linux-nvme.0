From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Nov 2015 00:55:37 -0800
Subject: [PATCH] NVMe: Shutdown fixes
In-Reply-To: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
References: <1448407814-12544-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151125085537.GA19066@infradead.org>

> +static inline void nvme_end_req(struct request *req, int error)
> +{
> +	/*
> +	 * The request may already be marked "complete" by blk-mq if
> +	 * completion occurs during a timeout. We set req->errors
> +	 * before telling blk-mq in case this is the target request
> +	 * of a timeout handler. This is safe since this driver never
> +	 * completes the same command twice.
> +	 */
> +	req->errors = error;
> +	blk_mq_complete_request(req, req->errors);


I don't think overwriting req->errors on an already completed request
is a good idea - it's what we used to earlier, but I specificly changed
the blk_mq_complete_request so that we don't do that.  Can you explain
when you want to overwrite the value exactly and why?

>  	/*
> -	 * Just return an error to reset_work if we're already called from
> -	 * probe context.  We don't worry about request / tag reuse as
> -	 * reset_work will immeditalely unwind and remove the controller
> -	 * once we fail a command.
> +	 * Shutdown immediately if controller times out while starting. The
> +	 * reset work will see the pci device disabled when it gets the forced
> +	 * cancellation error. All outstanding requests are completed on
> +	 * shutdown, so we return BLK_EH_HANDLED.
>  	 */
>  	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
> -		req->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR;
> +		dev_warn(dev->dev,
> +				"I/O %d QID %d timeout, disable controller\n",
> +				 req->tag, nvmeq->qid);
> +		nvme_dev_shutdown(dev);
>  		return BLK_EH_HANDLED;

So here you return BLK_EH_HANDLED without setting req->errors, which
sounds like it might be related to the above issue.

>  	/*
> +	 * Shutdown controller if the command was already aborted once
> +	 * before and still hasn't been returned to the driver, or if this
> +	 * is * the admin queue, and then schedule restart.

little formatting error with the '* ' after the is above.

>  	 */
>  	if (!nvmeq->qid || iod->aborted) {
> +		dev_warn(dev->dev, "I/O %d QID %d timeout, reset controller\n",
>  				 req->tag, nvmeq->qid);
> +		nvme_dev_shutdown(dev);
> +		queue_work(nvme_workq, &dev->reset_work);

So now we will get a call to nvme_dev_shutdown for every I/O that times
out.  I'll see how my controller handles the discard of death with that.

>  
>  		/*
> +		 * Mark the request as handled, since the inline shutdown
> +		 * forces all outstanding requests to complete.
>  		 */
> -		return BLK_EH_QUIESCED;
> +		return BLK_EH_HANDLED;

Again we're not setting req->errors here.

> -	if (status > 0) {
> +	if (status) {
>  		dev_err(dev->dev, "Could not set queue count (%d)\n", status);
>  		return 0;
>  	}
> @@ -2023,6 +2038,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
>  
>  	nvme_dev_list_remove(dev);
>  
> +	mutex_lock(&dev->shutdown_lock);

Shoudn't we also have a state check that skips all the work here if
the controller has already been shut down?

> +
> +	/*
> +	 * The pci device will be disabled if a timeout occurs while setting up
> +	 * IO queues, but return 0 for "result", so we have to check both.
> +	 */
> +	if (result || !pci_is_enabled(to_pci_dev(dev->dev)))
>  		goto free_tags;

I don't think we should return zero here in that case - that seems to
be a bug in setting up req->errrors in the timeout handler.
