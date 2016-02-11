From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 11 Feb 2016 14:50:54 +0200
Subject: [PATCH for-4.5 10/13] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <1455128250-5984-11-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-11-git-send-email-keith.busch@intel.com>
Message-ID: <56BC83AE.8080702@dev.mellanox.co.il>



On 10/02/2016 20:17, Keith Busch wrote:
> This moves the dead queue handling out of the namespace removal path
> and into the reset failure path. It fixes a deadlock condition if the
> controller fails or link down during del_gendisk.

How does it fix the deadlock?

>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 19 ++-----------------
>   drivers/nvme/host/nvme.h |  1 +
>   drivers/nvme/host/pci.c  | 22 ++++++++++++++++++++++
>   3 files changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index be27f9f..41b595c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -64,7 +64,7 @@ static void nvme_free_ns(struct kref *kref)
>   	kfree(ns);
>   }
>
> -static void nvme_put_ns(struct nvme_ns *ns)
> +void nvme_put_ns(struct nvme_ns *ns)
>   {
>   	kref_put(&ns->kref, nvme_free_ns);
>   }
> @@ -1113,28 +1113,13 @@ static struct nvme_ns *nvme_find_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   static void nvme_ns_remove_work(struct work_struct *work)
>   {
>   	struct nvme_ns *ns = container_of(work, struct nvme_ns, remove_work);
> -	bool kill = nvme_io_incapable(ns->ctrl) &&
> -			!blk_queue_dying(ns->queue);
> -
> -	if (kill) {
> -		blk_set_queue_dying(ns->queue);
> -
> -		/*
> -		 * The controller was shutdown first if we got here through
> -		 * device removal. The shutdown may requeue outstanding
> -		 * requests. These need to be aborted immediately so
> -		 * del_gendisk doesn't block indefinitely for their completion.
> -		 */
> -		blk_mq_abort_requeue_list(ns->queue);
> -	}
> +
>   	if (ns->disk->flags & GENHD_FL_UP) {
>   		if (blk_get_integrity(ns->disk))
>   			blk_integrity_unregister(ns->disk);
>   		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
>   					&nvme_ns_attr_group);
>   		del_gendisk(ns->disk);
> -	}
> -	if (kill || !blk_queue_dying(ns->queue)) {
>   		blk_mq_abort_requeue_list(ns->queue);
>   		blk_cleanup_queue(ns->queue);
>   	}
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index d330512..19a64b2 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -270,6 +270,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
>   int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
>   			dma_addr_t dma_addr, u32 *result);
>   int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
> +void nvme_put_ns(struct nvme_ns *ns);
>
>   extern spinlock_t dev_list_lock;
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3381bac..a18e4ab 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1898,11 +1898,33 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>   	kfree(dev);
>   }
>
> +static void nvme_kill_ns_queues(struct nvme_dev *dev)
> +{
> +	struct nvme_ns *ns;
> +	struct nvme_ctrl *ctrl = &dev->ctrl;
> +
> +	nvme_dev_disable(dev, false);
> +
> +	mutex_lock(&ctrl->namespaces_mutex);
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (!kref_get_unless_zero(&ns->kref))
> +			continue;
> +
> +		blk_set_queue_dying(ns->queue);
> +		blk_mq_abort_requeue_list(ns->queue);
> +		blk_mq_start_stopped_hw_queues(ns->queue, true);
> +
> +		nvme_put_ns(ns);
> +	}
> +	mutex_unlock(&ctrl->namespaces_mutex);
> +}
> +

Why on earth is this pci specific? This should be in the
core. Aside from that, I'd really prefer if the core can handle this
without having the pci (or other) triggering it explicitly, but if
this must move out of the ns remove then we need documentation on
what are the rules of when the driver needs to call it.
