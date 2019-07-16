From: hch@lst.de (Christoph Hellwig)
Date: Tue, 16 Jul 2019 21:12:41 +0200
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <20190716124741.GA2853@ming.t460p>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
 <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
 <20190716093617.GB32562@lst.de> <20190716124741.GA2853@ming.t460p>
Message-ID: <20190716191241.GA9666@lst.de>

On Tue, Jul 16, 2019@08:47:42PM +0800, Ming Lei wrote:
> > No, with swiotlb it really is the whole request size that ?s limited
> > by the swiotlb buffer size.  Similar for potential iommus where
> > again it is the whole thing.
> 
> Documentation/DMA-API.txt:
> 
> 		size_t
> 		dma_max_mapping_size(struct device *dev);
> 	
> 	Returns the maximum size of a mapping for the device. The size parameter
> 	of the mapping functions like dma_map_single(), dma_map_page() and
> 	others should not be larger than the returned value.
> 
> And dma_map_single() & dma_map_page() is usually for mapping single
> element of SGL, instead of whole SGL.

... and others.  And if you look at the actual swiotlb code it is
pretty clear that the whole request counts.  But I'll make sure to
make clarify the documentation when fixing the issue.
