From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 21 Sep 2018 14:01:13 -0600
Subject: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
In-Reply-To: <20180921200021.GN224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
 <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
 <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
 <506dd00c-35e9-e285-bc97-c689c766b4cf@deltatee.com>
 <20180921200021.GN224714@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <cf4ead8f-9dde-ba3b-3c87-71f73cebee74@deltatee.com>

On 2018-09-21 2:00 PM, Bjorn Helgaas wrote:
> Ok.  I was assuming s->dma_address would have been already set before
> the call and would be overwritten by pci_p2pmem_map_sg().  But I guess
> that's not the case -- sounds like s->dma_address is undefined before
> the call.

Correct. It's set by whatever dma_map function operates on it.

Logan
