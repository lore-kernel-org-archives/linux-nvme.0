From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 11 Feb 2016 14:59:08 +0200
Subject: [PATCH for-4.5 11/13] NVMe: Dead namespace handling
In-Reply-To: <1455128250-5984-12-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-12-git-send-email-keith.busch@intel.com>
Message-ID: <56BC859C.6030206@dev.mellanox.co.il>


> This adds a "dead" state to a namespace and revalidates such a namespace
> to 0 capacity. This will force buffered writers to stop writing pages
> that can't be synced, and ends requests in failure if any is submitted
> to such a namespace.

This sorta going towards a namespace state machine (like scsi). Maybe
we need to centralize it correctly instead of adding states that are
relevant is sporadic areas?

>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c |  4 ++++
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/pci.c  | 12 +++++++++++-
>   3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 41b595c..84e9f41 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -560,6 +560,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>   	u16 old_ms;
>   	unsigned short bs;
>
> +	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> +		set_capacity(disk, 0);
> +		return -ENODEV;
> +	}
>   	if (nvme_identify_ns(ns->ctrl, ns->ns_id, &id)) {
>   		dev_warn(ns->ctrl->dev, "%s: Identify failure nvme%dn%d\n",
>   				__func__, ns->ctrl->instance, ns->ns_id);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 19a64b2..e4b4110 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -117,6 +117,7 @@ struct nvme_ns {
>   	unsigned long flags;
>
>   #define NVME_NS_REMOVING 0
> +#define NVME_NS_DEAD     1
>
>   	u64 mode_select_num_blocks;
>   	u32 mode_select_block_len;
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a18e4ab..7fd8a54 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -678,7 +678,9 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>
>   	spin_lock_irq(&nvmeq->q_lock);
>   	if (unlikely(nvmeq->cq_vector < 0)) {
> -		ret = BLK_MQ_RQ_QUEUE_BUSY;
> +		ret = test_bit(NVME_NS_DEAD, &ns->flags) ?
> +					BLK_MQ_RQ_QUEUE_ERROR :
> +					BLK_MQ_RQ_QUEUE_BUSY;
>   		spin_unlock_irq(&nvmeq->q_lock);
>   		goto out;
>   	}

I can't say I'm a fan of doing all this in queue_rq...

besides why is this state check under the cq_vector < 0 condition?
This is really confusing...
