From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Jan 2019 15:46:39 -0700
Subject: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20190102210202.GC126384@google.com>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
 <20181231220059.GI159477@google.com>
 <20190101052458.GA17588@ming.t460p>
 <20190102210202.GC126384@google.com>
Message-ID: <20190102224637.GA9795@localhost.localdomain>

On Wed, Jan 02, 2019@03:02:02PM -0600, Bjorn Helgaas wrote:
> Keith said:
> > The min/max vecs doesn't work correctly when using the irq_affinity
> > nr_sets because rebalancing the set counts is driver specific. To
> > get around that, drivers using nr_sets have to set min and max to
> > the same value and handle the "reduce and try again".
> 
> Sorry I saw that, but didn't follow it at first.  After a little
> archaeology, I see that 6da4b3ab9a6e ("genirq/affinity: Add support
> for allocating interrupt sets") added nr_sets and some validation
> tests (if affd.nr_sets, min_vecs == max_vecs) for using it in the API.
> 
> That's sort of a wart on the API, but I don't know if we should live
> with it or try to clean it up somehow.

Yeah, that interface is a bit awkward. I was thinking it would be nice to
thread a driver callback to PCI for the driver to redistribute the sets
as needed and let the PCI handle the retries as before. I am testing
with the following, and seems to work, but I'm getting some unexpected
warnings from blk-mq when I have nvme use it. Still investigating that,
but just throwing this out for early feedback.

---
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7a1c8a09efa5..e33abb167c19 100644
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
 
@@ -1093,13 +1086,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
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
 
@@ -1110,6 +1096,9 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 				return -ENOSPC;
 		}
 
+		if (nvec != maxvec && affd && affd->recalc_sets)
+			affd->recalc_sets(affd, nvec);
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
+ * @recalc_sets:	Recalculate sets when requested allocation failed
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
