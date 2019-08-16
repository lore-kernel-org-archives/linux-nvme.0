From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:14:05 +0200
Subject: [PATCH v3 10/14] PCI/P2PDMA: Factor out __pci_p2pdma_map_sg()
In-Reply-To: <20190812173048.9186-11-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-11-logang@deltatee.com>
Message-ID: <20190816081405.GJ9249@lst.de>

On Mon, Aug 12, 2019@11:30:44AM -0600, Logan Gunthorpe wrote:
> Factor out the bus-only mapping into its own static function.  No
> functional changes. The original pci_p2pdma_map_sg_attrs() will be used to
> decide whether this is an appropriate way to map.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-11-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
