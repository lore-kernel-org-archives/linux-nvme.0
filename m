From: keith.busch@intel.com (Keith Busch)
Date: Tue, 25 Sep 2018 11:11:48 -0600
Subject: [PATCH v7 10/13] nvme-pci: Add support for P2P memory in requests
In-Reply-To: <20180925162231.4354-11-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-11-logang@deltatee.com>
Message-ID: <20180925171147.GB11822@localhost.localdomain>

On Tue, Sep 25, 2018@10:22:28AM -0600, Logan Gunthorpe wrote:
> For P2P requests, we must use the pci_p2pmem_map_sg() function
> instead of the dma_map_sg functions.

Sorry if this was already discussed. Is there a reason the following
pattern is not pushed to the generic dma_map_sg_attrs?

	if (is_pci_p2pdma_page(sg_page(sg)))
		pci_p2pdma_map_sg(dev, sg, nents, dma_dir);

Beyond that, series looks good.
