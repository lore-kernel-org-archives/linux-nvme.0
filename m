From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Thu, 11 Sep 2014 17:15:34 +0000
Subject: [PATCH] NVMe: Add revalidate_disk callback
In-Reply-To: <1410391274-30070-1-git-send-email-keith.busch@intel.com>
References: <1410391274-30070-1-git-send-email-keith.busch@intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9944EAC55@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Keith Busch
> Sent: Wednesday, September 10, 2014 4:21 PM
> To: linux-nvme at lists.infradead.org
> Cc: Keith Busch
> Subject: [PATCH] NVMe: Add revalidate_disk callback
> 
> This adds a callback to revalidate the disk and change its block size
> and capacity if needed. Before, a user would have to remove + rescan
> an entire device if they changed the logical block size using an NVMe
> Format or other vendor specific command; now they can just run
> something
> that issues the BLKRRPART IOCTL, like
> 
>  # hdparm -z /dev/nvmeXnY
> 
> This can also be used in response to the 1.2 Spec's Namespace Attribute
> Change asynchronous event.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-core.c |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 1b9cd27..2e0f95f 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1833,6 +1833,35 @@ static int nvme_getgeo(struct block_device *bd,
> struct hd_geometry *geo)
>  	return 0;
>  }
> 
> +static int nvme_revalidate_disk(struct gendisk *disk)
> +{
> +	struct nvme_ns *ns = disk->private_data;
> +	struct nvme_dev *dev = ns->dev;
> +	struct nvme_id_ns *id;
> +	dma_addr_t dma_addr;
> +	int lbaf;
> +
> +	id = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
> +								GFP_KERNEL);
> +	if (!id) {
> +		dev_warn(&dev->pci_dev->dev, "%s: Memory alocation
> failure\n",
> +								__func__);
> +		return 0;
> +	}
> +
> +	if (nvme_identify(dev, ns->ns_id, 0, dma_addr))
> +		goto free;
> +
> +	lbaf = id->flbas & 0xf;
> +	ns->lba_shift = id->lbaf[lbaf].ds;
> +
> +	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
> +	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift -
> 9));
> + free:
> +	dma_free_coherent(&dev->pci_dev->dev, 4091, id, dma_addr);

4096, right?
