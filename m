From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 27 Dec 2018 16:21:38 +0800
Subject: [PATCH 2/2] nvme pci: try to allocate multiple irq vectors again
 in case of -EINVAL
In-Reply-To: <20181226182027.GA5866@lst.de>
References: <20181226103755.2101-1-ming.lei@redhat.com>
 <20181226103755.2101-3-ming.lei@redhat.com>
 <20181226182027.GA5866@lst.de>
Message-ID: <20181227082136.GA14423@ming.t460p>

On Wed, Dec 26, 2018@07:20:27PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 26, 2018@06:37:55PM +0800, Ming Lei wrote:
> > It is observed on QEMU that pci_alloc_irq_vectors_affinity() may
> > returns -EINVAL when the requested number is too big(such as 64).
> 
> Which is not how this API is supposed to work and documented to work.
> 
> We need to fix pci_alloc_irq_vectors_affinity to not return a spurious
> error and just return the allocated number of vectors instead of
> hacking around that in drivers.

Yeah, you are right.

The issue is that QEMU nvme-pci is MSIX-capable only, and hasn't MSI
capability.

__pci_enable_msix_range() actually returns -ENOSPC, but __pci_enable_msi_range()
returns -EINVAL because dev->msi_cap is zero.

Maybe we need the following fix?

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 265ed3e4c920..b0bf260dc154 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1186,7 +1186,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
                        return vecs;
        }
 
-       if (flags & PCI_IRQ_MSI) {
+       if ((flags & PCI_IRQ_MSI) && dev->msi_cap) {
                vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
                if (vecs > 0)
                        return vecs;


Thanks,
Ming
