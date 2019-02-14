From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 21:48:03 +0100
Subject: [patch V5 8/8] genirq/affinity: Add support for non-managed affinity
 sets
References: <20190214204755.819014197@linutronix.de>
Message-ID: <20190214211800.077804233@linutronix.de>

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
 kernel/irq/affinity.c     |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

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
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -251,6 +251,8 @@ irq_create_affinity_masks(unsigned int n
 	unsigned int affvecs, curvec, usedvecs, i;
 	struct irq_affinity_desc *masks = NULL;
 
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS > sizeof(affd->unmanaged_sets) * 8);
+
 	/*
 	 * If there aren't any vectors left after applying the pre/post
 	 * vectors don't bother with assigning affinity.
@@ -288,11 +290,12 @@ irq_create_affinity_masks(unsigned int n
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		bool managed = affd->unmanaged_sets & (1U << i) ? true : false;
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-					       true, curvec, masks);
+					       managed, curvec, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
