From: kmalkin@sgi.com (Kirill Malkin)
Date: Mon,  6 Oct 2014 23:19:18 -0500
Subject: [PATCH] Improve NVMe performance on large NUMA systems
Message-ID: <1412655558-2220-1-git-send-email-kmalkin@sgi.com>

Change queue allocation across sockets and CPUs. Specifically,
the queues should be allocated according to the following rules:
* strive to assign at least one queue per socket;
* prioritize sockets to deal with the remainder of queues/sockets
  division (see below);
* the socket with the card has the highest priority;
* assign same queue to all threads of HT CPUs;
* if there are more sockets than queues, use queues of the socket with
the card to backfill.

To achieve the maximum performance for a specific set of sockets (i.e.
when application could be confined to these sockets), they should be
prioritized in ascending order of distance from the node with the card.

To achieve the most even performance across all sockets (when the
application can run on any socket), it is best to prioritize sockets in
descending order of distance from the node with the card.

The patch is against the intel-nvme-2.0 code for SLES11SP3.

Signed-off-by: Kirill Malkin <kmalkin at sgi.com>
---
 nvme-core.c | 317 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 226 insertions(+), 91 deletions(-)

diff --git a/nvme-core.c b/nvme-core.c
index 674c131..641efea 100644
--- a/nvme-core.c
+++ b/nvme-core.c
@@ -38,6 +38,7 @@
 #include <linux/ptrace.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/types.h>
 #include <scsi/sg.h>
 
@@ -65,6 +66,11 @@ module_param(nvme_major, int, 0);
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
+static unsigned char queue_distribution;
+module_param(queue_distribution, byte, 0);
+MODULE_PARM_DESC(queue_distribution, "0: desc distance, 1: asc distance, "
+				     "2: desc order, 3: asc order");
+
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
@@ -2031,46 +2037,6 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 	return NULL;
 }
 
-static int nvme_find_closest_node(int node)
-{
-	int n, val, min_val = INT_MAX, best_node = node;
-
-	for_each_online_node(n) {
-		if (n == node)
-			continue;
-		val = node_distance(node, n);
-		if (val < min_val) {
-			min_val = val;
-			best_node = n;
-		}
-	}
-	return best_node;
-}
-
-static void nvme_set_queue_cpus(cpumask_t *qmask, struct nvme_queue *nvmeq,
-								int count)
-{
-	int cpu;
-	for_each_cpu(cpu, qmask) {
-		if (cpumask_weight(nvmeq->cpu_mask) >= count)
-			break;
-		if (!cpumask_test_and_set_cpu(cpu, nvmeq->cpu_mask))
-			*per_cpu_ptr(nvmeq->dev->io_queue, cpu) = nvmeq->qid;
-	}
-}
-
-static void nvme_add_cpus(cpumask_t *mask, const cpumask_t *unassigned_cpus,
-	const cpumask_t *new_mask, struct nvme_queue *nvmeq, int cpus_per_queue)
-{
-	int next_cpu;
-	for_each_cpu(next_cpu, new_mask) {
-		cpumask_or(mask, mask, get_cpu_mask(next_cpu));
-		cpumask_or(mask, mask, topology_thread_cpumask(next_cpu));
-		cpumask_and(mask, mask, unassigned_cpus);
-		nvme_set_queue_cpus(mask, nvmeq, cpus_per_queue);
-	}
-}
-
 static void nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i, max;
@@ -2087,15 +2053,91 @@ static void nvme_create_io_queues(struct nvme_dev *dev)
 }
 
 /*
- * If there are fewer queues than online cpus, this will try to optimally
- * assign a queue to multiple cpus by grouping cpus that are "close" together:
- * thread siblings, core, socket, closest node, then whatever else is
- * available.
+ * If there are fewer queues than online cpus (typically in NUMA
+ * environments), the interrupt should come to the same node where
+ * the request originated from to minimize cache line thrashing
+ * across the nodes. This means that we should allocate at least one
+ * NVMe queue per node.
+ *
+ * Usually, the number of NVMe queues (and interrupts) is not a
+ * multiple of the number of nodes. Therefore, some nodes will have
+ * more queues than others. If the number of nodes is larger than the
+ * number of NVMe queues, some nodes will have to process their I/O
+ * using another node's queue and interrupt.
+ *
+ * The best performance is on the node where the card is installed,
+ * so this node should always be assigned a queue. It is also the
+ * best choice to handle I/O from nodes that don't have their own
+ * queue. The nodes "closer" (in terms of NUMA distance) to the node
+ * with the card perform better than "farther" nodes.
+ *
+ * If the application accessing the NVMe card can't be confined to
+ * specific nodes (md, LVM, etc.), then allocating queues and interrupts
+ * to farther nodes will result in a more even performance, so
+ * the nodes should be assigned queues in the order of descending
+ * distance.
+ *
+ * If the application accessing the NVMe card can be confined to
+ * specific nodes, then the nodes should be asssigned queues in the
+ * order of ascending distance to achieve maximum possible performance.
+ *
+ * In some scenarios, in is beneficial to assign queues in the order
+ * of nodes, ascending or descending.
+ *
+ * The distribution of NVMe queues is controlled by module parameter
+ * queue_distribution. Possible values are:
+ *
+ * 0 - distance, descending (default)
+ * 1 - distance, ascending
+ * 2 - node numbers, descending
+ * 3 - node numbers, ascending
+ *
  */
+
+struct node_dist {
+	int	node;
+	int	distance;
+};
+
+static int cmp_nodes(const void *v1, const void *v2)
+{
+	struct node_dist *n1 = (struct node_dist *)v1;
+	struct node_dist *n2 = (struct node_dist *)v2;
+	int d = n1->distance-n2->distance;
+	int n = n1->node-n2->node;
+
+	/* node with the card should always be the first */
+	if (n1->distance == -1)
+		return n2->distance == -1 ? 0 : -1;
+	if (n2->distance == -1)
+		return 1;
+
+	/* the rest are sorted according to distribution */
+	switch (queue_distribution) {
+	case 3:
+		/* node number, ascending */
+		return n;
+	case 2:
+		/* node number, descending */
+		return -n;
+	case 1:
+		/* distance, ascending, then node number, ascending */
+		return d ? d : n;
+	}
+
+	/* default order: distance, descending, then node number, ascending */
+	return d ? -d : n;
+}
+
 static void nvme_assign_io_queues(struct nvme_dev *dev)
 {
-	unsigned cpu, cpus_per_queue, queues, remainder, i;
+	unsigned cpu, cpus_per_queue, queues, i, j, k;
+	int num_nodes, node, nvme_node, num_physical_cpus;
+	struct node_dist *node_vector;
 	cpumask_var_t unassigned_cpus;
+	cpumask_var_t physical_cpus;
+	cpumask_t mask;
+	int nvme_node_queues = 1;
 
 	nvme_create_io_queues(dev);
 
@@ -2103,68 +2145,161 @@ static void nvme_assign_io_queues(struct nvme_dev *dev)
 	if (!queues)
 		return;
 
-	cpus_per_queue = num_online_cpus() / queues;
-	remainder = queues - (num_online_cpus() - queues * cpus_per_queue);
+	nvme_node = pcibus_to_node(dev->pci_dev->bus);
+
+	/* reset all queues */
+	for (i = 1; i <= queues; i++) {
+		struct nvme_queue *nvmeq = lock_nvmeq(dev, i);
+
+		cpumask_clear(nvmeq->cpu_mask);
+		unlock_nvmeq(nvmeq);
+	}
 
 	if (!alloc_cpumask_var(&unassigned_cpus, GFP_KERNEL))
 		return;
 
+	if (!alloc_cpumask_var(&physical_cpus, GFP_KERNEL)) {
+		goto out_free_unassigned;
+	}
+
+	/* scan all nodes and calculate distance from the node with the card */
+	num_nodes = num_online_nodes();
+
+	node_vector = kmalloc(num_nodes*sizeof(struct node_dist), GFP_KERNEL);
+	if (node_vector == NULL)
+		goto out_free_physical;
+
+	i = 0;
+	for_each_online_node(node) {
+		node_vector[i].node = node;
+		/* use distance -1 for the node with the card */
+		if (node == nvme_node)
+			node_vector[i].distance = -1;
+		else
+			node_vector[i].distance = node_distance(nvme_node, node);
+		i++;
+	}
+
+	/* order nodes per requested queue distribution */
+	sort(node_vector, num_nodes, sizeof(struct node_dist), cmp_nodes, NULL);
+
+	/* get online cpu mask */
 	cpumask_copy(unassigned_cpus, cpu_online_mask);
-	cpu = cpumask_first(unassigned_cpus);
-	for (i = 1; i <= queues; i++) {
-		struct nvme_queue *nvmeq = lock_nvmeq(dev, i);
-		cpumask_t mask;
+	cpumask_copy(physical_cpus, unassigned_cpus);
 
-		cpumask_clear(nvmeq->cpu_mask);
-		if (!cpumask_weight(unassigned_cpus)) {
-			unlock_nvmeq(nvmeq);
-			break;
+	/* isolate physical cpus */
+	for_each_cpu(cpu, physical_cpus) {
+		mask = *get_cpu_mask(cpu);
+
+		/* locate and exclude ht cpus for this cpu */
+		cpumask_andnot(&mask, topology_thread_cpumask(cpu), &mask);
+		cpumask_xor(physical_cpus, physical_cpus, &mask);
+	}
+	num_physical_cpus = cpumask_weight(physical_cpus);
+
+	/* go through all nodes in requested order */
+	for (i = 0, j = 0; j < num_nodes; j++) {
+		/* translate the node number per sorting order */
+		node = node_vector[j].node;
+
+		/* get physical cpus of this node */
+		cpumask_and(&mask, physical_cpus, cpumask_of_node(node));
+		if (cpumask_weight(&mask) > 0) {
+			int num_cpus = cpumask_weight(&mask);
+			int ques_per_node;
+
+			/* allocate queues proportionally to number of cpus */
+			ques_per_node = (queues * num_cpus) / num_physical_cpus;
+
+			/* make sure we have at least one queue per node */
+			if (ques_per_node == 0 ||
+				(ques_per_node * num_physical_cpus <
+				 queues * num_cpus &&
+					queues-i > num_nodes-j)) {
+				ques_per_node++;
+			}
+
+			/* remember how many queues on the node with the card */
+			if (j == 0)
+				nvme_node_queues = ques_per_node;
+
+			/* assign queues to cpus on current node */
+			for (k = 0; k < ques_per_node; k++) {
+				struct nvme_queue *nvmeq;
+				unsigned short __percpu *io_queue;
+				cpumask_t qmask;
+				int qid;
+
+				/* if we're out of queues, we will assign cpus
+				   to the first queue on node with card */
+				qid = 1;
+
+				/* allocate new queues while we have them */
+				if (i < queues)
+					qid = ++i;
+
+				cpus_per_queue = (num_cpus + ques_per_node - 1) /
+							ques_per_node;
+
+				cpumask_clear(&qmask);
+				for_each_cpu(cpu, &mask) {
+					if (cpus_per_queue-- == 0)
+						break;
+					cpumask_set_cpu(cpu, &qmask);
+
+					/* add hyperthreads to this cpu */
+					cpumask_or(&qmask, &qmask,
+						   topology_thread_cpumask(cpu));
+				}
+				cpumask_and(&qmask, &qmask, unassigned_cpus);
+
+				/* assign this queue to cpus and
+				   their thread siblings */
+				nvmeq = lock_nvmeq(dev, qid);
+				io_queue = nvmeq->dev->io_queue;
+
+				for_each_cpu(cpu, &qmask) {
+					if (!cpumask_test_and_set_cpu(cpu,
+							nvmeq->cpu_mask))
+						*per_cpu_ptr(io_queue,
+							     cpu) = nvmeq->qid;
+				}
+
+				cpumask_andnot(unassigned_cpus, unassigned_cpus,
+								nvmeq->cpu_mask);
+				unlock_nvmeq(nvmeq);
+
+				cpumask_and(&mask, &mask, unassigned_cpus);
+			}
 		}
+	}
 
-		mask = *get_cpu_mask(cpu);
-		nvme_set_queue_cpus(&mask, nvmeq, cpus_per_queue);
-		if (cpus_weight(mask) < cpus_per_queue)
-			nvme_add_cpus(&mask, unassigned_cpus,
-				topology_thread_cpumask(cpu),
-				nvmeq, cpus_per_queue);
-		if (cpus_weight(mask) < cpus_per_queue)
-			nvme_add_cpus(&mask, unassigned_cpus,
-				topology_core_cpumask(cpu),
-				nvmeq, cpus_per_queue);
-		if (cpus_weight(mask) < cpus_per_queue)
-			nvme_add_cpus(&mask, unassigned_cpus,
-				cpumask_of_node(cpu_to_node(cpu)),
-				nvmeq, cpus_per_queue);
-		if (cpus_weight(mask) < cpus_per_queue)
-			nvme_add_cpus(&mask, unassigned_cpus,
-				cpumask_of_node(
-					nvme_find_closest_node(
-						cpu_to_node(cpu))),
-				nvmeq, cpus_per_queue);
-		if (cpus_weight(mask) < cpus_per_queue)
-			nvme_add_cpus(&mask, unassigned_cpus,
-				unassigned_cpus,
-				nvmeq, cpus_per_queue);
-
-		WARN(cpumask_weight(nvmeq->cpu_mask) != cpus_per_queue,
-			"nvme%d qid:%d mis-matched queue-to-cpu assignment\n",
-			dev->instance, i);
+	kfree(node_vector);
+
+	/* the above algo should assign all cpus */
+	WARN(cpumask_weight(unassigned_cpus),
+		"nvme%d has %d unassigned online cpus\n",
+		dev->instance, cpumask_weight(unassigned_cpus));
+
+	/* set affinity hints */
+	for (i = 1; i <= queues; i++) {
+		struct nvme_queue *nvmeq = lock_nvmeq(dev, i);
 
 		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
 							nvmeq->cpu_mask);
-		cpumask_andnot(unassigned_cpus, unassigned_cpus,
-						nvmeq->cpu_mask);
-		cpu = cpumask_next(cpu, unassigned_cpus);
-		if (remainder && !--remainder)
-			cpus_per_queue++;
 		unlock_nvmeq(nvmeq);
 	}
-	WARN(cpumask_weight(unassigned_cpus), "nvme%d unassigned online cpus\n",
-								dev->instance);
+
+	/* distribute queues of node with the card among cpus that could
+	   potentially come online */
 	i = 0;
 	cpumask_andnot(unassigned_cpus, cpu_possible_mask, cpu_online_mask);
 	for_each_cpu(cpu, unassigned_cpus)
-		*per_cpu_ptr(dev->io_queue, cpu) = (i++ % queues) + 1;
+		*per_cpu_ptr(dev->io_queue, cpu) = (i++ % nvme_node_queues) + 1;
+
+ out_free_physical:
+	free_cpumask_var(physical_cpus);
+ out_free_unassigned:
 	free_cpumask_var(unassigned_cpus);
 }
 
-- 
1.7.12.4
