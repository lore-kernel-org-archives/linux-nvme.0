From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Apr 2017 16:42:25 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <CAPcyv4haUUs1Eew1PZTZkoGU4YFiHOuU93G+kG+CqfKzjz1gpw@mail.gmail.com>
References: <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <CAPcyv4h9n9Uzq4FAXR0ufieqvx5_txEwtnaaBWdxe-jF_XfTLg@mail.gmail.com>
 <20170418212258.GA26838@obsidianresearch.com>
 <CAPcyv4g5ifbpukthMXMro8qKdfoXAhftDpiwWWFCLZ4dK8JnnA@mail.gmail.com>
 <96198489-1af5-abcf-f23f-9a7e41aa17f7@deltatee.com>
 <CAPcyv4haUUs1Eew1PZTZkoGU4YFiHOuU93G+kG+CqfKzjz1gpw@mail.gmail.com>
Message-ID: <20170418224225.GB27113@obsidianresearch.com>

On Tue, Apr 18, 2017@03:28:17PM -0700, Dan Williams wrote:

> Unlike the pci bus address offset case which I think is fundamental to
> support since shipping archs do this toda

But we can support this by modifying those arch's unique dma_ops
directly.

Eg as I explained, my p2p_same_segment_map_page() helper concept would
do the offset adjustment for same-segement DMA.

If PPC calls that in their IOMMU drivers then they will have proper
support for this basic p2p, and the right framework to move on to more
advanced cases of p2p.

This really seems like much less trouble than trying to wrapper all
the arch's dma ops, and doesn't have the wonky restrictions.

> I think it is ok to say p2p is restricted to a single sgl that gets
> to talk to host memory or a single device.

RDMA and GPU would be sad with this restriction...

> That said, what's wrong with a p2p aware map_sg implementation
> calling up to the host memory map_sg implementation on a per sgl
> basis?

Setting up the iommu is fairly expensive, so getting rid of the
batching would kill performance..

Jason
