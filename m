From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:08:15 +0200
Subject: [PATCH v3 03/14] PCI/P2PDMA: Add constants for map type
 results to upstream_bridge_distance()
In-Reply-To: <20190812173048.9186-4-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-4-logang@deltatee.com>
Message-ID: <20190816080815.GC9249@lst.de>

On Mon, Aug 12, 2019@11:30:37AM -0600, Logan Gunthorpe wrote:
> Add constant flags to indicate how two devices will be mapped or if they
> are unsupported. upstream_bridge_distance() will now return the
> mapping type and the distance in a passed-by-reference argument.
> 
> This helps annotate the code better, but the main reason is so we can use
> the information to store the required mapping method in an xarray.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-4-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
> Reviewed-by: Christian K?nig <christian.koenig at amd.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
