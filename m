From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 17 Jan 2018 10:30:44 +0200
Subject: [PATCH] nvme-pci: take sglist coalescing in dma_map_sg into
 account
In-Reply-To: <20180115173716.22409-1-hch@lst.de>
References: <20180115173716.22409-1-hch@lst.de>
Message-ID: <606d11cb-749a-4c09-1167-cb5c27fba94d@grimberg.me>


> Some iommu implementations can merge physically and/or virtually
> contiguous segments inside sg_map_dma.  The NVMe SGL support does not take
> this into account and will warn because of falling off a loop.  Pass the
> number of mapped segments to nvme_pci_setup_sgls so that the SGL setup
> can take the number of mapped segments into account.
> 
> Reported-by: Fangjian (Turing) <f.fangjian at huawei.com>
> Fixes: a7a7cbe3 ("nvme-pci: add SGL support")
> Signed-off-by: Christoph Hellwig <hch at lst.de>

This looks good Christoph,

Reviewed-by: Sagi Grimberg <sagi at rimberg.me>
