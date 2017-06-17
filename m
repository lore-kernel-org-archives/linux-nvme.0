From: hch@lst.de (Christoph Hellwig)
Date: Sat, 17 Jun 2017 13:57:03 +0200
Subject: [PATCH] nvme: set DMA_ATTR_WEAK_ORDERING attribute on dma buffers
In-Reply-To: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>
References: <1497645290-31041-1-git-send-email-alan.adamson@oracle.com>
Message-ID: <20170617115703.GA13002@lst.de>

On Fri, Jun 16, 2017@01:34:50PM -0700, Alan Adamson wrote:
> SPARC based platforms suffer significant read performance penalties for
> nvme reads when Relaxed Ordering is not enabled. This change sets the
> DMA_ATTR_WEAK_ORDERING (Relaxed Ordering) attribute for nvme block dma
> buffers.

Please explain what it does exactly, and why you think it's safe for NVMe,
as that belongs into the changelog.

Bonus points for explaining why DMA_ATTR_WEAK_ORDERING shouldn't
be the default behavior for the dma_map_ routines instead of sprinkling
it over just about every driver..
