From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 24 May 2016 11:15:52 +0200
Subject: [PATCH] NVMe: Only release requested regions
In-Reply-To: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
References: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
Message-ID: <20160524091552.wmquryos2itoi767@c203.arch.suse.de>

On Tue, May 10, 2016@03:14:28PM +0200, Johannes Thumshirn wrote:
> The NVMe driver only requests the PCIe device's memory regions but releases
> all possible regions (including eventual I/O regions). This leads to a stale
> warning entry in dmesg about freeing non existent resources.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index eec73fe..6f5ad07 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1759,9 +1759,14 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  
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
>  }
>  
>  static void nvme_pci_disable(struct nvme_dev *dev)
> @@ -1998,7 +2003,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
>  
>         return 0;
>    release:
> -       pci_release_regions(pdev);
> +       pci_release_selected_regions(pdev, bars);
>         return -ENODEV;
>  }
>  
> -- 
> 1.8.5.6
> 

Keith, Jens, any opinions?

As I've probably missed v4.7, is it possible to get it for v4.8?
Or should I take on the PCI helper functions Christoph suggested first?

Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
