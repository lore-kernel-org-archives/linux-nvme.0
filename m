From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 12 Feb 2019 21:04:39 +0800
Subject: [PATCH V2 4/4] genirq/affinity: Document .calc_sets as required in
 case of multiple sets
In-Reply-To: <20190212130439.14501-1-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
Message-ID: <20190212130439.14501-5-ming.lei@redhat.com>

Now NVMe has implemented the .calc_sets callback for caculating each
set's vectors.

For other cases of multiple irq sets, it isn't a good way to pre-caculate
each set's vectors before allocating IRQ vectors because NVMe's same issue
exists too.

Document .calc_sets as required explicitly for multiple sets.

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/pci/msi.c         | 4 ++--
 include/linux/interrupt.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4c0b47867258..9f91fa713141 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1039,7 +1039,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 	 * If the caller is passing in sets, we can't support a range of
 	 * vectors. The caller needs to handle that.
 	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
+	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(dev->msi_enabled))
@@ -1097,7 +1097,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 	 * If the caller is passing in sets, we can't support a range of
 	 * supported vectors. The caller needs to handle that.
 	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
+	if (affd && affd->nr_sets > 1 && !affd->calc_sets)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(dev->msix_enabled))
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 7a27f6ba1f2f..a053f7fb0ff1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -269,7 +269,8 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @set_vectors:	Number of affinitized sets
- * @calc_sets:		Callback for caculating set vectors
+ * @calc_sets:		Callback for caculating set vectors, required for
+ * 			multiple irq sets.
  * @priv:		Private data of @calc_sets
  */
 struct irq_affinity {
-- 
2.9.5
