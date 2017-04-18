From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Apr 2017 17:21:59 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <CAPcyv4gQxifHcKLv0CZZoXJWz=rtzv-vGoofkek6NxRABd4XyA@mail.gmail.com>
References: <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <CAPcyv4h9n9Uzq4FAXR0ufieqvx5_txEwtnaaBWdxe-jF_XfTLg@mail.gmail.com>
 <20170418212258.GA26838@obsidianresearch.com>
 <CAPcyv4g5ifbpukthMXMro8qKdfoXAhftDpiwWWFCLZ4dK8JnnA@mail.gmail.com>
 <96198489-1af5-abcf-f23f-9a7e41aa17f7@deltatee.com>
 <CAPcyv4haUUs1Eew1PZTZkoGU4YFiHOuU93G+kG+CqfKzjz1gpw@mail.gmail.com>
 <20170418224225.GB27113@obsidianresearch.com>
 <CAPcyv4gQxifHcKLv0CZZoXJWz=rtzv-vGoofkek6NxRABd4XyA@mail.gmail.com>
Message-ID: <20170418232159.GA28477@obsidianresearch.com>

On Tue, Apr 18, 2017@03:51:27PM -0700, Dan Williams wrote:
> > This really seems like much less trouble than trying to wrapper all
> > the arch's dma ops, and doesn't have the wonky restrictions.
> 
> I don't think the root bus iommu drivers have any business knowing or
> caring about dma happening between devices lower in the hierarchy.

Maybe not, but performance requires some odd choices in this code.. :(

> > Setting up the iommu is fairly expensive, so getting rid of the
> > batching would kill performance..
> 
> When we're crossing device and host memory boundaries how much
> batching is possible? As far as I can see you'll always be splitting
> the sgl on these dma mapping boundaries.

Splitting the sgl is different from iommu batching.

As an example, an O_DIRECT write of 1 MB with a single 4K P2P page in
the middle.

The optimum behavior is to allocate a 1MB-4K iommu range and fill it
with the CPU memory. Then return a SGL with three entires, two
pointing into the range and one to the p2p.

It is creating each range which tends to be expensive, so creating two
ranges (or worse, if every SGL created a range it would be 255) is
very undesired.

Jason
