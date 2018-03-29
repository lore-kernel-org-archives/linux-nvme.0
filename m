From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Mar 2018 20:15:45 +0200
Subject: [PATCH 4/4] nvmet-fc: Use new SGL alloc/free helper for requests
In-Reply-To: <bd62c2e6-558c-e314-177f-c95cf842c741@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-5-logang@deltatee.com>
 <15f4d135-7600-02b3-f50f-ed8deddd7b98@broadcom.com>
 <bd62c2e6-558c-e314-177f-c95cf842c741@deltatee.com>
Message-ID: <20180329181545.GA16116@lst.de>

On Thu, Mar 29, 2018@11:02:10AM -0600, Logan Gunthorpe wrote:
> Per the bug in the previous patch, I don't think that was ever a valid
> assumption. It doesn't have anything to do with the sgl_alloc change
> either. The dma_map interface is allowed to merge SGLs and that's why it
> can return fewer nents than it was passed. I'm not sure how many or
> which DMA ops actually do this which is why it hasn't actually
> manifested itself as a bug; but it is part of how the interface is
> specified to work.

Most iommus can, it just is very unlikely do happen in block drivers
given that the block layer already merges segments higher up.
