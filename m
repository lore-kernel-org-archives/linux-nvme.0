From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 13 Aug 2019 16:14:46 +0800
Subject: [PATCH V3 2/3] genirq/affinity: Improve __irq_build_affinity_masks()
In-Reply-To: <20190813081447.1396-1-ming.lei@redhat.com>
References: <20190813081447.1396-1-ming.lei@redhat.com>
Message-ID: <20190813081447.1396-3-ming.lei@redhat.com>

One invariant of __irq_build_affinity_masks() is that all CPUs in the
specified masks( cpu_mask AND node_to_cpumask for each node) should be
covered during the spread. Even though all requested vectors have been
reached, we still need to spread vectors among remained CPUs. The similar
policy has been taken in case of 'numvecs <= nodes' already:

So remove the following check inside the loop:

	if (done >= numvecs)
		break;

Meantime assign at least 1 vector for remained nodes if 'numvecs' vectors
have been handled already.

Also, if the specified cpumask for one numa node is empty, simply not
spread vectors on this node.

Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: linux-nvme at lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick at intel.com>
Cc: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 kernel/irq/affinity.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 265b3076f16b..4e329495e9dc 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -129,14 +129,26 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	for_each_node_mask(n, nodemsk) {
 		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
 
-		/* Spread the vectors per node */
-		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
-
 		/* Get the cpus on this node which are in the mask */
 		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
-
-		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
+		if (!ncpus)
+			continue;
+
+		/*
+		 * Calculate the number of cpus per vector
+		 *
+		 * Spread the vectors evenly per node. If the requested
+		 * vector number has been reached, simply allocate one
+		 * vector for each remaining node so that all nodes can
+		 * be covered
+		 */
+		if (numvecs > done)
+			vecs_per_node = max_t(unsigned,
+					(numvecs - done) / nodes, 1);
+		else
+			vecs_per_node = 1;
+
 		vecs_to_assign = min(vecs_per_node, ncpus);
 
 		/* Account for rounding errors */
@@ -156,13 +168,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		}
 
 		done += v;
-		if (done >= numvecs)
-			break;
 		if (curvec >= last_affv)
 			curvec = firstvec;
 		--nodes;
 	}
-	return done;
+	return done < numvecs ? done : numvecs;
 }
 
 /*
-- 
2.20.1
