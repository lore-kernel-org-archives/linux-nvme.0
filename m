From: hch@lst.de (Christoph Hellwig)
Date: Sat, 1 Jun 2019 11:07:14 +0200
Subject: [PATCH 1/3] nvme-pci: reset timeout when processing is paused
In-Reply-To: <20190524202036.17265-2-keith.busch@intel.com>
References: <20190524202036.17265-1-keith.busch@intel.com>
 <20190524202036.17265-2-keith.busch@intel.com>
Message-ID: <20190601090714.GG6453@lst.de>

On Fri, May 24, 2019@02:20:34PM -0600, Keith Busch wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f562154551ce..101e20522374 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1263,7 +1263,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	 * the recovery mechanism will surely fail.
>  	 */
>  	mb();
> -	if (pci_channel_offline(to_pci_dev(dev->dev)))
> +	if (pci_channel_offline(to_pci_dev(dev->dev)) || (csts & NVME_CSTS_PP))

I think we at least need a ratelimited printk when this happens so
people know they don't get timeouts because of CSTS.PP.

And maybe we need a timeout how long we allow the timeouts to extended
due to CSTS.PP, otherwise a buggy device that never clears it would
hold I/O hostage forever.
