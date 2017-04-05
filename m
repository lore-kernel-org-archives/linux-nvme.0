From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Apr 2017 21:43:57 +0200
Subject: [PATCH] nvme: avoid NULL pointer dereference in error recovery
 path
In-Reply-To: <20170405194037.1019-1-gpiccoli@linux.vnet.ibm.com>
References: <20170405194037.1019-1-gpiccoli@linux.vnet.ibm.com>
Message-ID: <20170405194357.GA11705@lst.de>

On Wed, Apr 05, 2017@04:40:37PM -0300, Guilherme G. Piccoli wrote:
> It's possible that driver fails to recover from a PCI error and the
> PCI core (or arch PCI specifics, like EEH in PowerPC) starts a process
> of device removal. While this removal process is happening, if another
> PCI error is triggered, we might have a NULL address for
> "struct *nvme_dev", pointed by "pci_dev *driver_data" - for example this
> happens if nvme_remove() already have set that pci_dev struct's field
> to NULL.
> 
> In this case, the driver error handler functions will dereferece a NULL
> pointer, causing a kernel oops. This patch checks for NULL pointer on
> error handlers and in case "driver_data" points to NULL, it aborts the
> error recovery path and return a fail error value to PCI core.

I think this needs to be fixed at a higher level, that is the PCI
core.  Once you have the callbacks run in parallel a simple null check
isn't going to fix this but every single access to the structure
is a possible use after free.
