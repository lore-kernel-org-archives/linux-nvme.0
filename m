From: osandov@osandov.com (Omar Sandoval)
Date: Tue, 27 Nov 2018 15:45:38 -0800
Subject: [PATCH 5/8] virtio_blk: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181126163556.5181-6-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-6-axboe@kernel.dk>
Message-ID: <20181127234538.GD846@vader>

On Mon, Nov 26, 2018@09:35:53AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.

Reviewed-by: Omar Sandoval <osandov at fb.com>

But also cc'd the virtio-blk maintainers.

> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> ---
>  drivers/block/virtio_blk.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6e869d05f91e..b49c57e77780 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -214,6 +214,20 @@ static void virtblk_done(struct virtqueue *vq)
>  	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
>  }
>  
> +static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	int qid = hctx->queue_num;
> +	bool kick;
> +
> +	spin_lock_irq(&vblk->vqs[qid].lock);
> +	kick = virtqueue_kick_prepare(vblk->vqs[qid].vq);
> +	spin_unlock_irq(&vblk->vqs[qid].lock);
> +
> +	if (kick)
> +		virtqueue_notify(vblk->vqs[qid].vq);
> +}
> +
>  static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>  			   const struct blk_mq_queue_data *bd)
>  {
> @@ -638,6 +652,7 @@ static void virtblk_initialize_rq(struct request *req)
>  
>  static const struct blk_mq_ops virtio_mq_ops = {
>  	.queue_rq	= virtio_queue_rq,
> +	.commit_rqs	= virtio_commit_rqs,
>  	.complete	= virtblk_request_done,
>  	.init_request	= virtblk_init_request,
>  #ifdef CONFIG_VIRTIO_BLK_SCSI
> -- 
> 2.17.1
> 
