From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 16 Feb 2019 18:13:11 +0100
Subject: [patch v6 5/7] genirq/affinity: Remove the leftovers of the original
 set support
References: <20190216171306.403545970@linutronix.de>
Message-ID: <20190216172228.689834224@linutronix.de>

Now that the NVME driver is converted over to the calc_set() callback, the
workarounds of the original set support can be removed.

Signed-off-by: Thomas Gleixner <tglx at linutronix.de>
---
 kernel/irq/affinity.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

Index: b/kernel/irq/affinity.c
===================================================================
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -264,20 +264,13 @@ irq_create_affinity_masks(unsigned int n
 
 	/*
 	 * Simple invocations do not provide a calc_sets() callback. Install
-	 * the generic one. The check for affd->nr_sets is a temporary
-	 * workaround and will be removed after the NVME driver is converted
-	 * over.
+	 * the generic one.
 	 */
-	if (!affd->nr_sets && !affd->calc_sets)
+	if (!affd->calc_sets)
 		affd->calc_sets = default_calc_sets;
 
-	/*
-	 * If the device driver provided a calc_sets() callback let it
-	 * recalculate the number of sets and their size. The check will go
-	 * away once the NVME driver is converted over.
-	 */
-	if (affd->calc_sets)
-		affd->calc_sets(affd, affvecs);
+	/* Recalculate the sets */
+	affd->calc_sets(affd, affvecs);
 
 	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
 		return NULL;
@@ -344,11 +337,6 @@ unsigned int irq_calc_affinity_vectors(u
 
 	if (affd->calc_sets) {
 		set_vecs = maxvec - resv;
-	} else if (affd->nr_sets) {
-		unsigned int i;
-
-		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->set_size[i];
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);
