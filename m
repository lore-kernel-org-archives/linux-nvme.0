From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Sep 2018 21:22:52 +0200
Subject: [PATCH v5 10/13] nvme-pci: Add support for P2P memory in requests
In-Reply-To: <d5548f5d-59df-f38e-255d-59b46a17a219@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-11-logang@deltatee.com>
 <20180904151638.GL335@mellanox.com>
 <d5548f5d-59df-f38e-255d-59b46a17a219@deltatee.com>
Message-ID: <20180905192252.GA888@lst.de>

On Tue, Sep 04, 2018@09:47:07AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 04/09/18 09:16 AM, Jason Gunthorpe wrote:
> >>  	if (iod->nents) {
> >> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> >> +		/* P2PDMA requests do not need to be unmapped */
> >> +		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
> >> +			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> > 
> > This seems like a poor direction, if we add IOMMU hairpin support we
> > will need unmapping.
> 
> It can always be added later. In any case, you'll have to convince
> Christoph who requested the change; I'm not that invested in this decision.

Yes, no point to add dead code here.  In the long run we should
aim for hiding the p2p address translation behind the normal DMA API
anyway, but we're not quite ready for it yet.
