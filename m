From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 16 Feb 2019 18:13:12 +0100
Subject: [patch v6 6/7] PCI/MSI: Remove obsolete sanity checks for multiple
 interrupt sets
References: <20190216171306.403545970@linutronix.de>
Message-ID: <20190216172228.778630549@linutronix.de>

Multiple interrupt sets for affinity spreading are now handled in the core
code and the number of sets and their size is recalculated via a driver
supplied callback.

That avoids the requirement to invoke pci_alloc_irq_vectors_affinity() with
the arguments minvecs and maxvecs set to the same value and the callsite
handling the ENOSPC situation.

Remove the now obsolete sanity checks and the related comments.

Signed-off-by: Thomas Gleixner <tglx at linutronix.de>

---
 drivers/pci/msi.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1093,13 +1086,6 @@ static int __pci_enable_msix_range(struc
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 
