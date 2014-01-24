From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jan 2014 16:50:54 -0700
Subject: [PATCH 7/7] NVMe: Share interrupt vectors among IO queues
In-Reply-To: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
References: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
Message-ID: <1390607454-23273-8-git-send-email-keith.busch@intel.com>

The driver code contained a comment that proposed investigating if there's
a win from allocating more io queues than interupt vectors. The answer
is "yes", it's a win. Well, it's a win most of the time, but it's never
a loss, and the win was enough for me to post a patch proposal.

For the most extreme case, I used a 32 core machine, forced allocating
a single MSI-x interrupt per nvme device, and compared a single NVMe IO
queue with 32 IO queues for various IO workloads. The 32 queue tests were
always greater or equal to 1 queue. I measured a whopping 22% improvement
in IOPs from sharing among multiple queues in the workload below.

For reference, this is the fio profile I used that showed the biggest win
(not listing all 32 jobs, but should be obvious):

; per-cpu 4k O_DIRECT async rand read
[global]
rw=randread
bs=4k
direct=1
filename=/dev/nvme0n1
ioengine=libaio
iodepth=64

[cpu0]
cpus_allowed=0

[cpu1]
cpus_allowed=1

...

[cpu30]
cpus_allowed=30

[cpu31]
cpus_allowed=31

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   42 +++++++++++++++++++++++++++---------------
 include/linux/nvme.h      |    2 ++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f59af3f..fb009a2 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1186,7 +1186,8 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
  */
 static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
-	int vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
+	struct nvme_dev *dev = nvmeq->dev;
+	int vector = dev->entry[nvmeq->cq_vector].vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
 	if (nvmeq->q_suspended) {
@@ -1199,7 +1200,13 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
 
-	nvmeq->dev->online_queues--;
+	cpumask_andnot(&dev->affinity_masks[vector],
+				&dev->affinity_masks[vector],
+				&nvmeq->cpu_mask);
+	if (cpus_weight(dev->affinity_masks[vector]))
+		irq_set_affinity_hint(vector, &dev->affinity_masks[vector]);
+
+	dev->online_queues--;
 	return 0;
 }
 
@@ -1927,13 +1934,14 @@ static void nvme_add_cpus(cpumask_t *mask, const cpumask_t *unassigned_cpus,
 	}
 }
 
+/* XXX: How to share irqs among queues before we've assigned them to cpus? */
 static void nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i, max;
 
 	max = min(dev->max_qid, num_online_cpus());
 	for (i = dev->queue_count; i <= max; i++)
-		if (!nvme_alloc_queue(dev, i, dev->q_depth, i - 1))
+		if (!nvme_alloc_queue(dev, i, dev->q_depth, i % dev->nr_vecs))
 			break;
 
 	max = min(dev->queue_count - 1, num_online_cpus());
@@ -1953,6 +1961,8 @@ static void nvme_assign_io_queues(struct nvme_dev *dev)
 	unsigned cpu, cpus_per_queue, queues, remainder, i;
 	cpumask_t unassigned_cpus;
 
+	for (i = 0; i < dev->nr_vecs; i++)
+		cpumask_clear(&dev->affinity_masks[i]);
 	nvme_create_io_queues(dev);
 
 	queues = min(dev->online_queues - 1, num_online_cpus());
@@ -2001,9 +2011,9 @@ static void nvme_assign_io_queues(struct nvme_dev *dev)
 			"nvme%d qid:%d mis-matched queue-to-cpu assignment\n",
 			dev->instance, i);
 
-		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-							&nvmeq->cpu_mask);
-
+		cpumask_or(&dev->affinity_masks[nvmeq->cq_vector],
+				&dev->affinity_masks[nvmeq->cq_vector],
+				&nvmeq->cpu_mask);
 		cpumask_andnot(&unassigned_cpus, &unassigned_cpus,
 						&nvmeq->cpu_mask);
 
@@ -2088,7 +2098,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	/* Deregister the admin queue's interrupt */
 	free_irq(dev->entry[0].vector, dev->queues[0]);
 
-	vecs = nr_io_queues;
+	dev->max_qid = vecs = nr_io_queues;
 	for (i = 0; i < vecs; i++)
 		dev->entry[i].entry = i;
 	for (;;) {
@@ -2116,14 +2126,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		}
 	}
 
-	/*
-	 * Should investigate if there's a performance win from allocating
-	 * more queues than interrupt vectors; it might allow the submission
-	 * path to scale better, even if the receive path is limited by the
-	 * number of interrupts.
-	 */
-	nr_io_queues = vecs;
-	dev->max_qid = nr_io_queues;
+	dev->nr_vecs = vecs;
+	for (i = 0; i < vecs; i++)
+		irq_set_affinity_hint(dev->entry[i].vector,
+				&dev->affinity_masks[i]);
 
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
 	if (result) {
@@ -2519,6 +2525,7 @@ static void nvme_free_dev(struct kref *kref)
 
 	nvme_free_namespaces(dev);
 	free_percpu(dev->io_queues);
+	kfree(dev->affinity_masks);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2664,6 +2671,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 								GFP_KERNEL);
 	if (!dev->queues)
 		goto free;
+	dev->affinity_masks = kcalloc(num_possible_cpus() + 1,
+				sizeof(*dev->affinity_masks), GFP_KERNEL);
+	if (!dev->queues)
+		goto free;
 	dev->io_queues = alloc_percpu(struct nvme_queue *);
 	if (!dev->io_queues)
 		goto free;
@@ -2715,6 +2726,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_release_instance(dev);
  free:
 	free_percpu(dev->io_queues);
+	kfree(dev->affinity_masks);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index beeddee..b5f0352 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -83,10 +83,12 @@ struct nvme_dev {
 	unsigned queue_count;
 	unsigned online_queues;
 	unsigned max_qid;
+	unsigned nr_vecs;
 	int q_depth;
 	u32 db_stride;
 	u32 ctrl_config;
 	struct msix_entry *entry;
+	cpumask_t *affinity_masks;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
 	struct kref kref;
-- 
1.7.10.4
