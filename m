From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 2 May 2016 08:11:24 -0500
Subject: [PATCH 6/8] pci: provide sensible irq vector alloc/free routines
In-Reply-To: <20160501180149.GA11131@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
 <1460770552-31260-7-git-send-email-hch@lst.de>
 <20160429211638.GB28261@localhost> <20160501180149.GA11131@lst.de>
Message-ID: <20160502131124.GA18527@localhost>

On Sun, May 01, 2016@08:01:49PM +0200, Christoph Hellwig wrote:
> FYI, I spent some time trying to convert more drivers to this, and
> I think we'll need an additional flag to skip MSI or MSI-X as there
> is plenty of hardware claiming support in the capabilities flag,
> but not actually supporting one of them.

Or maybe add a "pdev->msix_broken" bit and quirks to set it?  Or if
pci_fixup_final quirks merely cleared pdev->msix_cap, I think the PCI
core would never try to enable MSI-X.
