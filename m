From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 29 Nov 2018 15:03:59 +0800
Subject: [PATCH 5/7] ataflop: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181128133538.20329-6-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-6-axboe@kernel.dk>
Message-ID: <20181129070357.GB27186@ming.t460p>

On Wed, Nov 28, 2018@06:35:36AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.
> 
> Reviewed-by: Omar Sandoval <osandov at fb.com>
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>  drivers/block/ataflop.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> index f88b4c26d422..a0c6745b0034 100644
> --- a/drivers/block/ataflop.c
> +++ b/drivers/block/ataflop.c
> @@ -1471,6 +1471,15 @@ static void setup_req_params( int drive )
>  			ReqTrack, ReqSector, (unsigned long)ReqData ));
>  }
>  
> +static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	spin_lock_irq(&ataflop_lock);
> +	atari_disable_irq(IRQ_MFP_FDC);
> +	finish_fdc();
> +	atari_enable_irq(IRQ_MFP_FDC);
> +	spin_unlock_irq(&ataflop_lock);
> +}
> +
>  static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
>  				     const struct blk_mq_queue_data *bd)
>  {
> @@ -1947,6 +1956,7 @@ static const struct block_device_operations floppy_fops = {
>  
>  static const struct blk_mq_ops ataflop_mq_ops = {
>  	.queue_rq = ataflop_queue_rq,
> +	.commit_rqs = ataflop_commit_rqs,
>  };
>  
>  static struct kobject *floppy_find(dev_t dev, int *part, void *data)
> -- 
> 2.17.1
> 

Reviewed-by: Ming Lei <ming.lei at redhat.com>

thanks,
Ming
