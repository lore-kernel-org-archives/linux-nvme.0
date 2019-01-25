From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 25 Jan 2019 17:53:44 +0800
Subject: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's
 affinity
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
Message-ID: <20190125095347.17950-3-ming.lei@redhat.com>

This patch introduces callback of .setup_affinity into 'struct
irq_affinity', so that:

1) allow drivers to customize the affinity for managed IRQ, for
example, now NVMe has special requirement for read queues & poll
queues

2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.

With this patch, driver can implement their own .setup_affinity to
customize the affinity, then the above thing can be solved easily.

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 include/linux/interrupt.h | 26 +++++++++++++++++---------
 kernel/irq/affinity.c     |  6 ++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..f6cea778cf50 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -242,30 +242,38 @@ struct irq_affinity_notify {
 };
 
 /**
+ * struct irq_affinity_desc - Interrupt affinity descriptor
+ * @mask:	cpumask to hold the affinity assignment
+ */
+struct irq_affinity_desc {
+	struct cpumask	mask;
+	unsigned int	is_managed : 1;
+};
+
+/**
  * struct irq_affinity - Description for automatic irq affinity assignements
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
+ * @setup_affinity:	Use driver's method to setup irq vectors affinity,
+ * 			and driver has to handle pre_vectors & post_vectors
+ * 			correctly, set 'is_managed' flag correct too
+ * @priv:		Private data of @setup_affinity
  * @nr_sets:		Length of passed in *sets array
  * @sets:		Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
+	int	(*setup_affinity)(const struct irq_affinity *,
+				  struct irq_affinity_desc *,
+				  unsigned int);
+	void    *priv;
 	int	nr_sets;
 	int	*sets;
 };
 
-/**
- * struct irq_affinity_desc - Interrupt affinity descriptor
- * @mask:	cpumask to hold the affinity assignment
- */
-struct irq_affinity_desc {
-	struct cpumask	mask;
-	unsigned int	is_managed : 1;
-};
-
 #if defined(CONFIG_SMP)
 
 extern cpumask_var_t irq_default_affinity;
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 118b66d64a53..7b77cbdf739c 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -257,6 +257,12 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!masks)
 		return NULL;
 
+	if (affd->setup_affinity) {
+		if (affd->setup_affinity(affd, masks, nvecs))
+			return NULL;
+		return masks;
+	}
+
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
-- 
2.9.5
