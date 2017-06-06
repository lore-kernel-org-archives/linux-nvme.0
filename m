From: hch@lst.de (Christoph Hellwig)
Date: Tue, 6 Jun 2017 12:48:36 +0200
Subject: [PATCH 1/3] PCI: ensure the PCI device is locked over
 ->reset_notify calls
In-Reply-To: <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601111039.8913-1-hch@lst.de>
 <20170601111039.8913-2-hch@lst.de>
 <20170606053142.GA25064@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170606104836.GB24297@lst.de>

On Tue, Jun 06, 2017@12:31:42AM -0500, Bjorn Helgaas wrote:
> OK, sorry to be dense; it's taking me a long time to work out the
> details here.  It feels like there should be a general principle to
> help figure out where we need locking, and it would be really awesome
> if we could include that in the changelog.  But it's not obvious to me
> what that principle would be.

The principle is very simple: every method in struct device_driver
or structures derived from it like struct pci_driver MUST provide
exclusion vs ->remove.  Usuaull by using device_lock().

If we don't provide such an exclusion the method call can race with
a removal in one form or another.

> But I'm still nervous because I think both threads will queue
> nvme_reset_work() work items for the same device, and I'm not sure
> they're prepared to run concurrently.

We had another bug in that area, and the fix for that is hopefully
going to go into the next 4.12-rc.

> I don't really think it should be the driver's responsibility to
> understand issues like this and worry about things like
> nvme_reset_work() running concurrently.  So I'm thinking maybe the PCI
> core needs to be a little stricter here, but I don't know exactly
> *how*.
> 
> What do you think?

The driver core / bus driver must ensure that method calls don't
race with ->remove.  There is nothing the driver can do about it,
and the race is just as possible with explicit user removals or
hardware hotplug.
