From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 25 Jan 2019 17:53:43 +0800
Subject: [PATCH 1/5] genirq/affinity: move allocation of 'node_to_cpumask' to
 irq_build_affinity_masks
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
Message-ID: <20190125095347.17950-2-ming.lei@redhat.com>

'node_to_cpumask' is just one temparay variable for irq_build_affinity_masks(),
so move it into irq_build_affinity_masks().

No functioanl change.

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 kernel/irq/affinity.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 45b68b4ea48b..118b66d64a53 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -175,18 +175,22 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs, int firstvec,
-				    cpumask_var_t *node_to_cpumask,
 				    struct irq_affinity_desc *masks)
 {
 	int curvec = startvec, nr_present, nr_others;
 	int ret = -ENOMEM;
 	cpumask_var_t nmsk, npresmsk;
+	cpumask_var_t *node_to_cpumask;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return ret;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail;
+		goto fail_nmsk;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_npresmsk;
 
 	ret = 0;
 	/* Stabilize the cpumasks */
@@ -217,9 +221,12 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	if (nr_present < numvecs)
 		WARN_ON(nr_present + nr_others < numvecs);
 
+	free_node_to_cpumask(node_to_cpumask);
+
+ fail_npresmsk:
 	free_cpumask_var(npresmsk);
 
- fail:
+ fail_nmsk:
 	free_cpumask_var(nmsk);
 	return ret;
 }
@@ -236,7 +243,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
-	cpumask_var_t *node_to_cpumask;
 	struct irq_affinity_desc *masks = NULL;
 	int i, nr_sets;
 
@@ -247,13 +253,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		return NULL;
-
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
-		goto outnodemsk;
+		return NULL;
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
@@ -271,11 +273,10 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-						curvec, node_to_cpumask, masks);
+						curvec, masks);
 		if (ret) {
 			kfree(masks);
-			masks = NULL;
-			goto outnodemsk;
+			return NULL;
 		}
 		curvec += this_vecs;
 		usedvecs += this_vecs;
@@ -293,8 +294,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
 		masks[i].is_managed = 1;
 
-outnodemsk:
-	free_node_to_cpumask(node_to_cpumask);
 	return masks;
 }
 
-- 
2.9.5
