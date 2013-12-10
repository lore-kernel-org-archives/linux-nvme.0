From: m@bjorling.me (=?ISO-8859-1?Q?Matias_Bj=F8rling?=)
Date: Tue, 10 Dec 2013 12:12:18 +0100
Subject: [PATCH] Dynamically allocate partition numbers
In-Reply-To: <20131209175846.GH6900@linux.intel.com>
References: <20131209175846.GH6900@linux.intel.com>
Message-ID: <52A6F712.7010308@bjorling.me>

On 12/09/2013 06:58 PM, Matthew Wilcox wrote:
> Some users need more than 64 partitions per device.  Rather than simply
> increasing the number of partitions, switch to the dynamic partition
> allocation scheme.
>
> This means that minor numbers are not stable across boots, but since major
> numbers aren't either, I cannot see this being a significant problem.
>
> Signed-off-by: Matthew Wilcox <matthew.r.wilcox at intel.com>
>
> ---
>
>   nvme-core.c |   37 ++++---------------------------------
>   1 file changed, 4 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b345b2f..b782345 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -46,7 +46,6 @@
>   #define NVME_Q_DEPTH 1024
>   #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
>   #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
> -#define NVME_MINORS 64
>   #define ADMIN_TIMEOUT	(60 * HZ)
>
>   static int nvme_major;
> @@ -1902,33 +1901,6 @@ static int nvme_kthread(void *data)
>   	return 0;
>   }
>
> -static DEFINE_IDA(nvme_index_ida);
> -
> -static int nvme_get_ns_idx(void)
> -{
> -	int index, error;
> -
> -	do {
> -		if (!ida_pre_get(&nvme_index_ida, GFP_KERNEL))
> -			return -1;
> -
> -		spin_lock(&dev_list_lock);
> -		error = ida_get_new(&nvme_index_ida, &index);
> -		spin_unlock(&dev_list_lock);
> -	} while (error == -EAGAIN);
> -
> -	if (error)
> -		index = -1;
> -	return index;
> -}
> -
> -static void nvme_put_ns_idx(int index)
> -{
> -	spin_lock(&dev_list_lock);
> -	ida_remove(&nvme_index_ida, index);
> -	spin_unlock(&dev_list_lock);
> -}
> -
>   static void nvme_config_discard(struct nvme_ns *ns)
>   {
>   	u32 logical_block_size = queue_logical_block_size(ns->queue);
> @@ -1962,7 +1934,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
>   	ns->dev = dev;
>   	ns->queue->queuedata = ns;
>
> -	disk = alloc_disk(NVME_MINORS);
> +	disk = alloc_disk(0);
>   	if (!disk)
>   		goto out_free_queue;
>   	ns->ns_id = nsid;
> @@ -1975,12 +1947,13 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
>   		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
>
>   	disk->major = nvme_major;
> -	disk->minors = NVME_MINORS;
> -	disk->first_minor = NVME_MINORS * nvme_get_ns_idx();
> +	disk->minors = 0;

The above line can be removed.

> +	disk->first_minor = 0;
>   	disk->fops = &nvme_fops;
>   	disk->private_data = ns;
>   	disk->queue = ns->queue;
>   	disk->driverfs_dev = &dev->pci_dev->dev;
> +	disk->flags = GENHD_FL_EXT_DEVT;
>   	sprintf(disk->disk_name, "nvme%dn%d", dev->instance, nsid);
>   	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
>
> @@ -1998,9 +1971,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
>
>   static void nvme_ns_free(struct nvme_ns *ns)
>   {
> -	int index = ns->disk->first_minor / NVME_MINORS;
>   	put_disk(ns->disk);
> -	nvme_put_ns_idx(index);
>   	blk_cleanup_queue(ns->queue);
>   	kfree(ns);
>   }
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
>

Tested and works.
