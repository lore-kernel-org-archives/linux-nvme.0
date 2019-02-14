From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 21:48:00 +0100
Subject: [patch V5 5/8] genirq/affinity: Remove the leftovers of the original
 set support
References: <20190214204755.819014197@linutronix.de>
Message-ID: <20190214211759.803557905@linutronix.de>

Now that the NVME driver is converted over to the calc_set() callback, the
workarounds of the original set support can be removed.

Signed-off-by: Thomas Gleixner <tglx at linutronix.de>
---
 kernel/irq/affinity.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -258,21 +258,17 @@ irq_create_affinity_masks(unsigned int n
 
 	/*
 	 * Simple invocations do not provide a calc_sets()
-	 * callback. Install the generic one. The check for affd->nr_sets
-	 * is a temporary workaround and will be removed after the NVME
-	 * driver is converted over.
+	 * callback. Install the generic one.
 	 */
-	if (!affd->nr_sets && !affd->calc_sets)
+	if (!affd->calc_sets)
 		affd->calc_sets = default_calc_sets;
 
 	/*
 	 * If the device driver provided a calc_sets() callback let it
-	 * recalculate the number of sets and their size. The check will go
-	 * away once the NVME driver is converted over.
+	 * recalculate the number of sets and their size.
 	 */
 	affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
-	if (affd->calc_sets)
-		affd->calc_sets(affd, affvecs);
+	affd->calc_sets(affd, affvecs);
 
 	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
 		return NULL;
@@ -335,11 +331,6 @@ unsigned int irq_calc_affinity_vectors(u
 
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
