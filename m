From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:12:55 +0200
Subject: [PATCH v3 08/14] PCI/P2PDMA: Add attrs argument to
 pci_p2pdma_map_sg()
In-Reply-To: <20190812173048.9186-9-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-9-logang@deltatee.com>
Message-ID: <20190816081255.GH9249@lst.de>

On Mon, Aug 12, 2019@11:30:42AM -0600, Logan Gunthorpe wrote:
> This is to match the dma_map_sg() API which this function will have to call
> in an future patch.
> 
> Add a pci_p2pdma_map_sg_attrs() function and helper to call it with no
> attributes just like the dma_map_sg() function.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-9-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
