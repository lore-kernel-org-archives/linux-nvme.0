From: keith.busch@intel.com (Keith Busch)
Date: Thu,  3 Jan 2019 14:09:53 -0700
Subject: [PATCH 3/4] pci/irq: Handle vector reduce and retry
In-Reply-To: <20190103210954.11129-1-keith.busch@intel.com>
References: <20190103210954.11129-1-keith.busch@intel.com>
Message-ID: <20190103210954.11129-3-keith.busch@intel.com>

Adding the nr_sets forced the driver to handle reducing the vector count
on allocation failures because the set distributino counts are driver
specific. The change to this API is very different to use than before,
and introduced new error corner cases that weren't being handled. It
is also less efficient since the driver doesn't actually know what a
proper vector count it should use since it only sees the error code and
can only reduce by one instead of going straight to a possible vector
count like PCI is able to do.

Provide a driver specific callback for managed irq set creation so that
PCI can take a min and max vectors as before to handle the reduce and
retry logic.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/pci/msi.c         | 20 ++++++--------------
 include/linux/interrupt.h |  4 ++++
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..b93ac49be18d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
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
 
@@ -1061,6 +1054,9 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 				return -ENOSPC;
 		}
 
+		if (nvec != maxvec && affd && affd->recalc_sets)
+			affd->recalc_sets((struct irq_affinity *)affd, nvec);
+
 		rc = msi_capability_init(dev, nvec, affd);
 		if (rc == 0)
 			return nvec;
@@ -1093,13 +1089,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
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
 
@@ -1110,6 +1099,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
+		if (nvec != maxvec && affd && affd->recalc_sets)
+			affd->recalc_sets((struct irq_affinity *)affd, nvec);
+
 		rc = __pci_enable_msix(dev, entries, nvec, affd);
 		if (rc == 0)
 			return nvec;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..326c9bd05f62 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -249,12 +249,16 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @sets:		Number of affinitized sets
+ * @recalc_sets:	Recalculate sets original requested allocation failed
+ * @priv:		Driver private data
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
 	int	*sets;
+	void	(*recalc_sets)(struct irq_affinity *, unsigned int);
+	void	*priv;
 };
 
 /**
-- 
2.14.4
