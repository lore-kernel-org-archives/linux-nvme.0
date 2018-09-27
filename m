From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 27 Sep 2018 11:10:38 -0600
Subject: [PATCH v8 10/13] nvme-pci: Add support for P2P memory in requests
In-Reply-To: <20180927165420.5290-11-logang@deltatee.com>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-11-logang@deltatee.com>
Message-ID: <20180927171038.GD19589@localhost.localdomain>

On Thu, Sep 27, 2018@10:54:17AM -0600, Logan Gunthorpe wrote:
> For P2P requests, we must use the pci_p2pmem_map_sg() function
> instead of the dma_map_sg functions.
> 
> With that, we can then indicate PCI_P2P support in the request queue.
> For this, we create an NVME_F_PCI_P2P flag which tells the core to
> set QUEUE_FLAG_PCI_P2P in the request queue.
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Looks good to me as well.

Reviewed-by: Keith Busch <keith.busch at intel.com>
