From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 16 May 2016 14:39:29 -0500
Subject: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
In-Reply-To: <20160509224631.GB18501@localhost>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160509224631.GB18501@localhost>
Message-ID: <20160516193929.GA20759@localhost>

On Mon, May 09, 2016@05:46:31PM -0500, Bjorn Helgaas wrote:
> On Thu, May 05, 2016@04:04:55PM +0200, Christoph Hellwig wrote:
> > Add a new pci_alloc_irq_vectors helper that allocates MSI-X or multi-MSI
> > vectors for PCI device while isolating the driver from the arcane details.
> > 
> > This include handling both MSI-X, MSI and legacy interrupt fallbacks
> > transparently, automatic capping to the available vectors as well as storing
> > the information needed for request_irq in the PCI device itself so that
> > a lot of boiler plate code in the driver can be removed.
> > 
> > In the future this will also allow us to automatically set up spreading
> > for interrupt vectors without having to duplicate it in all the drivers.
> > 
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> 
> Thanks, I applied this to pci/msi for v4.7.

Given the subsequent discussion, it seems a little premature to merge
this for v4.7, so I'm dropping this for now.

Bjorn
