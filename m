From: ming.lei@redhat.com (Ming Lei)
Date: Fri,  9 Aug 2019 18:23:10 +0800
Subject: [PATCH 2/2] genirq/affinity: spread vectors on node according to
 nr_cpu ratio
In-Reply-To: <20190809102310.27246-1-ming.lei@redhat.com>
References: <20190809102310.27246-1-ming.lei@redhat.com>
Message-ID: <20190809102310.27246-3-ming.lei@redhat.com>

Now __irq_build_affinity_masks() spreads vectors evenly per node, and
all vectors may not be spread in case that each numa node has different
CPU number, then the following warning in irq_build_affinity_masks() can
be triggered:

	if (nr_present < numvecs)
		WARN_ON(nr_present + nr_others < numvecs);

Improve current spreading algorithm by assigning vectors according to
the ratio of node's nr_cpu to nr_remaining_cpus.

Meantime the reported warning can be fixed.

Cc: Christoph Hellwig <hch at lst.de>
Cc: Keith Busch <kbusch at kernel.org>
Cc: linux-nvme at lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick at intel.com>
Reported-by: Jon Derrick <jonathan.derrick at intel.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 kernel/irq/affinity.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index bc3652a2c61b..76f3d1b27d00 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -106,6 +106,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	unsigned int last_affv = firstvec + numvecs;
 	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
+	unsigned remaining_cpus = 0;
 
 	if (!cpumask_weight(cpu_mask))
 		return 0;
@@ -126,6 +127,11 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		return numvecs;
 	}
 
+	for_each_node_mask(n, nodemsk) {
+		cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
+		remaining_cpus += cpumask_weight(nmsk);
+	}
+
 	for_each_node_mask(n, nodemsk) {
 		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
 
@@ -135,17 +141,22 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		if (!ncpus)
 			continue;
 
+		if (remaining_cpus == 0)
+			break;
+
 		/*
 		 * Calculate the number of cpus per vector
 		 *
-		 * Spread the vectors evenly per node. If the requested
-		 * vector number has been reached, simply allocate one
-		 * vector for each remaining node so that all nodes can
-		 * be covered
+		 * Spread the vectors among CPUs on this node according
+		 * to the ratio of 'ncpus' to 'remaining_cpus'. If the
+		 * requested vector number has been reached, simply
+		 * spread one vector for each remaining node so that all
+		 * nodes can be covered
 		 */
 		if (numvecs > done)
 			vecs_per_node = max_t(unsigned,
-					(numvecs - done) / nodes, 1);
+					(numvecs - done) * ncpus /
+					remaining_cpus, 1);
 		else
 			vecs_per_node = 1;
 
@@ -169,7 +180,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 		}
 
 		done += v;
-		--nodes;
+		remaining_cpus -= ncpus;
 	}
 	return done < numvecs ? done : numvecs;
 }
-- 
2.20.1
