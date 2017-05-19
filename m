From: yu.a.xu@intel.com (Xu, Yu A)
Date: Fri, 19 May 2017 09:22:46 +0000
Subject: [PATCH] nvme/pci: remap BAR0 to cover admin CQ doorbell for
 large stride
In-Reply-To: <20170518134344.GA31139@lst.de>
References: <1495060547-6180-1-git-send-email-yu.a.xu@intel.com>
 <20170518134344.GA31139@lst.de>
Message-ID: <429489B430F8684FB31A7BE5B562673438D1847F@shsmsx102.ccr.corp.intel.com>

Thanks for your suggestion, we will try to make it better and resend the patch soon.

-----Original Message-----
From: Christoph Hellwig [mailto:hch@lst.de] 
Sent: Thursday, May 18, 2017 9:44 PM
To: Xu, Yu A <yu.a.xu at intel.com>
Cc: linux-nvme at lists.infradead.org; linux-kernel at vger.kernel.org; Busch, Keith <keith.busch at intel.com>; axboe at fb.com; hch at lst.de; sagi at grimberg.me; Zhang, Haozhong <haozhong.zhang at intel.com>
Subject: Re: [PATCH] nvme/pci: remap BAR0 to cover admin CQ doorbell for large stride

On Thu, May 18, 2017@06:35:47AM +0800, Xu Yu wrote:
> The existing driver initially maps 8192 bytes of BAR0 which is 
> intended to cover doorbells of admin SQ and CQ. However, if a large 
> stride, e.g. 10, is used, the doorbell of admin CQ will be out of 8192 
> bytes. Consequently, a page fault will be raised when the admin CQ 
> doorbell is accessed in nvme_configure_admin_queue().
> 
> This patch fixes this issue by remapping BAR0 before accessing admin 
> CQ doorbell if the initial mapping is not enough.
> 
> Signed-off-by: "Xu, Yu A" <yu.a.xu at intel.com>
> ---
>  drivers/nvme/host/pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 
> 9d4640a..7c991eb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1322,6 +1322,17 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  	u32 aqa;
>  	u64 cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
>  	struct nvme_queue *nvmeq;
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	unsigned long size;
> +
> +	size = 4096 + 2 * 4 * dev->db_stride;
> +	if (size > 8192) {
> +		iounmap(dev->bar);
> +		dev->bar = ioremap(pci_resource_start(pdev, 0), size);
> +		if (!dev->bar)
> +			return -ENOMEM;
> +		dev->dbs = dev->bar + 4096;
> +	}

This code duplicates logic in db_bar_size / nvme_setup_io_queues.
Please reuse the db_bar_size helper by passing 0 to, and try to figure out if we can factor this whole sequence into a new helper as well.

Bonus points for adding constants to nvme.h for the 4096 offset of the first db register, and our magic 8192 threshold.
