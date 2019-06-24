From: hch@lst.de (Christoph Hellwig)
Date: Mon, 24 Jun 2019 09:31:26 +0200
Subject: [RFC PATCH 00/28] Removing struct page from P2PDMA
In-Reply-To: <20190620193353.GF19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca>
Message-ID: <20190624073126.GB3954@lst.de>

On Thu, Jun 20, 2019@04:33:53PM -0300, Jason Gunthorpe wrote:
> > My primary concern with this is that ascribes a level of generality
> > that just isn't there for peer-to-peer dma operations. "Peer"
> > addresses are not "DMA" addresses, and the rules about what can and
> > can't do peer-DMA are not generically known to the block layer.
> 
> ?? The P2P infrastructure produces a DMA bus address for the
> initiating device that is is absolutely a DMA address. There is some
> intermediate CPU centric representation, but after mapping it is the
> same as any other DMA bus address.
> 
> The map function can tell if the device pair combination can do p2p or
> not.

At the PCIe level there is no such thing as a DMA address, it all
is bus address with MMIO and DMA in the same address space (without
that P2P would have not chance of actually working obviously).  But
that bus address space is different per "bus" (which would be an
root port in PCIe), and we need to be careful about that.
