From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 Jul 2018 08:26:33 +0200
Subject: [PATCH] nvme-pci: Fix memory leak on probe failure
In-Reply-To: <20180711224444.14872-1-keith.busch@intel.com>
References: <20180711224444.14872-1-keith.busch@intel.com>
Message-ID: <20180712062633.GA14734@lst.de>

Thanks,

applied to nvme-4.18.

On Wed, Jul 11, 2018@04:44:44PM -0600, Keith Busch wrote:
> The nvme driver specific structures need to be initialized prior to
> enabling the generic controller so we can unwind on failure with out
> using the reference counting callbacks so that 'probe' and 'remove'
> can be symmetric.
> 
> The newly added iod_mempool is the only resource that was being
> allocated out of order, and a failure there would leak the generic
> controller memory. This patch just moves that allocation above the
> controller initialization.
> 
> Fixes: 943e942e6266f ("nvme-pci: limit max IO size and segments to avoid high order allocations")
> Reported-by: Weiping Zhang <zwp10758 at gmail.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ba943f211687..ddd441b1516a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2556,11 +2556,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	quirks |= check_vendor_combination_bug(pdev);
>  
> -	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
> -			quirks);
> -	if (result)
> -		goto release_pools;
> -
>  	/*
>  	 * Double check that our mempool alloc size will cover the biggest
>  	 * command we support.
> @@ -2578,6 +2573,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto release_pools;
>  	}
>  
> +	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
> +			quirks);
> +	if (result)
> +		goto release_mempool;
> +
>  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
>  
>  	nvme_get_ctrl(&dev->ctrl);
> @@ -2585,6 +2585,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	return 0;
>  
> + release_mempool:
> +	mempool_destroy(dev->iod_mempool);
>   release_pools:
>  	nvme_release_prp_pools(dev);
>   unmap:
> -- 
> 2.14.3
---end quoted text---
