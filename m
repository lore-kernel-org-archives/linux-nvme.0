From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 Jan 2018 18:50:16 -0700
Subject: [PATCH] nvme-pci: take sglist coalescing in dma_map_sg into
 account
In-Reply-To: <20180115173716.22409-1-hch@lst.de>
References: <20180115173716.22409-1-hch@lst.de>
Message-ID: <20180116015016.GD32369@localhost.localdomain>

On Mon, Jan 15, 2018@06:37:16PM +0100, Christoph Hellwig wrote:
> Some iommu implementations can merge physically and/or virtually
> contiguous segments inside sg_map_dma.  The NVMe SGL support does not take
> this into account and will warn because of falling off a loop.  Pass the
> number of mapped segments to nvme_pci_setup_sgls so that the SGL setup
> can take the number of mapped segments into account.
> 
> Reported-by: Fangjian (Turing) <f.fangjian at huawei.com>
> Fixes: a7a7cbe3 ("nvme-pci: add SGL support")
> Signed-off-by: Christoph Hellwig <hch at lst.de>

This looks fine, but I think keeping tabs on on the mapped length wouldn't
hurt since a mismatch is a software bug that would be difficult to debug
later. But if you trust it's not necessary, that's good enough for me.
