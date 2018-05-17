From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 17 May 2018 09:32:05 -0600
Subject: [PATCH 1/3] nvme: remove ->cq_vector == -1 check in
 nvme_queue_rq()
In-Reply-To: <1526569337-3489-2-git-send-email-axboe@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
 <1526569337-3489-2-git-send-email-axboe@kernel.dk>
Message-ID: <20180517153204.GA23555@localhost.localdomain>

On Thu, May 17, 2018@09:02:15AM -0600, Jens Axboe wrote:
> We only clear this after calling nvme_suspend_queue(), which must
> have called nvme_stop_queues() first. The latter ensures that no
> more IO is queued, or in progress of being queued, against this
> hardware queue.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>  drivers/nvme/host/pci.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5277afc6e7b5..4ed3583ad3bc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -887,11 +887,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	blk_mq_start_request(req);
>  
>  	spin_lock_irq(&nvmeq->q_lock);
> -	if (unlikely(nvmeq->cq_vector < 0)) {
> -		ret = BLK_STS_IOERR;
> -		spin_unlock_irq(&nvmeq->q_lock);
> -		goto out_cleanup_iod;
> -	}
>  	__nvme_submit_cmd(nvmeq, &cmnd);
>  	spin_unlock_irq(&nvmeq->q_lock);
>  	return BLK_STS_OK;

Unfortunatley we are still relying on this to drain entered requests on
a dying queue: we restart them to flush to out requests to complete with
error. :(

There's probably a better way to handle this.
