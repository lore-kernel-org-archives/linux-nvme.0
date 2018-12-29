From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 29 Dec 2018 11:26:48 +0800
Subject: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20181229032650.27256-1-ming.lei@redhat.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
Message-ID: <20181229032650.27256-2-ming.lei@redhat.com>

The API of pci_alloc_irq_vectors_affinity() requires to return -ENOSPC
if leass than @min_vecs interrupt vectors are available for @dev.

However, this way may be changed by falling back to
__pci_enable_msi_range(), for example, if the device isn't capable of
MSI, __pci_enable_msi_range() will return -EINVAL, and finally it is
returned to users of pci_alloc_irq_vectors_affinity() even though
there are quite MSIX vectors available. This way violates the interface.

Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
vectors and allocate vectors again in case that -ENOSPC is returned, such
as NVMe, so we need to respect the current interface and give preference to
-ENOSPC.

Cc: Jens Axboe <axboe at fb.com>,
Cc: Keith Busch <keith.busch at intel.com>,
Cc: linux-pci at vger.kernel.org,
Cc: Bjorn Helgaas <bhelgaas at google.com>,
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/pci/msi.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..91b4f03fee91 100644
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
@@ -1199,7 +1201,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 		}
 	}
 
-	return vecs;
+	return msix_vecs == -ENOSPC ? msix_vecs : msi_vecs;
 }
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
-- 
2.9.5
