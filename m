From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:15:48 +0200
Subject: [PATCH v3 12/14] PCI/P2PDMA: dma_map() requests that traverse
 the host bridge
In-Reply-To: <20190812173048.9186-13-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-13-logang@deltatee.com>
Message-ID: <20190816081548.GL9249@lst.de>

On Mon, Aug 12, 2019@11:30:46AM -0600, Logan Gunthorpe wrote:
> Any requests that traverse the host bridge will need to be mapped into the
> IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when appropriate.
> 
> Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-13-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
