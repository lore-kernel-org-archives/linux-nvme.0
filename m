From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 18 Apr 2017 14:06:14 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <20170418194845.GA22895@obsidianresearch.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <20170418194845.GA22895@obsidianresearch.com>
Message-ID: <643a2bf3-c60d-b0d1-666b-ff33b360723e@deltatee.com>



On 18/04/17 01:48 PM, Jason Gunthorpe wrote:
> I think this is why progress on this keeps getting stuck - every
> solution is a lot of work.

Yup! There's also a ton of work just to get the iomem safety issues
addressed. Let alone the dma mapping issues.

> You could try to do a dummy mapping / create a MR early on to detect
> this.

Ok, that could be a workable solution.

> FWIW, I wonder if from a RDMA perspective we have another
> problem.. Should we allow P2P memory to be used with the local DMA
> lkey? There are potential designs around virtualization that would not
> allow that. Should we mandate that P2P memory be in its own MR?

I can't say I understand these issues...

Logan
