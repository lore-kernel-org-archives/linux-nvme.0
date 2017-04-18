From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 18 Apr 2017 13:45:15 -0500
Subject: provide pci_request_irq / pci_free_irq helpers
In-Reply-To: <20170413070643.32165-1-hch@lst.de>
References: <20170413070643.32165-1-hch@lst.de>
Message-ID: <20170418184515.GD25295@bhelgaas-glaptop.roam.corp.google.com>

On Thu, Apr 13, 2017@09:06:39AM +0200, Christoph Hellwig wrote:
> PCI drivers that support multiple MSI or MSI-X vectors currently have a
> lot of boileplate code to generate names for each vector (or simply use
> the same name for all of them, which isn't nice either).  This series
> adds new helpers that allocate and free a name based on a format string
> passed to the request_irq wrapper.
> 
> They also hide the [pci_dev,vector] to Linux irq number translation,
> in fact the example NVMe driver conversion now never sees the Linux irq
> number.  That might be useful to isolate PCI drivers from our IRQ numbers,
> although to have a full abstraction we'd need similar wrappers for
> {enable,disable,synchronize}_irq as well.

Applied with reviewed-by from Thomas and Keith to pci/irq for v4.12,
thanks!
