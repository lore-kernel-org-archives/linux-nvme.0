From: hch@lst.de (Christoph Hellwig)
Date: Thu, 18 May 2017 15:49:31 +0200
Subject: [PATCH 2/2] nvme: avoid to hang in remove disk
In-Reply-To: <20170517012729.13469-3-ming.lei@redhat.com>
References: <20170517012729.13469-1-ming.lei@redhat.com>
 <20170517012729.13469-3-ming.lei@redhat.com>
Message-ID: <20170518134931.GB31489@lst.de>

On Wed, May 17, 2017@09:27:29AM +0800, Ming Lei wrote:
> If some writeback requests are submitted just before queue is killed,
> and these requests may not be canceled in nvme_dev_disable() because
> they are not started yet, it is still possible for blk-mq to hold
> these requests in .requeue list.
> 
> So we have to abort these requests first before del_gendisk(), because
> del_gendisk() may wait for completion of these requests.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---
>  drivers/nvme/host/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d5e0906262ea..8eaeea86509a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2097,6 +2097,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  					&nvme_ns_attr_group);
>  		if (ns->ndev)
>  			nvme_nvm_unregister_sysfs(ns);
> +		/*
> +		 * If queue is dead, we have to abort requests in
> +		 * requeue list because fsync_bdev() in removing disk
> +		 * path may wait for these IOs, which can't
> +		 * be submitted to hardware too.
> +		 */
> +		if (blk_queue_dying(ns->queue))
> +			blk_mq_abort_requeue_list(ns->queue);
>  		del_gendisk(ns->disk);
>  		blk_mq_abort_requeue_list(ns->queue);

Why can't we just move the blk_mq_abort_requeue_list call before
del_gendisk in general?
