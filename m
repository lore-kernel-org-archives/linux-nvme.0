From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Aug 2019 07:59:18 +0200
Subject: [PATCH v2 11/14] PCI/P2PDMA: Store mapping method in an xarray
In-Reply-To: <20190730163545.4915-12-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-12-logang@deltatee.com>
Message-ID: <20190807055918.GB6627@lst.de>

On Tue, Jul 30, 2019@10:35:42AM -0600, Logan Gunthorpe wrote:
> When upstream_bridge_distance() is called store the method required
> to map the DMA transfers in an xarray so that it can be looked up
> efficiently on the hot path in pci_p2pdma_map_sg().
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index fe647bd8f947..010aa8742bec 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -19,10 +19,19 @@
>  #include <linux/random.h>
>  #include <linux/seq_buf.h>
>  #include <linux/iommu.h>
> +#include <linux/xarray.h>
> +
> +enum pci_p2pdma_map_type {
> +	PCI_P2PDMA_MAP_UNKNOWN = 0,
> +	PCI_P2PDMA_MAP_NOT_SUPPORTED,
> +	PCI_P2PDMA_MAP_BUS_ADDR,
> +	PCI_P2PDMA_MAP_THRU_IOMMU,
> +};

So here we add a new enum for the map type, but for the internal code
the previousloading of the distance is kept, which seems a little
strange.

> +	if (!(dist & P2PDMA_THRU_HOST_BRIDGE)) {
> +		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
> +		goto store_map_type_and_return;
> +	}
> +
> +	if (host_bridge_whitelist(provider, client)) {
> +		map_type = PCI_P2PDMA_MAP_THRU_IOMMU;
> +	} else {
> +		dist |= P2PDMA_NOT_SUPPORTED;
> +		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +	}
>  
> +store_map_type_and_return:

Why not:

	if (dist & P2PDMA_THRU_HOST_BRIDGE) {
		if (host_bridge_whitelist(provider, client)) {
			map_type = PCI_P2PDMA_MAP_THRU_IOMMU;
		} else {
			dist |= P2PDMA_NOT_SUPPORTED;
			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
		}
	}
