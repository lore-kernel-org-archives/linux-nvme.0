From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:13:49 +0200
Subject: [PATCH v3 09/14] PCI/P2PDMA: Introduce pci_p2pdma_unmap_sg()
In-Reply-To: <20190812173048.9186-10-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-10-logang@deltatee.com>
Message-ID: <20190816081349.GI9249@lst.de>

On Mon, Aug 12, 2019@11:30:43AM -0600, Logan Gunthorpe wrote:
> Add pci_p2pdma_unmap_sg() to the two places that call pci_p2pdma_map_sg().
> 
> This is a prep patch to introduce correct mappings for p2pdma transactions
> that go through the root complex.

I personally wouldn't split it from actually adding useful functionality,
but that aside this looks ok:

Reviewed-by: Christoph Hellwig <hch at lst.de>
