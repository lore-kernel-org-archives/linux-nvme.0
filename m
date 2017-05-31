From: hch@lst.de (Christoph Hellwig)
Date: Wed, 31 May 2017 06:58:48 +0200
Subject: [PATCH] PCI: ensure the PCI device is locked over
 ->reset_notify calls
In-Reply-To: <20170530222844.GE14896@bhelgaas-glaptop.roam.corp.google.com>
References: <20170523054202.7985-1-hch@lst.de>
 <20170523054202.7985-2-hch@lst.de>
 <20170530222844.GE14896@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170531045848.GA4001@lst.de>

On Tue, May 30, 2017@05:28:44PM -0500, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> On Tue, May 23, 2017@07:42:02AM +0200, Christoph Hellwig wrote:
> > Without this ->notify_reset instance may race with ->remove calls,
> 
> Do you mean the .reset_notify() method in struct pci_error_handlers?
> I don't see a "notify_reset" symbol.

Yes.

> Can you elaborate on exactly how this race happens?  I'm trying to
> figure out whether this is also a problem or potential problem with
> other reset paths like pci_try_reset_function(), pci_reset_bus(),
> pci_try_reset_bus(), pci_reset_slot(), and pci_try_reset_slot().
> 
> What does the race look like when it happens?  Oops, panic, etc?
> 
> Can this also be triggered via the sysfs "reset" file?

Here is the original bug report:

http://lists.infradead.org/pipermail/linux-nvme/2017-May/010345.html

the issue is triggered through sysfs.
