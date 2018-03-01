From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Mar 2018 13:07:41 +0200
Subject: [PATCH v2 08/10] nvme-pci: Add support for P2P memory in requests
In-Reply-To: <20180228234006.21093-9-logang@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-9-logang@deltatee.com>
Message-ID: <c6639530-48ba-4655-c772-7d88a030e37e@grimberg.me>


> For P2P requests we must use the pci_p2pmem_[un]map_sg() functions
> instead of the dma_map_sg functions.
> 
> With that, we can then indicate PCI_P2P support in the request queue.
> For this, we create an NVME_F_PCI_P2P flag which tells the core to
> set QUEUE_FLAG_PCI_P2P in the request queue.

This looks fine to me,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Any plans adding the capability to nvme-rdma? Should be
straight-forward... In theory, the use-case would be rdma backend
fabric behind. Shouldn't be hard to test either...
