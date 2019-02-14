From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 14 Feb 2019 21:48:02 +0100
Subject: [patch V5 7/8] genirq/affinity: Set is_managed in the spreading
 function
References: <20190214204755.819014197@linutronix.de>
Message-ID: <20190214211759.981965829@linutronix.de>

Some drivers need an extra set of interrupts which are not marked managed,
but should get initial interrupt spreading.

To achieve this it is simpler to set the is_managed bit of the affinity
descriptor in the spreading function instead of having yet another loop and
tons of conditionals.

No functional change.

Signed-off-by: Thomas Gleixner <tglx at linutronix.de>
---
 kernel/irq/affinity.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -98,6 +98,7 @@ static int __irq_build_affinity_masks(co
 				      unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
+				      bool managed,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
@@ -154,6 +155,7 @@ static int __irq_build_affinity_masks(co
 			}
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
 						cpus_per_vec);
+			masks[curvec].is_managed = managed;
 		}
 
 		done += v;
@@ -173,7 +175,7 @@ static int __irq_build_affinity_masks(co
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    unsigned int startvec, unsigned int numvecs,
-				    unsigned int firstvec,
+				    unsigned int firstvec, bool managed,
 				    struct irq_affinity_desc *masks)
 {
 	unsigned int curvec = startvec, nr_present, nr_others;
@@ -197,8 +199,8 @@ static int irq_build_affinity_masks(cons
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
-						firstvec, node_to_cpumask,
+	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs, firstvec,
+						managed, node_to_cpumask,
 						cpu_present_mask, nmsk, masks);
 
 	/*
@@ -212,8 +214,8 @@ static int irq_build_affinity_masks(cons
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
-					       firstvec, node_to_cpumask,
+	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs, firstvec,
+					       managed, node_to_cpumask,
 					       npresmsk, nmsk, masks);
 	put_online_cpus();
 
@@ -290,7 +292,7 @@ irq_create_affinity_masks(unsigned int n
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-					       curvec, masks);
+					       true, curvec, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
@@ -307,10 +309,6 @@ irq_create_affinity_masks(unsigned int n
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
-	/* Mark the managed interrupts */
-	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
-		masks[i].is_managed = 1;
-
 	return masks;
 }
 
