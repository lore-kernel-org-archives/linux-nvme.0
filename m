From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Apr 2017 10:00:40 -0400
Subject: offest calculation from the dma_address
In-Reply-To: <20170414135451.515c3a53134384c388071989@gmail.com>
References: <20170414135451.515c3a53134384c388071989@gmail.com>
Message-ID: <20170414140040.GA19243@localhost.localdomain>

On Fri, Apr 14, 2017@01:54:51PM +0300, alexnln wrote:
> In pci.c, in nvme_setup_prps() offset is calculated from the dma address:
> int offset = dma_addr & (page_size - 1);
> 
> Why not to use sg->offset?

PRP lists are constructed from DMA addresses, so the DMA address offset
is the one to use. Kernel virtual addresses don't necessarilly have the
same page offset as DMA addresses.
 
> I mean, what if hypothetical dma allocator returns non-page aligned addresses?
> In such case offset would be wrong.

I don't follow. If the DMA address isn't page aligned, we need to
account for that when constructing the PRP.
