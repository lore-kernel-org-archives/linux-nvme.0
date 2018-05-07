From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 7 May 2018 18:02:08 -0500
Subject: [PATCH v4 03/14] PCI/P2PDMA: Add PCI p2pmem dma mappings to
 adjust the bus offset
In-Reply-To: <20180423233046.21476-4-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-4-logang@deltatee.com>
Message-ID: <20180507230208.GF161390@bhelgaas-glaptop.roam.corp.google.com>

s/dma/DMA/ (in subject)

On Mon, Apr 23, 2018@05:30:35PM -0600, Logan Gunthorpe wrote:
> The DMA address used when mapping PCI P2P memory must be the PCI bus
> address. Thus, introduce pci_p2pmem_[un]map_sg() to map the correct
> addresses when using P2P memory.
> 
> For this, we assume that an SGL passed to these functions contain all
> P2P memory or no P2P memory.
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
