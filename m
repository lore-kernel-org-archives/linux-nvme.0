From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 25 Jan 2019 17:53:45 +0800
Subject: [PATCH 3/5] genirq/affinity: introduce irq_build_affinity()
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
Message-ID: <20190125095347.17950-4-ming.lei@redhat.com>

Drivers may use this API to build customized irq affinity, one example
is NVMe, which needs to build multiple irq sets, on each of which all
CPUs are spread.

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 include/linux/interrupt.h | 12 ++++++++++++
 kernel/irq/affinity.c     | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index f6cea778cf50..b820b07f3b55 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -323,6 +323,10 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 struct irq_affinity_desc *
 irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
 
+int irq_build_affinity(const struct irq_affinity *affd, int startvec,
+                      int numvecs, int firstvec,
+                      struct irq_affinity_desc *masks, int nmasks);
+
 int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
@@ -368,6 +372,14 @@ irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *aff
 	return maxvec;
 }
 
+static inline int
+irq_build_affinity(const struct irq_affinity *affd, int startvec,
+		   int numvecs, int firstvec,
+		   struct irq_affinity_desc *masks, int nmasks)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 7b77cbdf739c..524fdcda9f85 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -232,6 +232,33 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 }
 
 /**
+ * irq_build_affinity - build affinity masks for multiqueue spreading
+ * @affd:	Description of the affinity requirements
+ * @startvec:	The start vector for building affinity masks
+ * @numvec:	The number of vectors is needed for building affinity
+ * @firstvec:	It is the IRQ vector which we jump to for continue spread
+ * 		after the last vector(@startvec + @numvec - 1) is built.
+ * @masks:	The mask array for storing the affinity masks
+ * @nmasks:	The total number of @masks
+ *
+ * Both @startvec and @firstvec are relative to the 1st irq vectorc
+ * allocated to the device.
+ *
+ * Returns 0 if affinty masks is built successfully.
+ */
+int irq_build_affinity(const struct irq_affinity *affd, int startvec,
+		       int numvecs, int firstvec,
+		       struct irq_affinity_desc *masks, int nmasks)
+{
+	if (startvec >= nmasks || firstvec >= nmasks || numvecs > nmasks)
+		return -EINVAL;
+
+	return irq_build_affinity_masks(affd, startvec, numvecs, firstvec,
+					masks);
+}
+EXPORT_SYMBOL_GPL(irq_build_affinity);
+
+/**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
  * @affd:	Description of the affinity requirements
-- 
2.9.5
