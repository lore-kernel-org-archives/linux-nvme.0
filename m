From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jun 2019 08:24:41 +0200
Subject: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
In-Reply-To: <20190605202235.GC3273@ziepe.ca>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-9-hch@lst.de> <20190605202235.GC3273@ziepe.ca>
Message-ID: <20190606062441.GB26745@lst.de>

On Wed, Jun 05, 2019@05:22:35PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 05, 2019@09:08:31PM +0200, Christoph Hellwig wrote:
> > This ensures all proper DMA layer handling is taken care of by the
> > SCSI midlayer.
> 
> Maybe not entirely related to this series, but it looks like the SCSI
> layer is changing the device global dma_set_max_seg_size() - at least
> in RDMA the dma device is being shared between many users, so we
> really don't want SCSI to make this value smaller.
> 
> Can we do something about this?

We could do something about it as outlined in my mail - pass the
dma_params explicitly to the dma_map_sg call.  But that isn't really
suitable for a short term fix and will take a little more time.

Until we've sorted that out the device paramter needs to be set to
the smallest value supported.
