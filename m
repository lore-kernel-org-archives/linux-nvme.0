From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Jun 2019 09:18:23 +0200
Subject: [RFC PATCH 00/28] Removing struct page from P2PDMA
In-Reply-To: <1041d2c6-f22c-81f2-c141-fb821b35c0c1@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca> <20190624073126.GB3954@lst.de>
 <20190624134641.GA8268@ziepe.ca>
 <1041d2c6-f22c-81f2-c141-fb821b35c0c1@deltatee.com>
Message-ID: <20190625071823.GA30350@lst.de>

On Mon, Jun 24, 2019@10:10:16AM -0600, Logan Gunthorpe wrote:
> Yes, that's correct. The intent was to invert it so the dma_map could
> happen at the start of the process so that P2PDMA code could be called
> with all the information it needs to make it's decision on how to map;
> without having to hook into the mapping process of every driver that
> wants to participate.

And that just isn't how things work in layering.  We need to keep
generating the dma addresses in the driver in the receiving end, as
there are all kinds of interesting ideas how we do that.  E.g. for the
Mellanox NICs addressing their own bars is not done by PCIe bus
addresses but by relative offsets.  And while NVMe has refused to go
down that route in the current band aid fix for CMB addressing I suspect
it will sooner or later have to do the same to deal with the addressing
problems in a multiple PASID world.
