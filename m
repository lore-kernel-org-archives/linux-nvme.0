From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 14 Feb 2019 20:23:47 +0800
Subject: [PATCH V4 4/4] PCI: Document .calc_sets as required in case of
 multiple interrupt sets
In-Reply-To: <20190214122347.17372-1-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
Message-ID: <20190214122347.17372-5-ming.lei@redhat.com>

Now NVMe has implemented the .calc_sets callback for calculating size of
interrupt set.

For other cases of multiple IRQ sets, pre-calculating each set's size
before allocating IRQ vectors can't work too because the available
interrupt number for this device is unknown at that time.

So document .calc_sets as required explicitly for multiple interrupt sets.

Reviewed-by: Jens Axboe <axboe at kernel.dk>
Acked-by: Bjorn Helgaas <bhelgaas at google.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/pci/msi.c         | 14 ++++++++------
 include/linux/interrupt.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 96978459e2a0..64383ab5f53f 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1036,10 +1036,11 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 		return -ERANGE;
 
 	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
+	 * If the caller requests multiple sets of IRQs where each set
+	 * requires different affinity, it must also supply a ->calc_sets()
+	 * callback to compute size of each interrupt set
 	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
+	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(dev->msi_enabled))
@@ -1094,10 +1095,11 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 		return -ERANGE;
 
 	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
+	 * If the caller requests multiple sets of IRQs where each set
+	 * requires different affinity, it must also supply a ->calc_sets()
+	 * callback to compute size of each interrupt set
 	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
+	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(dev->msix_enabled))
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index acb9c5ad6bc1..0da2a5cea8f3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -269,7 +269,8 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @set_size:		Number of affinitized sets
- * @calc_sets:		Callback for caculating interrupt sets size
+ * @calc_sets:		Callback for caculating set size, required for
+ * 			multiple interrupt sets.
  * @priv:		Private data of @calc_sets
  */
 struct irq_affinity {
-- 
2.9.5
