From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:06:30 +0200
Subject: [PATCH v3 02/14] PCI/P2PDMA: Add provider's pci_dev to
 pci_p2pdma_pagemap struct
In-Reply-To: <20190812173048.9186-3-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-3-logang@deltatee.com>
Message-ID: <20190816080630.GB9249@lst.de>

On Mon, Aug 12, 2019@11:30:36AM -0600, Logan Gunthorpe wrote:
> The provider will be needed to figure out how to map a device.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-3-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
