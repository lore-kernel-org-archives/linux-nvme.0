From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 13 Feb 2019 18:50:39 +0800
Subject: [PATCH V3 3/5] genirq/affinity: add new callback for caculating set
 vectors
In-Reply-To: <20190213105041.13537-1-ming.lei@redhat.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
Message-ID: <20190213105041.13537-4-ming.lei@redhat.com>

Currently pre-caculated set vectors are provided by driver for
allocating & spread vectors. This way only works when drivers passes
same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
also requires driver to retry the allocating & spread.

As Bjorn and Keith mentioned, the current usage & interface for irq sets
is a bit awkward because the retrying should have been avoided by providing
one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
'max_vecs', number of the allocated vectors is unknown before calling
pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
pre-caculated.

Add a new callback of .calc_sets into 'struct irq_affinity' so that
driver can caculate set vectors after IRQ vector is allocated and
before spread IRQ vectors. Add 'priv' so that driver may retrieve
its private data via the 'struct irq_affinity'.

Suggested-by: Thomas Gleixner <tglx at linutronix.de>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 include/linux/interrupt.h | 4 ++++
 kernel/irq/affinity.c     | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a20150627a32..7a27f6ba1f2f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -269,12 +269,16 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @set_vectors:	Number of affinitized sets
+ * @calc_sets:		Callback for caculating set vectors
+ * @priv:		Private data of @calc_sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
 	int	set_vectors[IRQ_MAX_SETS];
+	void	(*calc_sets)(struct irq_affinity *, int nvecs);
+	void	*priv;
 };
 
 /**
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index b868b9d3df7f..2341b1f005fa 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -267,7 +267,9 @@ irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
-	if (!affd->nr_sets) {
+	if (affd->calc_sets) {
+		affd->calc_sets(affd, nvecs);
+	} else if (!affd->nr_sets) {
 		affd->nr_sets = 1;
 		affd->set_vectors[0] = affvecs;
 	}
@@ -316,7 +318,9 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 	if (resv > minvec)
 		return 0;
 
-	if (affd->nr_sets) {
+	if (affd->calc_sets) {
+		set_vecs = vecs;
+	} else if (affd->nr_sets) {
 		int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-- 
2.9.5
