From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 16 Feb 2019 18:13:13 +0100
Subject: [patch v6 7/7] genirq/affinity: Add support for non-managed affinity
 sets
References: <20190216171306.403545970@linutronix.de>
Message-ID: <20190216172228.869750763@linutronix.de>

Some drivers need an extra set of interrupts which should not be marked
managed, but should get initial interrupt spreading.

Add a bitmap to struct irq_affinity which allows the driver to mark a
particular set of interrupts as non managed. Check the bitmap during
spreading and use the result to mark the interrupts in the sets
accordingly.

The unmanaged interrupts get initial spreading, but user space can change
their affinity later on. For the managed sets, i.e. the corresponding bit
in the mask is not set, there is no change in behaviour.

Usage example:

	struct irq_affinity affd = {
		.pre_vectors	= 2,
		.unmanaged_sets	= 0x02,
		.calc_sets	= drv_calc_sets,
	};
	....

For both interrupt sets the interrupts are properly spread out, but the
second set is not marked managed.

Signed-off-by: Thomas Gleixner <tglx at linutronix.de>
---
 include/linux/interrupt.h |    2 ++
 kernel/irq/affinity.c     |   16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

Index: b/include/linux/interrupt.h
===================================================================
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -251,6 +251,7 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		The number of interrupt sets for which affinity
  *			spreading is required
+ * @unmanaged_sets:	Bitmap to mark entries in the @set_size array unmanaged
  * @set_size:		Array holding the size of each interrupt set
  * @calc_sets:		Callback for calculating the number and size
  *			of interrupt sets
@@ -261,6 +262,7 @@ struct irq_affinity {
 	unsigned int	pre_vectors;
 	unsigned int	post_vectors;
 	unsigned int	nr_sets;
+	unsigned int	unmanaged_sets;
 	unsigned int	set_size[IRQ_AFFINITY_MAX_SETS];
 	void		(*calc_sets)(struct irq_affinity *, unsigned int nvecs);
 	void		*priv;
Index: b/kernel/irq/affinity.c
===================================================================
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -249,6 +249,8 @@ irq_create_affinity_masks(unsigned int n
 	unsigned int affvecs, curvec, usedvecs, i;
 	struct irq_affinity_desc *masks = NULL;
 
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS > sizeof(affd->unmanaged_sets) * 8);
+
 	/*
 	 * Determine the number of vectors which need interrupt affinities
 	 * assigned. If the pre/post request exhausts the available vectors
@@ -292,7 +294,8 @@ irq_create_affinity_masks(unsigned int n
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
-		unsigned int this_vecs = affd->set_size[i];
+		bool managed = affd->unmanaged_sets & (1U << i) ? true : false;
+		unsigned int idx, this_vecs = affd->set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -301,8 +304,15 @@ irq_create_affinity_masks(unsigned int n
 			kfree(masks);
 			return NULL;
 		}
+
+		idx = curvec;
 		curvec += this_vecs;
 		usedvecs += this_vecs;
+		if (managed) {
+			/* Mark the managed interrupts */
+			for (; idx < curvec; idx++)
+				masks[idx].is_managed = 1;
+		}
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
@@ -313,10 +323,6 @@ irq_create_affinity_masks(unsigned int n
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
-	/* Mark the managed interrupts */
-	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
-		masks[i].is_managed = 1;
-
 	return masks;
 }
 
