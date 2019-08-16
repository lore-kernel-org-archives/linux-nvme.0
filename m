From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:14:54 +0200
Subject: [PATCH v3 11/14] PCI/P2PDMA: Store mapping method in an xarray
In-Reply-To: <20190812173048.9186-12-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-12-logang@deltatee.com>
Message-ID: <20190816081454.GK9249@lst.de>

On Mon, Aug 12, 2019@11:30:45AM -0600, Logan Gunthorpe wrote:
> When upstream_bridge_distance() is called, store the method required to map
> the DMA transfers in an xarray so it can be looked up efficiently on the
> hot path in pci_p2pdma_map_sg().
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-12-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
