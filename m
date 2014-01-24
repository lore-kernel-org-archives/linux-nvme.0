From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jan 2014 16:50:52 -0700
Subject: [PATCH 5/7] NVMe: Per-cpu IO queues
In-Reply-To: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
References: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
Message-ID: <1390607454-23273-6-git-send-email-keith.busch@intel.com>

NVMe IO queues are associated with CPUs, and linux provices a handy
per-cpu implementation. This gives us a convienient way to optimally
assign queues to multiple cpus when the device supports fewer queues
than the host has cpus. The previous implementation did not share these
optimally and may have shared very poorly in some situations. This new
way will share queues among cpus that are "close" together and should
have the lowest penalty for lock contention.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  213 ++++++++++++++++++++++++++++++++++++---------
 include/linux/nvme.h      |    5 +-
 2 files changed, 175 insertions(+), 43 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 076987e..c85b369 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -20,6 +20,7 @@
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
+#include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -35,6 +36,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
+#include <linux/percpu.h>
 #include <linux/poison.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
@@ -95,6 +97,7 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 	u8 q_suspended;
+	cpumask_t cpu_mask;
 	struct async_cmd_info cmdinfo;
 	unsigned long cmdid_data[];
 };
@@ -264,15 +267,13 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 
 struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 {
-	int queue;
 	rcu_read_lock();
-	queue = get_cpu() + 1;
-	return rcu_dereference(dev->queues[queue]);
+	return rcu_dereference(*get_cpu_ptr(dev->io_queues));
 }
 
 void put_nvmeq(struct nvme_queue *nvmeq)
 {
-	put_cpu();
+	put_cpu_ptr(nvmeq->dev->io_queues);
 	rcu_read_unlock();
 }
 
@@ -1160,12 +1161,17 @@ static void nvme_free_queue(struct rcu_head *r)
 
 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
-	int i;
+	int i, cpu;
 
-	for (i = num_possible_cpus(); i > dev->queue_count - 1; i--)
-		rcu_assign_pointer(dev->queues[i], NULL);
 	for (i = dev->queue_count - 1; i >= lowest; i--) {
 		struct nvme_queue *nvmeq = dev->queues[i];
+
+		for_each_cpu(cpu, &nvmeq->cpu_mask) {
+			rcu_assign_pointer(
+				*per_cpu_ptr(dev->io_queues, cpu),
+				NULL);
+			cpumask_clear_cpu(cpu, &nvmeq->cpu_mask);
+		}
 		rcu_assign_pointer(dev->queues[i], NULL);
 		call_rcu(&nvmeq->r_head, nvme_free_queue);
 		dev->queue_count--;
@@ -1253,6 +1259,8 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->cq_vector = vector;
 	nvmeq->qid = qid;
 	nvmeq->q_suspended = 1;
+	cpumask_clear(&nvmeq->cpu_mask);
+	rcu_assign_pointer(dev->queues[qid], nvmeq);
 	dev->queue_count++;
 
 	return nvmeq;
@@ -1288,7 +1296,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	memset(nvmeq->cmdid_data, 0, extra);
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvmeq->q_suspended = 0;
-	nvmeq->dev->online_queues++;
+	dev->online_queues++;
 }
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
@@ -1877,6 +1885,147 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	return NULL;
 }
 
+static int nvme_find_closest_node(int node)
+{
+	int n, val, min_val = INT_MAX, best_node = node;
+
+	for_each_online_node(n) {
+		if (n == node)
+			continue;
+		val = node_distance(node, n);
+		if (val < min_val) {
+			min_val = val;
+			best_node = n;
+		}
+	}
+	return best_node;
+}
+
+static void nvme_set_queue_cpus(cpumask_t *qmask, struct nvme_queue *nvmeq,
+								int count)
+{
+	int cpu;
+	for_each_cpu(cpu, qmask) {
+		if (cpus_weight(nvmeq->cpu_mask) >= count)
+			break;
+		if (!cpumask_test_and_set_cpu(cpu, &nvmeq->cpu_mask))
+			rcu_assign_pointer(
+				*per_cpu_ptr(nvmeq->dev->io_queues, cpu),
+				nvmeq);
+	}
+}
+
+static void nvme_add_cpus(cpumask_t *mask, const cpumask_t *unassigned_cpus,
+	const cpumask_t *new_mask, struct nvme_queue *nvmeq, int cpus_per_queue)
+{
+	int next_cpu;
+	for_each_cpu(next_cpu, new_mask) {
+		cpumask_or(mask, mask, get_cpu_mask(next_cpu));
+		cpumask_or(mask, mask, topology_thread_cpumask(next_cpu));
+		cpumask_and(mask, mask, unassigned_cpus);
+		nvme_set_queue_cpus(mask, nvmeq, cpus_per_queue);
+	}
+}
+
+static void nvme_create_io_queues(struct nvme_dev *dev)
+{
+	unsigned i, max;
+
+	max = min(dev->max_qid, num_online_cpus());
+	for (i = dev->queue_count; i <= max; i++)
+		if (!nvme_alloc_queue(dev, i, dev->q_depth, i - 1))
+			break;
+
+	max = min(dev->queue_count - 1, num_online_cpus());
+	for (i = dev->online_queues; i <= max; i++)
+		if (nvme_create_queue(dev->queues[i], i))
+			break;
+}
+
+/*
+ * If there are fewer queues than online cpus, this will try to optimally
+ * assign a queue to multiple cpus by grouping cpus that are "close" together:
+ * thread siblings, core, socket, closest node, then whatever else is
+ * available.
+ */
+static void nvme_assign_io_queues(struct nvme_dev *dev)
+{
+	unsigned cpu, cpus_per_queue, queues, remainder, i;
+	cpumask_t unassigned_cpus;
+
+	nvme_create_io_queues(dev);
+
+	queues = min(dev->online_queues - 1, num_online_cpus());
+	if (!queues)
+		return;
+
+	cpus_per_queue = num_online_cpus() / queues;
+	remainder = queues - (num_online_cpus() - queues * cpus_per_queue);
+
+	unassigned_cpus = *cpu_online_mask;
+	cpu = cpumask_first(&unassigned_cpus);
+	for (i = 1; i <= queues; i++) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+		cpumask_t mask;
+
+		cpumask_clear(&nvmeq->cpu_mask);
+		if (!cpus_weight(unassigned_cpus))
+			break;
+
+		mask = *get_cpu_mask(cpu);
+		nvme_set_queue_cpus(&mask, nvmeq, cpus_per_queue);
+		if (cpus_weight(mask) < cpus_per_queue)
+			nvme_add_cpus(&mask, &unassigned_cpus,
+				topology_thread_cpumask(cpu),
+				nvmeq, cpus_per_queue);
+		if (cpus_weight(mask) < cpus_per_queue)
+			nvme_add_cpus(&mask, &unassigned_cpus,
+				topology_core_cpumask(cpu),
+				nvmeq, cpus_per_queue);
+		if (cpus_weight(mask) < cpus_per_queue)
+			nvme_add_cpus(&mask, &unassigned_cpus,
+				cpumask_of_node(cpu_to_node(cpu)),
+				nvmeq, cpus_per_queue);
+		if (cpus_weight(mask) < cpus_per_queue)
+			nvme_add_cpus(&mask, &unassigned_cpus,
+				cpumask_of_node(
+					nvme_find_closest_node(
+						cpu_to_node(cpu))),
+				nvmeq, cpus_per_queue);
+		if (cpus_weight(mask) < cpus_per_queue)
+			nvme_add_cpus(&mask, &unassigned_cpus,
+				&unassigned_cpus,
+				nvmeq, cpus_per_queue);
+
+		WARN(cpus_weight(nvmeq->cpu_mask) != cpus_per_queue,
+			"nvme%d qid:%d mis-matched queue-to-cpu assignment\n",
+			dev->instance, i);
+
+		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
+							&nvmeq->cpu_mask);
+
+		cpumask_andnot(&unassigned_cpus, &unassigned_cpus,
+						&nvmeq->cpu_mask);
+
+		cpu = cpumask_next(cpu, &unassigned_cpus);
+		if (remainder && !--remainder)
+			cpus_per_queue++;
+	}
+	WARN(cpus_weight(unassigned_cpus), "nvme%d unassigned online cpus\n",
+								dev->instance);
+
+	/*
+	 * All possible cpus must point to a valid queue. We don't have thread
+	 * sibling info on offline cpus, so no sharing optimization on these
+	 * cpus.
+	 */
+	cpumask_andnot(&unassigned_cpus, cpu_possible_mask, cpu_online_mask);
+	i = 0;
+	for_each_cpu(cpu, &unassigned_cpus)
+		rcu_assign_pointer(*per_cpu_ptr(dev->io_queues, cpu),
+					dev->queues[(i++ % queues) + 1]);
+}
+
 static int set_queue_count(struct nvme_dev *dev, int count)
 {
 	int status;
@@ -1898,9 +2047,9 @@ static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = dev->pci_dev;
-	int result, cpu, i, vecs, nr_io_queues, size, q_depth;
+	int result, i, vecs, nr_io_queues, size;
 
-	nr_io_queues = num_online_cpus();
+	nr_io_queues = num_possible_cpus();
 	result = set_queue_count(dev, nr_io_queues);
 	if (result <= 0)
 		return result;
@@ -1960,6 +2109,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * number of interrupts.
 	 */
 	nr_io_queues = vecs;
+	dev->max_qid = nr_io_queues;
 
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
 	if (result) {
@@ -1969,37 +2119,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	/* Free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, nr_io_queues + 1);
-
-	cpu = cpumask_first(cpu_online_mask);
-	for (i = 0; i < nr_io_queues; i++) {
-		irq_set_affinity_hint(dev->entry[i].vector, get_cpu_mask(cpu));
-		cpu = cpumask_next(cpu, cpu_online_mask);
-	}
-
-	q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
-								NVME_Q_DEPTH);
-	for (i = dev->queue_count - 1; i < nr_io_queues; i++) {
-		dev->queues[i + 1] = nvme_alloc_queue(dev, i + 1, q_depth, i);
-		if (!dev->queues[i + 1]) {
-			result = -ENOMEM;
-			goto free_queues;
-		}
-	}
-
-	for (; i < num_possible_cpus(); i++) {
-		int target = i % rounddown_pow_of_two(dev->queue_count - 1);
-		dev->queues[i + 1] = dev->queues[target + 1];
-	}
-
-	for (i = 1; i < dev->queue_count; i++) {
-		result = nvme_create_queue(dev->queues[i], i);
-		if (result) {
-			for (--i; i > 0; i--)
-				nvme_disable_queue(dev, i);
-			goto free_queues;
-		}
-	}
-
+	nvme_assign_io_queues(dev);
 	return 0;
 
  free_queues:
@@ -2077,6 +2197,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 
 static int nvme_dev_map(struct nvme_dev *dev)
 {
+	u64 cap;
 	int bars, result = -ENOMEM;
 	struct pci_dev *pdev = dev->pci_dev;
 
@@ -2100,7 +2221,9 @@ static int nvme_dev_map(struct nvme_dev *dev)
 		result = -ENODEV;
 		goto unmap;
 	}
-	dev->db_stride = 1 << NVME_CAP_STRIDE(readq(&dev->bar->cap));
+	cap = readq(&dev->bar->cap);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
+	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
 
 	return 0;
@@ -2374,6 +2497,7 @@ static void nvme_free_dev(struct kref *kref)
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 
 	nvme_free_namespaces(dev);
+	free_percpu(dev->io_queues);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2519,6 +2643,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 								GFP_KERNEL);
 	if (!dev->queues)
 		goto free;
+	dev->io_queues = alloc_percpu(struct nvme_queue *);
+	if (!dev->io_queues)
+		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->pci_dev = pdev;
@@ -2566,6 +2693,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  release:
 	nvme_release_instance(dev);
  free:
+	free_percpu(dev->io_queues);
 	kfree(dev->queues);
 	kfree(dev->entry);
 	kfree(dev);
@@ -2672,6 +2800,7 @@ static int __init nvme_init(void)
 	result = pci_register_driver(&nvme_driver);
 	if (result)
 		goto unregister_blkdev;
+
 	return 0;
 
  unregister_blkdev:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2fef3ce..58ffaea 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -74,13 +74,16 @@ enum {
 struct nvme_dev {
 	struct list_head node;
 	struct nvme_queue __rcu **queues;
+	struct nvme_queue __rcu __percpu **io_queues;
 	u32 __iomem *dbs;
 	struct pci_dev *pci_dev;
 	struct dma_pool *prp_page_pool;
 	struct dma_pool *prp_small_pool;
 	int instance;
-	int queue_count;
+	unsigned queue_count;
 	unsigned online_queues;
+	unsigned max_qid;
+	int q_depth;
 	u32 db_stride;
 	u32 ctrl_config;
 	struct msix_entry *entry;
-- 
1.7.10.4
