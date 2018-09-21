From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 21 Sep 2018 11:48:13 -0500
Subject: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
In-Reply-To: <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
 <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>

On Fri, Sep 21, 2018@08:15:50AM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 12, 2018@06:11:46PM -0600, Logan Gunthorpe wrote:
> > The DMA address used when mapping PCI P2P memory must be the PCI bus
> > address. Thus, introduce pci_p2pmem_map_sg() to map the correct
> > addresses when using P2P memory. Memory mapped in this way does not
> > need to be unmapped.
> 
> I think the use of "map" in this context is slightly confusing because the
> general expectation is that map/unmap must be balanced.
> 
> I assume it's because the "mapping" consumes no resources, e.g., requires
> no page table entries.  Possibly there's a better verb than "map", e.g.,
> "convert", "convert_to_p2pdma", etc?
> 
> If you keep "map", maybe add a sentence or two about why there's no
> corresponding unmap?

Another wrinkle is that "map" usually takes an A and gives you back a
B.  Now the caller has both A and B and both are still valid.

Here we pass in an SGL and the SGL is transformed, so the caller only
has B and A has been destroyed, i.e., the SGL can no longer be used as
it was before, and there's no way to get A back.

Maybe this is pointless bikeshedding, so if your color is the best,
don't change anything.

Bjorn
