From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 2 May 2016 10:29:29 -0500
Subject: [PATCH 6/8] pci: provide sensible irq vector alloc/free routines
In-Reply-To: <20160502144203.GA32221@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
 <1460770552-31260-7-git-send-email-hch@lst.de>
 <20160429211638.GB28261@localhost> <20160501180149.GA11131@lst.de>
 <20160502131124.GA18527@localhost> <20160502144203.GA32221@lst.de>
Message-ID: <20160502152929.GA24851@localhost>

On Mon, May 02, 2016@04:42:03PM +0200, Christoph Hellwig wrote:
> On Mon, May 02, 2016@08:11:24AM -0500, Bjorn Helgaas wrote:
> > On Sun, May 01, 2016@08:01:49PM +0200, Christoph Hellwig wrote:
> > > FYI, I spent some time trying to convert more drivers to this, and
> > > I think we'll need an additional flag to skip MSI or MSI-X as there
> > > is plenty of hardware claiming support in the capabilities flag,
> > > but not actually supporting one of them.
> > 
> > Or maybe add a "pdev->msix_broken" bit and quirks to set it?  Or if
> > pci_fixup_final quirks merely cleared pdev->msix_cap, I think the PCI
> > core would never try to enable MSI-X.
> 
> Can't say I'm excited about quirks - now we'd have to patch core
> code for something that previously was entirely in the driver.

Yeah, you're right.  I was imagining a quirk in the driver itself, but
now that I look at it, I don't see any infrastructure for that.  I
think there are a lot of existing quirks that could be moved from the
core to a driver if we had support for quirks in drivers.

It just seems a shame to complicate the pci_alloc_irq_vectors()
interface with flags about broken devices.

I guess if we added a "pdev->msix_broken" bit, it would be visible to
drivers, and they could easily set it themselves in their .probe()
methods even without any actual quirk mechanism.  But a flag to
pci_alloc_irq_vectors() would certainly be more direct.
