From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 14 Jan 2019 17:23:39 -0600
Subject: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20190103013106.26452-1-ming.lei@redhat.com>
References: <20190103013106.26452-1-ming.lei@redhat.com>
Message-ID: <20190114232338.GE33971@google.com>

On Thu, Jan 03, 2019@09:31:06AM +0800, Ming Lei wrote:
> The API of pci_alloc_irq_vectors_affinity() requires to return -ENOSPC
> if fewer than @min_vecs interrupt vectors are available for @dev.
> 
> However, if a device supports MSI-X but not MSI and a caller requests
> @min_vecs that can't be satisfied by MSI-X, we previously returned
> -EINVAL (from the failed attempt to enable MSI), not -ENOSPC.
> 
> Users of pci_alloc_irq_vectors_affinity() may try to reduce irq vectors
> and allocate vectors again in case that -ENOSPC is returned, such as NVMe,
> so we need to respect the current interface and give preference to -ENOSPC.
> 
> Especially the min/max vecs doesn't work correctly when using the
> irq_affinity nr_sets because rebalancing the set counts is driver specific.
> To get around that, drivers using nr_sets have to set min and max to the same
> value and handle the "reduce and try again".
> 
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: linux-nvme at lists.infradead.org
> Cc: Bjorn Helgaas <bhelgaas at google.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>

Applied to pci/msi for v5.1, thanks!

If this is something that should be in v5.0, let me know and include the
justification, e.g., something we already merged for v5.0 or regression
info, etc, and a Fixes: line, and I'll move it to for-linus.

> ---
>  drivers/pci/msi.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7a1c8a09efa5..4c0b47867258 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1168,7 +1168,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  				   const struct irq_affinity *affd)
>  {
>  	static const struct irq_affinity msi_default_affd;
> -	int vecs = -ENOSPC;
> +	int msix_vecs = -ENOSPC;
> +	int msi_vecs = -ENOSPC;
>  
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
> @@ -1179,16 +1180,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	}
>  
>  	if (flags & PCI_IRQ_MSIX) {
> -		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> -				affd);
> -		if (vecs > 0)
> -			return vecs;
> +		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
> +						    max_vecs, affd);
> +		if (msix_vecs > 0)
> +			return msix_vecs;
>  	}
>  
>  	if (flags & PCI_IRQ_MSI) {
> -		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
> -		if (vecs > 0)
> -			return vecs;
> +		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
> +						  affd);
> +		if (msi_vecs > 0)
> +			return msi_vecs;
>  	}
>  
>  	/* use legacy irq if allowed */
> @@ -1199,7 +1201,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  		}
>  	}
>  
> -	return vecs;
> +	if (msix_vecs == -ENOSPC)
> +		return -ENOSPC;
> +	return msi_vecs;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>  
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
