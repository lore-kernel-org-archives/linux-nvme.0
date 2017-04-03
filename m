From: keith.busch@intel.com (Keith Busch)
Date: Mon,  3 Apr 2017 15:25:53 -0400
Subject: [PATCHv2] irq/affinity: Fix CPU spread for unbalanced nodes
Message-ID: <1491247553-7603-1-git-send-email-keith.busch@intel.com>

The irq_create_affinity_masks routine is responsible for assigning a
number of interrupt vectors to CPUs. The optimal assignemnet will spread
requested vectors to all CPUs, with the fewest CPUs sharing a vector.

The algorithm may fail to assign some vectors to any CPUs if a node's
CPU count is lower than the average number of vectors per node. These
vectors are unusable and create an un-optimal spread.

This patch will recalculate the number of vectors to assign at each node
iteration by using the remaining number of vectors and nodes to assigned,
not exceeding the number of CPUs in that node. This will guarantee that
every CPU is assigned at least one vector.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
v1 -> v2:

  Updated the change log with a more coherent description of the problem
  and solution, and removed the unnecessary blk-mq justification.

 kernel/irq/affinity.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4544b11..dc52911 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -59,7 +59,7 @@ static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
 struct cpumask *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
-	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec;
+	int n, nodes, cpus_per_vec, extra_vecs, curvec;
 	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
@@ -94,19 +94,21 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		goto done;
 	}
 
-	/* Spread the vectors per node */
-	vecs_per_node = affv / nodes;
-	/* Account for rounding errors */
-	extra_vecs = affv - (nodes * vecs_per_node);
-
 	for_each_node_mask(n, nodemsk) {
-		int ncpus, v, vecs_to_assign = vecs_per_node;
+		int ncpus, v, vecs_to_assign, vecs_per_node;
+
+		/* Spread the vectors per node */
+		vecs_per_node = (affv - curvec) / nodes;
 
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_online_mask, cpumask_of_node(n));
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
+		vecs_to_assign = min(vecs_per_node, ncpus);
+
+		/* Account for rounding errors */
+		extra_vecs = ncpus - vecs_to_assign;
 
 		for (v = 0; curvec < last_affv && v < vecs_to_assign;
 		     curvec++, v++) {
@@ -115,14 +117,14 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 			/* Account for extra vectors to compensate rounding errors */
 			if (extra_vecs) {
 				cpus_per_vec++;
-				if (!--extra_vecs)
-					vecs_per_node++;
+				--extra_vecs;
 			}
 			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
 		}
 
 		if (curvec >= last_affv)
 			break;
+		--nodes;
 	}
 
 done:
-- 
2.7.2
