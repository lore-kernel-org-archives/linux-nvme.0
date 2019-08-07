From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed,  7 Aug 2019 14:10:51 -0600
Subject: [PATCH] genirq/affinity: report extra vectors on uneven nodes
Message-ID: <20190807201051.32662-1-jonathan.derrick@intel.com>

The current irq spreading algorithm spreads vectors amongst cpus evenly
per node. If a node has more cpus than another node, the extra vectors
being spread may not be reported back to the caller.

This is most apparent with the NVMe driver and nr_cpus < vectors, where
the underreporting results in the caller's WARN being triggered:

irq_build_affinity_masks()
...
	if (nr_present < numvecs)
		WARN_ON(nr_present + nr_others < numvecs);

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 kernel/irq/affinity.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4352b08ae48d..9beafb8c7e92 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -127,7 +127,8 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	}
 
 	for_each_node_mask(n, nodemsk) {
-		unsigned int ncpus, v, vecs_to_assign, vecs_per_node;
+		unsigned int ncpus, v, vecs_to_assign, total_vecs_to_assign,
+			vecs_per_node;
 
 		/* Spread the vectors per node */
 		vecs_per_node = (numvecs - (curvec - firstvec)) / nodes;
@@ -141,14 +142,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 
 		/* Account for rounding errors */
 		extra_vecs = ncpus - vecs_to_assign * (ncpus / vecs_to_assign);
+		total_vecs_to_assign = vecs_to_assign + extra_vecs;
 
-		for (v = 0; curvec < last_affv && v < vecs_to_assign;
+		for (v = 0; curvec < last_affv && v < total_vecs_to_assign;
 		     curvec++, v++) {
 			cpus_per_vec = ncpus / vecs_to_assign;
 
 			/* Account for extra vectors to compensate rounding errors */
 			if (extra_vecs) {
 				cpus_per_vec++;
+				v++;
 				--extra_vecs;
 			}
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
-- 
2.20.1
