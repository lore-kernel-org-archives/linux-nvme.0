From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:16:16 +0200
Subject: [PATCH v3 14/14] PCI/P2PDMA: Update pci_p2pdma_distance_many()
 documentation
In-Reply-To: <20190812173048.9186-15-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-15-logang@deltatee.com>
Message-ID: <20190816081616.GN9249@lst.de>

On Mon, Aug 12, 2019@11:30:48AM -0600, Logan Gunthorpe wrote:
> The comment describing pci_p2pdma_distance_many() still referred to
> the devices being behind the same root port. This no longer applies
> so reword the documentation.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
