From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 8 Feb 2016 10:16:40 -0800
Subject: [PATCH 3/4] NVMe: Surprise removal fixes
In-Reply-To: <1454515543-21683-4-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <1454515543-21683-4-git-send-email-keith.busch@intel.com>
Message-ID: <20160208181640.GD13126@infradead.org>

On Wed, Feb 03, 2016@09:05:42AM -0700, Keith Busch wrote:
> Temporarily halts IO queues on surprise removal prior to flushing
> pending requests to an error completion.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 13 +++++++------
>  drivers/nvme/host/pci.c  | 14 ++++++++++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9d415489..f11cb5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1186,15 +1186,16 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
>  
>  	if (kill) {
> -		blk_set_queue_dying(ns->queue);
> -
>  		/*
> -		 * The controller was shutdown first if we got here through
> -		 * device removal. The shutdown may requeue outstanding
> -		 * requests. These need to be aborted immediately so
> -		 * del_gendisk doesn't block indefinitely for their completion.
> +		 * The request queue is currently stoppped if we got here.
> +		 * Prevent new requests from entering before flushing the rest.
> +		 * New requests will fail to enter a dying frozen queue, which
> +		 * allows blk_cleanup_queue to complete.
>  		 */
> +		blk_mq_freeze_queue_start(ns->queue);
> +		blk_set_queue_dying(ns->queue);
>  		blk_mq_abort_requeue_list(ns->queue);
> +		blk_mq_start_hw_queues(ns->queue);
>  	}

Do we really still need all this magic if ->queue_rq returns a failure
if the queue is dying?

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72ef832..4cc7398 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -640,6 +640,11 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	struct nvme_command cmnd;
>  	int ret = BLK_MQ_RQ_QUEUE_OK;
>  
> +	if (unlikely(blk_queue_dying(req->q))) {
> +		blk_mq_end_request(req, -EFAULT);
> +		return BLK_MQ_RQ_QUEUE_OK;
> +	}

"Bad address" is a really odd error for a dying block device.
