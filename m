From: jgg@mellanox.com (Jason Gunthorpe)
Date: Thu, 25 Jul 2019 19:29:49 +0000
Subject: [PATCH 11/14] PCI/P2PDMA: dma_map P2PDMA map requests that
 traverse the host bridge
In-Reply-To: <cf61d237-8a8a-e3ac-a9df-466f20b63020@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-12-logang@deltatee.com>
 <20190725185830.GH7450@mellanox.com>
 <cf61d237-8a8a-e3ac-a9df-466f20b63020@deltatee.com>
Message-ID: <20190725192944.GI7450@mellanox.com>

On Thu, Jul 25, 2019@01:17:02PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 12:58 p.m., Jason Gunthorpe wrote:
> > On Mon, Jul 22, 2019@05:08:56PM -0600, Logan Gunthorpe wrote:
> >> Any requests that traverse the host bridge will need to be mapped into
> >> the IOMMU, so call dma_map_sg() inside pci_p2pdma_map_sg() when
> >> appropriate.
> >>
> >> Similarly, call dma_unmap_sg() inside pci_p2pdma_unmap_sg().
> >>
> >> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> >>  drivers/pci/p2pdma.c | 31 ++++++++++++++++++++++++++++++-
> >>  1 file changed, 30 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> >> index 5f43f92f9336..76f51678342c 100644
> >> +++ b/drivers/pci/p2pdma.c
> >> @@ -830,8 +830,22 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> >>  		int nents, enum dma_data_direction dir, unsigned long attrs)
> >>  {
> >>  	struct dev_pagemap *pgmap = sg_page(sg)->pgmap;
> >> +	struct pci_dev *client;
> >> +	int dist;
> >> +
> >> +	client = find_parent_pci_dev(dev);
> >> +	if (WARN_ON_ONCE(!client))
> >> +		return 0;
> >>  
> >> -	return __pci_p2pdma_map_sg(pgmap, dev, sg, nents);
> >> +	dist = upstream_bridge_distance(pgmap->pci_p2pdma_provider,
> >> +					client, NULL);

Isn't is a bit of a leap to assume that the pgmap is uniform across
all the sgs?

> >> +	if (WARN_ON_ONCE(dist & P2PDMA_NOT_SUPPORTED))
> >> +		return 0;
> >> +
> >> +	if (dist & P2PDMA_THRU_HOST_BRIDGE)
> >> +		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
> > 
> > IIRC at this point the SG will have struct page references to the BAR
> > memory - so (all?) the IOMMU drivers are able to handle P2P setup in
> > this case?
> 
> Yes. The IOMMU drivers refer to the physical address for BAR which they
> can get from the struct page. And this works fine today.

Interesting.

So, for the places where we already map BAR memory to userspace, if I
were to make struct pages for those BARs and use vm_insert_page()
instead of io_remap_pfn_range(), then the main thing missing in RDMA
to actually do P2P DMA is a way to get those struct pages out of
get_user_pages and know to call the pci_p2pdma_map_sg version (ie in
ib_umem_get())?

Jason
