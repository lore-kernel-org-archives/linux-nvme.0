From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:09:14 +0200
Subject: [PATCH v3 05/14] PCI/P2PDMA: Apply host bridge whitelist for ACS
In-Reply-To: <20190812173048.9186-6-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-6-logang@deltatee.com>
Message-ID: <20190816080914.GE9249@lst.de>

On Mon, Aug 12, 2019@11:30:39AM -0600, Logan Gunthorpe wrote:
> When a P2PDMA transfer is rejected due to ACS being set, we can also check
> the whitelist and allow the transactions.
> 
> Do this by pushing the whitelist check into the upstream_bridge_distance()
> function.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-6-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
> Reviewed-by: Christian K?nig <christian.koenig at amd.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
