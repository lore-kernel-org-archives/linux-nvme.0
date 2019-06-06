From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jun 2019 16:19:50 +0200
Subject: [PATCH 08/13] IB/iser: set virt_boundary_mask in the scsi host
In-Reply-To: <20190606125935.GA17373@ziepe.ca>
References: <20190605190836.32354-1-hch@lst.de>
 <20190605190836.32354-9-hch@lst.de> <20190605202235.GC3273@ziepe.ca>
 <20190606062441.GB26745@lst.de> <20190606125935.GA17373@ziepe.ca>
Message-ID: <20190606141950.GB15112@lst.de>

On Thu, Jun 06, 2019@09:59:35AM -0300, Jason Gunthorpe wrote:
> > Until we've sorted that out the device paramter needs to be set to
> > the smallest value supported.
> 
> smallest? largest? We've been setting it to the largest value the
> device can handle (ie 2G)

Well, in general we need the smallest value supported by any ULP,
because if any ULP can't support a larger segment size, we must not
allow the IOMMU to merge it to that size.  That being said I can't
really see why any RDMA ULP should limit the size given how the MRs
work.
