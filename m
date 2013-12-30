From: keith.busch@intel.com (Keith Busch)
Date: Mon, 30 Dec 2013 09:06:11 -0700 (MST)
Subject: [PATCH RFC 2/5] NVMe: Basic NVMe device hotplug support
In-Reply-To: <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
Message-ID: <alpine.LRH.2.03.1312300855460.4958@AMR>

On Mon, 30 Dec 2013, Santosh Y wrote:
> This patch provides basic hotplug support for NVMe.
> For NVMe hotplug to work the PCIe slot must be hotplug capable.
>
> When a NVMe device is surprise removed and inserted back the
> device may need some time to respond to host IO commands, and
> will return NVME_SC_NS_NOT_READY. In this case the requests
> will be requeued until the device responds to the IO commands
> with status response or until the commands timeout.
>
> Signed-off-by: Ravi Kumar <ravi.android at gmail.com>
> Signed-off-by: Santosh Y <santoshsy at gmail.com>
>
> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
> index 86b9f37..f92ec96 100644
> --- a/drivers/block/Kconfig
> +++ b/drivers/block/Kconfig
> @@ -319,6 +319,14 @@ config BLK_DEV_NVME
> 	  To compile this driver as a module, choose M here: the
> 	  module will be called nvme.
>
> +config BLK_DEV_NVME_HP
> +	bool "Enable hotplug support"
> +	depends on BLK_DEV_NVME && HOTPLUG_PCI_PCIE
> +	default n
> +	help
> +	  If you say Y here, the driver will support hotplug feature.
> +	  Hotplug only works if the PCIe slot is hotplug capable.
> +
> config BLK_DEV_SKD
> 	tristate "STEC S1120 Block Driver"
> 	depends on PCI
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index a523296..8a02135 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -172,6 +172,13 @@ static int alloc_cmdid(struct nvme_queue *nvmeq, void *ctx,
> 	return cmdid;
> }
>
> +static inline bool nvme_check_surprise_removal(struct nvme_dev *dev)
> +{
> +	if (readl(&dev->bar->csts) == -1)
> +		return true;
> +	return false;
> +}
> +
> static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
> 				nvme_completion_fn handler, unsigned timeout)
> {
> @@ -370,6 +377,19 @@ static void nvme_end_io_acct(struct bio *bio, unsigned long start_time)
> 	part_stat_unlock();
> }
>
> +#ifdef CONFIG_BLK_DEV_NVME_HP
> +static void nvme_requeue_bio(struct nvme_dev *dev, struct bio *bio)
> +{
> +	struct nvme_queue *nvmeq = get_nvmeq(dev);
> +	if (bio_list_empty(&nvmeq->sq_cong))
> +		add_wait_queue(&nvmeq->sq_full, &nvmeq->sq_cong_wait);
> +	bio_list_add(&nvmeq->sq_cong, bio);
> +	put_nvmeq(nvmeq);
> +	wake_up_process(nvme_thread);
> +}
> +#endif

Unless you just so happen to be calling this function on the correct cpu,
you are modifying a bio_list with an unlocked nvme_queue, and that can
totally screw things up. I think we need to change the callbacks to take
'nvme_queue's instead of 'nvme_dev's to allow us to retry failed bios.
