From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 5 Jun 2019 17:22:35 -0300
Subject: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
In-Reply-To: <20190605190836.32354-9-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-9-hch@lst.de>
Message-ID: <20190605202235.GC3273@ziepe.ca>

On Wed, Jun 05, 2019@09:08:31PM +0200, Christoph Hellwig wrote:
> This ensures all proper DMA layer handling is taken care of by the
> SCSI midlayer.

Maybe not entirely related to this series, but it looks like the SCSI
layer is changing the device global dma_set_max_seg_size() - at least
in RDMA the dma device is being shared between many users, so we
really don't want SCSI to make this value smaller.

Can we do something about this?

Wondering about other values too, and the interaction with the new
combining stuff in umem.c

Thanks,
Jason
