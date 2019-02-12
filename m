From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 12 Feb 2019 21:04:36 +0800
Subject: [PATCH V2 1/4] genirq/affinity: store irq set vectors in 'struct
 irq_affinity'
In-Reply-To: <20190212130439.14501-1-ming.lei@redhat.com>
References: <20190212130439.14501-1-ming.lei@redhat.com>
Message-ID: <20190212130439.14501-2-ming.lei@redhat.com>

Currently the array of irq set vectors is provided by driver.

irq_create_affinity_masks() can be simplied a bit by treating the
non-irq-set case as single irq set.

So move this array into 'struct irq_affinity', and pre-define the max
set number as 4, which should be enough for normal cases.

Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c   |  5 ++---
 include/linux/interrupt.h |  8 +++++---
 kernel/irq/affinity.c     | 10 ++++++----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 022ea1ee63f8..0086bdf80ea1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2081,12 +2081,11 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int irq_sets[2];
 	struct irq_affinity affd = {
 		.pre_vectors = 1,
-		.nr_sets = ARRAY_SIZE(irq_sets),
-		.sets = irq_sets,
+		.nr_sets = 2,
 	};
+	int *irq_sets = affd.set_vectors;
 	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 7c9434652f36..a20150627a32 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -259,6 +259,8 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+#define	IRQ_MAX_SETS  4
+
 /**
  * struct irq_affinity - Description for automatic irq affinity assignements
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
@@ -266,13 +268,13 @@ struct irq_affinity_notify {
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
- * @sets:		Number of affinitized sets
+ * @set_vectors:	Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
-	int	*sets;
+	int	set_vectors[IRQ_MAX_SETS];
 };
 
 /**
@@ -332,7 +334,7 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+irq_create_affinity_masks(int nvec, struct irq_affinity *affd);
 
 int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 118b66d64a53..a97b7c33d2db 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -239,7 +239,7 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
  * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
@@ -265,11 +265,13 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
 	nr_sets = affd->nr_sets;
-	if (!nr_sets)
+	if (!nr_sets) {
 		nr_sets = 1;
+		affd->set_vectors[0] = affvecs;
+	}
 
 	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		int this_vecs = affd->set_vectors[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -316,7 +318,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 		int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->sets[i];
+			set_vecs += affd->set_vectors[i];
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);
-- 
2.9.5
