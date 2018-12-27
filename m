From: hch@lst.de (Christoph Hellwig)
Date: Thu, 27 Dec 2018 14:08:34 +0100
Subject: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors
 again in case of -EINVAL
In-Reply-To: <20181227082136.GA14423@ming.t460p>
References: <20181226103755.2101-1-ming.lei@redhat.com>
 <20181226103755.2101-3-ming.lei@redhat.com> <20181226182027.GA5866@lst.de>
 <20181227082136.GA14423@ming.t460p>
Message-ID: <20181227130834.GA22967@lst.de>

On Thu, Dec 27, 2018@04:21:38PM +0800, Ming Lei wrote:
> On Wed, Dec 26, 2018@07:20:27PM +0100, Christoph Hellwig wrote:
> > On Wed, Dec 26, 2018@06:37:55PM +0800, Ming Lei wrote:
> > > It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
> > > returns -EINVAL when the requested number is too big(such as 64).
> > 
> > Which is not how this API is supposed to work and documented to work.
> > 
> > We need to fix pci_alloc_irq_vectors_affinity to not return a spurious
> > error and just return the allocated number of vectors instead of
> > hacking around that in drivers.
> 
> Yeah, you are right.
> 
> The issue is that QEMU nvme-pci is MSIX-capable only, and hasn't MSI
> capability.
> 
> __pci_enable_msix_range() actually returns -ENOSPC, but __pci_enable_msi_range()
> returns -EINVAL because dev->msi_cap is zero.
> 
> Maybe we need the following fix?

Should it matter?  We still get a negative vecs back, and still fall
back to the next option.  Unless ther are no irqs available at all
for the selected types pci_alloc_irq_vectors_affinity should never
return an error.
