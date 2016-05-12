From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 12 May 2016 00:03:52 -0700
Subject: [PATCH] NVMe: Only release requested regions
In-Reply-To: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
References: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
Message-ID: <20160512070352.GB20802@infradead.org>

>  static void nvme_dev_unmap(struct nvme_dev *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +	int bars;
> +
>  	if (dev->bar)
>  		iounmap(dev->bar);
> -	pci_release_regions(to_pci_dev(dev->dev));
> +
> +	bars = pci_select_bars(pdev, IORESOURCE_MEM);
> +	pci_release_selected_regions(pdev, bars);

This looks fine, but I really hate this API.

Can someone add these two nice helpers to pci.h:

static inline int
pci_request_mem_regions(struct pci_dev *pdev, const char *name)
{
	return pci_request_selected_regions(pdev,
			pci_select_bars(pdev, IORESOURCE_MEM), name);
}

static inline void
pci_release_mem_regions(struct pci_dev *pdev)
{
	return pci_release_selected_regions(pdev,
			pci_select_bars(pdev, IORESOURCE_MEM));
}

But for now this should do it:

Reviewed-by: Christoph Hellwig <hch at lst.de>
