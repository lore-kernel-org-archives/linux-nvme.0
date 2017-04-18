From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Apr 2017 13:48:45 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
Message-ID: <20170418194845.GA22895@obsidianresearch.com>

On Tue, Apr 18, 2017@01:35:32PM -0600, Logan Gunthorpe wrote:

> > Ultimately every dma_ops will need special code to support P2P with
> > the special hardware that ops is controlling, so it makes some sense
> > to start by pushing the check down there in the first place. This
> > advice is partially motivated by how dma_map_sg is just a small
> > wrapper around the function pointer call...
> 
> Yes, I noticed this problem too and that makes sense. It just means
> every dma_ops will probably need to be modified to either support p2p
> pages or fail on them. Though, the only real difficulty there is that it
> will be a lot of work.

I think this is why progress on this keeps getting stuck - every
solution is a lot of work.

> > Where p2p_same_segment_map_page checks if the two devices are on the
> > 'same switch' and if so returns the address translated to match the
> > bus address programmed into the BAR or fails. We knows this case is
> > required to work by the PCI spec, so it makes sense to use it as the
> > first canned helper.
> 
> I've also suggested that this check should probably be done (or perhaps
> duplicated) before we even get to the map stage.

Since the mechanics of the check is essentially unique to every
dma-ops I would not hoist it out of the map function without a really
good reason.

> In the case of nvme-fabrics we'd probably want to let the user know
> when they try to configure it or at least fall back to allocating
> regular memory instead.

You could try to do a dummy mapping / create a MR early on to detect
this.

FWIW, I wonder if from a RDMA perspective we have another
problem.. Should we allow P2P memory to be used with the local DMA
lkey? There are potential designs around virtualization that would not
allow that. Should we mandate that P2P memory be in its own MR?

Jason
