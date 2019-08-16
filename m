From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Aug 2019 10:16:03 +0200
Subject: [PATCH v3 13/14] PCI/P2PDMA: Allow IOMMU for host bridge whitelist
In-Reply-To: <20190812173048.9186-14-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
 <20190812173048.9186-14-logang@deltatee.com>
Message-ID: <20190816081603.GM9249@lst.de>

On Mon, Aug 12, 2019@11:30:47AM -0600, Logan Gunthorpe wrote:
> Now that we map the requests correctly we can remove the iommu_present()
> restriction.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
