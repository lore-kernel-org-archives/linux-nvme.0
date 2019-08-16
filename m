From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:09:59 +0200
Subject: [PATCH v3 06/14] PCI/P2PDMA: Factor out host_bridge_whitelist()
In-Reply-To: <20190812173048.9186-7-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-7-logang@deltatee.com>
Message-ID: <20190816080959.GF9249@lst.de>

On Mon, Aug 12, 2019@11:30:40AM -0600, Logan Gunthorpe wrote:
> Push both PCI devices into the whitelist checking function seeing some
> hardware will require us ensuring they are on the same host bridge.
> 
> At the same time we rename root_complex_whitelist() to
> host_bridge_whitelist() to match the terminology used in the code.
> 
> Link: https://lore.kernel.org/r/20190730163545.4915-7-logang at deltatee.com
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
