From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 4 Jul 2017 16:41:01 +0800
Subject: [PATCH 7/8] virtio_blk: quiesce/unquiesce live IO when entering
 PM states
In-Reply-To: <1499154912-10420-8-git-send-email-sagi@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-8-git-send-email-sagi@grimberg.me>
Message-ID: <20170704084100.GH29053@ming.t460p>

On Tue, Jul 04, 2017@10:55:11AM +0300, Sagi Grimberg wrote:
> We must make sure that no requests are being queued before we iterate
> delete vqs. quiesce/unquiesce the request queue istead of start/stop
> hw queues.
> 
> Cc: Michael S. Tsirkin <mst at redhat.com>
> Cc: Jason Wang <jasowang at redhat.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/block/virtio_blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0297ad7c1452..4e02aa5fdac0 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -840,7 +840,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
>  
> -	blk_mq_stop_hw_queues(vblk->disk->queue);
> +	blk_mq_quiesce_queue(vblk->disk->queue);
>  
>  	vdev->config->del_vqs(vdev);
>  	return 0;
> @@ -857,7 +857,7 @@ static int virtblk_restore(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> -	blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> +	blk_mq_unquiesce_queue(vblk->disk->queue);
>  	return 0;
>  }
>  #endif
> -- 
> 2.7.4
> 

Looks fine, 

Reviewed-by: Ming Lei <ming.lei at redhat.com>
	

-- 
Ming
