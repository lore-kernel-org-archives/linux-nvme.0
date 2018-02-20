From: keith.busch@intel.com (Keith Busch)
Date: Tue, 20 Feb 2018 09:06:04 -0700
Subject: nvme-pci: about page_size of DMA pool
In-Reply-To: <2dfcc20c-a0c4-d01a-cde8-01662202cff8@gmail.com>
References: <2dfcc20c-a0c4-d01a-cde8-01662202cff8@gmail.com>
Message-ID: <20180220160603.GB7076@localhost.localdomain>

On Sun, Feb 18, 2018@04:52:34PM +0900, Minwoo Im wrote:
> It seems that _PAGE_SIZE_ and _dev->ctrl.page_size_ might be different.
> For now, nvme_setup_prp_pools() attempts to create PRP page DMA pool
> with PAGE_SIZE instead of dev->ctrl.page_size.
>
> By the way, in nvme_pci_setup_prps(), PRP lists are built by
> dev->ctrl.page_size like following code.
> 
> for (;;) {
>         if (i == page_size >> 3) {
>                  ^^^^^^^^^
>             __le64 *old_prp_list = prp_list;
>             prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
> 
> if dev->ctrl.page_size should be used as is, I guess DMA pool should be
> created in dev->ctrl.page_size (But at that time of
> nvme_setup_prp_pools(), dev->ctrl.page_size may not be set properly)
> somehow instead of PAGE_SIZE.

Good point, but as long as we know it's hard-coded to 4k, the order
doesn't really matter.

> Additionally, It seems that page_shift in nvme_enable_ctrl() is now
> hard-coded to 12 which means dev->ctrl.page_size will always be 4096,
> though.
> 
> 
> Q1. Should dev->prp_page_pool be created with dev->ctrl.page_size
> instead of PAGE_SIZE?

Yeah, the current method looks like it may potentially be over-allocating
some memory for very large IO transfers. The size of the "large" pool
ought to be the same as ctrl.page_size.
 
> 
> Q2. Is there any special reason why page_shift in nvme_enable_ctrl()
> is hard-coded to 12, not PAGE_SHIFT?

Some CPU architectures have different alignment when comparing DMA mapped
addresses with the virual address, so we have to go to the lowest common
denominator. Previous discussion here:

  http://lists.infradead.org/pipermail/linux-nvme/2015-October/002893.html
