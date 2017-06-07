From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Jun 2017 20:29:36 +0200
Subject: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
In-Reply-To: <20170606211443.GB12672@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601111039.8913-1-hch@lst.de>
 <20170601111039.8913-2-hch@lst.de>
 <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
 <20170606104836.GB24297@lst.de>
 <20170606211443.GB12672@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170607182936.GA31815@lst.de>

On Tue, Jun 06, 2017@04:14:43PM -0500, Bjorn Helgaas wrote:
> So I guess the method here is
> dev->driver->err_handler->reset_notify(), and the PCI core should be
> holding device_lock() while calling it?  That makes sense to me;
> thanks a lot for articulating that!

Yes.

> 1) The current patch protects the err_handler->reset_notify() uses by
> adding or expanding device_lock regions in the paths that lead to
> pci_reset_notify().  Could we simplify it by doing the locking
> directly in pci_reset_notify()?  Then it would be easy to verify the
> locking, and we would be less likely to add new callers without the
> proper locking.

We could do that, except that I'd rather hold the lock over a longer
period if we have many calls following each other.  I also have
a patch to actually kill pci_reset_notify() later in the series as
well, as the calling convention for it and ->reset_notify() are
awkward - depending on prepare parameter they do two entirely
different things.  That being said I could also add new
pci_reset_prepare() and pci_reset_done() helpers.

> 2) Stating the rule explicitly helps look for other problems, and I
> think we have a similar problem in all the pcie_portdrv_err_handler
> methods.

Yes, I mentioned this earlier, and I also vaguely remember we got
bug reports from IBM on power for this a while ago.  I just don't
feel confident enough to touch all these without a good test plan.
