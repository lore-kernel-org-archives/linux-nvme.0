From: hch@lst.de (Christoph Hellwig)
Date: Tue, 23 May 2017 09:24:11 +0200
Subject: [PATCH v2] nvme/pci: remap BAR0 to cover admin CQ doorbell for
 large stride
In-Reply-To: <1495429761-19820-1-git-send-email-yu.a.xu@intel.com>
References: <1495429761-19820-1-git-send-email-yu.a.xu@intel.com>
Message-ID: <20170523072411.GA18425@lst.de>

On Mon, May 22, 2017@01:09:21PM +0800, Xu Yu wrote:
> The existing driver initially maps 8192 bytes of BAR0 which is
> intended to cover doorbells of admin SQ and CQ. However, if a
> large stride, e.g. 10, is used, the doorbell of admin CQ will
> be out of 8192 bytes. Consequently, a page fault will be raised
> when the admin CQ doorbell is accessed in nvme_configure_admin_queue().
> 
> This patch fixes this issue by remapping BAR0 before accessing
> admin CQ doorbell if the initial mapping is not enough.
> 
> Signed-off-by: Xu Yu <yu.a.xu at intel.com>
> ---
> Changes since v1:
> * Move the bar (re)mapping logic in nvme_dev_map(), nvme_configure_admin_queue()
> and nvme_setup_io_queues() to a new helper nvme_remap_bar().
> * Replace several magic numbers by PAGE_SIZE and the new NVME_REG_DBS.
> ---
>  drivers/nvme/host/pci.c | 63 ++++++++++++++++++++++++++++++++-----------------
>  include/linux/nvme.h    |  1 +
>  2 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9d4640a..84a254a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -91,6 +91,7 @@ struct nvme_dev {
>  	int q_depth;
>  	u32 db_stride;
>  	void __iomem *bar;
> +	unsigned long bar_mapped_size;
>  	struct work_struct reset_work;
>  	struct work_struct remove_work;
>  	struct timer_list watchdog_timer;
> @@ -1316,6 +1317,30 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>  	return 0;
>  }
>  
> +static unsigned long db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
> +{
> +	return NVME_REG_DBS + ((nr_io_queues + 1) * 8 * dev->db_stride);
> +}
> +
> +static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +
> +	if (size <= dev->bar_mapped_size)
> +		return 0;

Can we add a sanitiy check that size is <= pci_resource_len() somewhere?

> -	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
> -	if (!dev->bar)
> +	if (nvme_remap_bar(dev, NVME_REG_DBS + PAGE_SIZE))

page size isn't correct here, we had a constant 4096 which might be
smaller than page size.  A comment on why we did chose 4096 might
be useful, but the reason for it might be lost in history..

Otherwise this looks great to me.
