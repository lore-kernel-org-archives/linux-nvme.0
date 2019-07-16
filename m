From: hch@lst.de (Christoph Hellwig)
Date: Tue, 16 Jul 2019 11:36:17 +0200
Subject: nvme-5.3 ssd performance regression
In-Reply-To: <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
References: <798a3907573b910fbb102036afe3dfc1405fb353.camel@kernel.crashing.org>
 <CACVXFVP8w3mzQ8XVgeif=Nq3kyiZopS0XDB+-c2x5CcT9V3djA@mail.gmail.com>
Message-ID: <20190716093617.GB32562@lst.de>

On Tue, Jul 16, 2019@03:12:06PM +0800, Ming Lei wrote:
> It should be caused by the following commit, and that patch uses
> single mapping size to limit max hw sectors, and looks that way
> is wrong. For example, on qemu, max_hw_sectors is decreased to
> 512. You can try to revert the patch and see if it makes a difference.
> 
> I feel we might need the max segment size limit too.

No, with swiotlb it really is the whole request size that ?s limited
by the swiotlb buffer size.  Similar for potential iommus where
again it is the whole thing.

But looking at the implementation of dma_direct_max_mapping_size I
think we need to relax it - it currently limits the size as soon
as swiotlb is enabled, and not just if we need it for a given device.

We have some open coded versions of those checks elsewhere, let me
cook up a series to sort that mess out.

Ben, in then meantime can you try a revert of the commit Ming identified?
That is obviously not the proper fix, but it would help validating the
hypothesis.
