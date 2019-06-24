From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 24 Jun 2019 15:16:32 -0300
Subject: [RFC PATCH 00/28] Removing struct page from P2PDMA
In-Reply-To: <7210ba39-c923-79ca-57bb-7cf9afe21d54@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
 <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com>
 <20190620193353.GF19891@ziepe.ca> <20190624073126.GB3954@lst.de>
 <20190624134641.GA8268@ziepe.ca> <20190624135024.GA11248@lst.de>
 <20190624135550.GB8268@ziepe.ca>
 <7210ba39-c923-79ca-57bb-7cf9afe21d54@deltatee.com>
Message-ID: <20190624181632.GC8268@ziepe.ca>

On Mon, Jun 24, 2019@10:53:38AM -0600, Logan Gunthorpe wrote:
> > It is only a very narrow case where you can take shortcuts with
> > dma_addr_t, and I don't think shortcuts like are are appropriate for
> > the mainline kernel..
> 
> I don't think it's that narrow and it opens up a lot of avenues for
> system design that people are wanting to go. If your high speed data
> path can avoid the root complex and CPU, you can design a system which a
> much smaller CPU and fewer lanes directed at the CPU.

I mean the shortcut that something generates dma_addr_t for Device A
and then passes it to Device B - that is too hacky for mainline.

Sounded like this series does generate the dma_addr for the correct
device..

Jason
