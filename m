From: keith.busch@intel.com (Keith Busch)
Date: Thu, 30 Mar 2017 13:12:55 -0400
Subject: [PATCH] irq/affinity: Assign all CPUs a vector
In-Reply-To: <20170330082106.GC11344@lst.de>
References: <1490743277-14139-1-git-send-email-keith.busch@intel.com>
 <20170330082106.GC11344@lst.de>
Message-ID: <20170330171255.GF20181@localhost.localdomain>

Hi Thomas,

I received an email delivery failure on the original patch, so I'm not
sure if you got it. I'm reattaching here with the two reviews just in
case. Please let me know if you've any concerns with the proposal.

Thanks,
Keith
-------------- next part --------------
>From e73acee5864d1d22261a0a701e32ce54ff4fdd28 Mon Sep 17 00:00:00 2001
From: Keith Busch <keith.busch@intel.com>
Date: Tue, 28 Mar 2017 16:26:23 -0600
Subject: [PATCH] irq/affinity: Assign all CPUs a vector

The number of vectors to assign needs to be adjusted for each node such
that it doesn't exceed the number of CPUs in that node. This patch
recalculates the vector assignment per-node so that we don't try to
assign more vectors than there are CPUs. When that previously happened,
the cpus_per_vec was calculated to be 0, so many vectors had no CPUs
assigned. This then goes on to fail to allocate descriptors due to
empty masks, leading to an unoptimal spread.

Not only does this patch get the intended spread, this also fixes
other subsystems that depend on every CPU being assigned to something:
blk_mq_map_swqueue dereferences NULL while mapping s/w queues when CPUs
are unnassigned, so making sure all CPUs are assigned fixes that.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
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
