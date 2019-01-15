From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 15 Jan 2019 17:49:04 -0600
Subject: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20190115224631.GA22558@ming.t460p>
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com> <20190115131140.GB28672@lst.de>
 <05cb9e71-e455-a717-c64c-b5242ec38bad@kernel.dk>
 <20190115193135.GH33971@google.com>
 <20190115224631.GA22558@ming.t460p>
Message-ID: <20190115234904.GB158366@google.com>

On Wed, Jan 16, 2019@06:46:32AM +0800, Ming Lei wrote:
> Hi Bjorn,
> 
> I think Christoph and Jens are correct, we should make this patch into
> 5.0 because the issue is triggered since 3b6592f70ad7b4c2 ("nvme: utilize
> two queue maps, one for reads and one for writes"), which is merged to
> 5.0-rc.
> 
> For example, before 3b6592f70ad7b4c2, one nvme controller may be
> allocated 64 irq vectors; but after that commit, only 1 irq vector
> is assigned to this controller.
> 
> On Tue, Jan 15, 2019@01:31:35PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 15, 2019@09:22:45AM -0700, Jens Axboe wrote:
> > > On 1/15/19 6:11 AM, Christoph Hellwig wrote:
> > > > On Mon, Jan 14, 2019@05:23:39PM -0600, Bjorn Helgaas wrote:
> > > >> Applied to pci/msi for v5.1, thanks!
> > > >>
> > > >> If this is something that should be in v5.0, let me know and include the
> > > >> justification, e.g., something we already merged for v5.0 or regression
> > > >> info, etc, and a Fixes: line, and I'll move it to for-linus.
> > > > 
> > > > I'd be tempted to queues this up for 5.0.  Ming, what is your position?
> > > 
> > > I think we should - the API was introduced in this series, I think there's
> > > little (to no) reason NOT to fix it for 5.0.
> > 
> > I'm guessing the justification goes something like this (I haven't
> > done all the research, so I'll leave it to Ming to fill in the details):
> > 
> >   pci_alloc_irq_vectors_affinity() was added in v4.x by XXXX ("...").
> 
> dca51e7892fa3b ("nvme: switch to use pci_alloc_irq_vectors")
> 
> >   It had this return value defect then, but its min_vecs/max_vecs
> >   parameters removed the need for callers to interatively reduce the
> >   number of IRQs requested and retry the allocation, so they didn't
> >   need to distinguish -ENOSPC from -EINVAL.
> > 
> >   In v5.0, XXX ("...") added IRQ sets to the interface, which
> 
> 3b6592f70ad7b4c2 ("nvme: utilize two queue maps, one for reads and one for writes")
> 
> >   reintroduced the need to check for -ENOSPC and possibly reduce the
> >   number of IRQs requested and retry the allocation.

We're fixing a PCI core defect, so we should mention the relevant PCI
core commits, not the nvme-specific ones.  I looked them up for you
and moved this to for-linus for v5.0.


commit 77f88abd4a6f73a1a68dbdc0e3f21575fd508fc3
Author: Ming Lei <ming.lei at redhat.com>
Date:   Tue Jan 15 17:31:29 2019 -0600

    PCI/MSI: Return -ENOSPC from pci_alloc_irq_vectors_affinity()
    
    The API of pci_alloc_irq_vectors_affinity() says it returns -ENOSPC if
    fewer than @min_vecs interrupt vectors are available for @dev.
    
    However, if a device supports MSI-X but not MSI and a caller requests
    @min_vecs that can't be satisfied by MSI-X, we previously returned -EINVAL
    (from the failed attempt to enable MSI), not -ENOSPC.
    
    When -ENOSPC is returned, callers may reduce the number IRQs they request
    and try again.  Most callers can use the @min_vecs and @max_vecs
    parameters to avoid this retry loop, but that doesn't work when using IRQ
    affinity "nr_sets" because rebalancing the sets is driver-specific.
    
    This return value bug has been present since pci_alloc_irq_vectors() was
    added in v4.10 by aff171641d18 ("PCI: Provide sensible IRQ vector
    alloc/free routines"), but it wasn't an issue because @min_vecs/@max_vecs
    removed the need for callers to iteratively reduce the number of IRQs
    requested and retry the allocation, so they didn't need to distinguish
    -ENOSPC from -EINVAL.
    
    In v5.0, 6da4b3ab9a6e ("genirq/affinity: Add support for allocating
    interrupt sets") added IRQ sets to the interface, which reintroduced the
    need to check for -ENOSPC and possibly reduce the number of IRQs requested
    and retry the allocation.
    
    Signed-off-by: Ming Lei <ming.lei at redhat.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
    Cc: Jens Axboe <axboe at fb.com>
    Cc: Keith Busch <keith.busch at intel.com>
    Cc: Christoph Hellwig <hch at lst.de>

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..4c0b47867258 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1168,7 +1168,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   const struct irq_affinity *affd)
 {
 	static const struct irq_affinity msi_default_affd;
-	int vecs = -ENOSPC;
+	int msix_vecs = -ENOSPC;
+	int msi_vecs = -ENOSPC;
 
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
@@ -1179,16 +1180,17 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	}
 
 	if (flags & PCI_IRQ_MSIX) {
-		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-				affd);
-		if (vecs > 0)
-			return vecs;
+		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
+						    max_vecs, affd);
+		if (msix_vecs > 0)
+			return msix_vecs;
 	}
 
 	if (flags & PCI_IRQ_MSI) {
-		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
-		if (vecs > 0)
-			return vecs;
+		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
+						  affd);
+		if (msi_vecs > 0)
+			return msi_vecs;
 	}
 
 	/* use legacy irq if allowed */
@@ -1199,7 +1201,9 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	return vecs;
+	if (msix_vecs == -ENOSPC)
+		return -ENOSPC;
+	return msi_vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
