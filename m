From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 16 Jul 2019 20:47:42 +0800
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <20190716093617.GB32562@lst.de>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
 <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
 <20190716093617.GB32562@lst.de>
Message-ID: <20190716124741.GA2853@ming.t460p>

On Tue, Jul 16, 2019@11:36:17AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019@03:12:06PM +0800, Ming Lei wrote:
> > It should be caused by the following commit, and that patch uses
> > single mapping size to limit max hw sectors, and looks that way
> > is wrong. For example, on qemu, max_hw_sectors is decreased to
> > 512. You can try to revert the patch and see if it makes a difference.
> > 
> > I feel we might need the max segment size limit too.
> 
> No, with swiotlb it really is the whole request size that ?s limited
> by the swiotlb buffer size.  Similar for potential iommus where
> again it is the whole thing.

Documentation/DMA-API.txt:

		size_t
		dma_max_mapping_size(struct device *dev);
	
	Returns the maximum size of a mapping for the device. The size parameter
	of the mapping functions like dma_map_single(), dma_map_page() and
	others should not be larger than the returned value.

And dma_map_single() & dma_map_page() is usually for mapping single
element of SGL, instead of whole SGL.

Thanks,
Ming
