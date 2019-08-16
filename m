From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:08:33 +0200
Subject: [PATCH v3 04/14] PCI/P2PDMA: Factor out
 __upstream_bridge_distance()
In-Reply-To: <20190812173048.9186-5-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-5-logang@deltatee.com>
Message-ID: <20190816080833.GD9249@lst.de>

On Mon, Aug 12, 2019@11:30:38AM -0600, Logan Gunthorpe wrote:
> This is a prep patch to create a second level helper. There are no
> functional changes.
> 
> The root complex whitelist code will be moved into this function in a
> subsequent patch.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-5-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
> Reviewed-by: Christian K?nig <christian.koenig at amd.com>

Reviewed-by: Christoph Hellwig <hch at lst.de>
