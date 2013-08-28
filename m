From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Aug 2013 16:58:12 -0600
Subject: [PATCH] NVMe: cpu hot-plug and IO queue per-cpu assignment
Message-ID: <1377730692-18062-1-git-send-email-keith.busch@intel.com>

This patch tries to assign queues allocated per cpu in the most optimal way
and rebalance the queue-to-cpu assignment as cpus are taken on/off line.

Signed-off-by: Keith Busch <keith.busch at intel.com>

This is more just to think about rather than a serious patch attempt
just yet. I expect I should have split this up, but just wanted to get
it out there lest I get stuck thinking of impossible topologies and try
optimizing queue assignements for mythical scenarios, but I don't have
enough time on my hands to explore such fun... :(

I started this after noticing the default queue assignment is less than
optimal for a variety of scenarios. Here are some:

If the device supports fewer queues than there are online cpus, the
queues are wrapped in a very basic way that may not be optimal. This
patch tries to optimize the assignment by sharing IO queues with CPUs
that are close together.

If there are offline cpus at the time the driver was loaded, an even less
optimal situation could happen. Consider if we have possible cpus 0-7,
where 2-3, and 6-7 are offline. The previous method would allocate 4
queues, and cpus 0-1 will end up sharing with 4-5, and two queues will
go unused.

We previously set the number of queues features to the number of online
cpus in the system rather than the possible number of cpus. If more cpus
come online, we do not have an opprotunity to give that cpu a queue of
its own without resetting the controller, so it would use a less than
optimized resource sharing.

A couple notes on the implementation details:

Allocated queues are tracked with device bitmap so we can add and remove
queues as cpus are brought on/off line.

The device spinlock is changed to a mutex so I can sleep when the cpu
notifier callback is invoked and we create/delete queues.
---
 drivers/block/nvme-core.c |  303 +++++++++++++++++++++++++++++++++++----------
 include/linux/nvme.h      |    5 +
 2 files changed, 244 insertions(+), 64 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7de80bb..cb6fbad 100644
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
@@ -55,7 +57,7 @@ module_param(nvme_major, int, 0);
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
-static DEFINE_SPINLOCK(dev_list_lock);
+static DEFINE_MUTEX(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 
@@ -80,8 +82,10 @@ struct nvme_queue {
 	u16 sq_head;
 	u16 sq_tail;
 	u16 cq_head;
+	u16 qid;
 	u8 cq_phase;
 	u8 cqe_seen;
+	cpumask_t cpu_mask;
 	unsigned long cmdid_data[];
 };
 
@@ -228,12 +232,12 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 
 struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 {
-	return dev->queues[get_cpu() + 1];
+	return *get_cpu_ptr(dev->cpu_queues);
 }
 
 void put_nvmeq(struct nvme_queue *nvmeq)
 {
-	put_cpu();
+	put_cpu_ptr(nvmeq->dev->cpu_queues);
 }
 
 /**
@@ -880,7 +884,7 @@ int nvme_submit_sync_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 								u32 *result)
 {
-	return nvme_submit_sync_cmd(dev->queues[0], cmd, result, ADMIN_TIMEOUT);
+	return nvme_submit_sync_cmd(dev->admin_queue, cmd, result, ADMIN_TIMEOUT);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1030,9 +1034,9 @@ static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
 	kfree(nvmeq);
 }
 
-static void nvme_free_queue(struct nvme_dev *dev, int qid)
+static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
-	struct nvme_queue *nvmeq = dev->queues[qid];
+	struct nvme_dev *dev = nvmeq->dev;
 	int vector = dev->entry[nvmeq->cq_vector].vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
@@ -1047,9 +1051,10 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 	free_irq(vector, nvmeq);
 
 	/* Don't tell the adapter to delete the admin queue */
-	if (qid) {
-		adapter_delete_sq(dev, qid);
-		adapter_delete_cq(dev, qid);
+	if (nvmeq->qid) {
+		adapter_delete_sq(dev, nvmeq->qid);
+		adapter_delete_cq(dev, nvmeq->qid);
+		clear_bit(nvmeq->qid - 1, dev->qids);
 	}
 
 	nvme_free_queue_mem(nvmeq);
@@ -1081,6 +1086,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	spin_lock_init(&nvmeq->q_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
+	nvmeq->qid = qid;
 	init_waitqueue_head(&nvmeq->sq_full);
 	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	bio_list_init(&nvmeq->sq_cong);
@@ -1226,7 +1232,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result)
 		goto free_q;
 
-	dev->queues[0] = nvmeq;
+	dev->admin_queue = nvmeq;
 	return result;
 
  free_q:
@@ -1466,7 +1472,7 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 	if (length != cmd.data_len)
 		status = -ENOMEM;
 	else
-		status = nvme_submit_sync_cmd(dev->queues[0], &c, &cmd.result,
+		status = nvme_submit_sync_cmd(dev->admin_queue, &c, &cmd.result,
 								timeout);
 
 	if (cmd.data_len) {
@@ -1528,27 +1534,32 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 	}
 }
 
+static void nvme_poll_queue(struct nvme_queue *nvmeq)
+{
+	if (!nvmeq)
+		return;
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	nvme_cancel_ios(nvmeq, true);
+	if (nvmeq->qid)
+		nvme_resubmit_bios(nvmeq);
+	spin_unlock_irq(&nvmeq->q_lock);
+}
+
 static int nvme_kthread(void *data)
 {
+	int qid;
 	struct nvme_dev *dev;
 
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		spin_lock(&dev_list_lock);
+		mutex_lock(&dev_list_lock);
 		list_for_each_entry(dev, &dev_list, node) {
-			int i;
-			for (i = 0; i < dev->queue_count; i++) {
-				struct nvme_queue *nvmeq = dev->queues[i];
-				if (!nvmeq)
-					continue;
-				spin_lock_irq(&nvmeq->q_lock);
-				nvme_process_cq(nvmeq);
-				nvme_cancel_ios(nvmeq, true);
-				nvme_resubmit_bios(nvmeq);
-				spin_unlock_irq(&nvmeq->q_lock);
-			}
+			nvme_poll_queue(dev->admin_queue);
+			for_each_set_bit(qid, dev->qids, dev->nr_io_queues)
+				nvme_poll_queue(dev->queues[qid]);
 		}
-		spin_unlock(&dev_list_lock);
+		mutex_unlock(&dev_list_lock);
 		schedule_timeout(round_jiffies_relative(HZ));
 	}
 	return 0;
@@ -1564,9 +1575,9 @@ static int nvme_get_ns_idx(void)
 		if (!ida_pre_get(&nvme_index_ida, GFP_KERNEL))
 			return -1;
 
-		spin_lock(&dev_list_lock);
+		mutex_lock(&dev_list_lock);
 		error = ida_get_new(&nvme_index_ida, &index);
-		spin_unlock(&dev_list_lock);
+		mutex_unlock(&dev_list_lock);
 	} while (error == -EAGAIN);
 
 	if (error)
@@ -1576,9 +1587,9 @@ static int nvme_get_ns_idx(void)
 
 static void nvme_put_ns_idx(int index)
 {
-	spin_lock(&dev_list_lock);
+	mutex_lock(&dev_list_lock);
 	ida_remove(&nvme_index_ida, index);
-	spin_unlock(&dev_list_lock);
+	mutex_unlock(&dev_list_lock);
 }
 
 static void nvme_config_discard(struct nvme_ns *ns)
@@ -1670,12 +1681,120 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
+static int nvme_find_closest_node(int node)
+{
+	int n, val;
+	int min_val = INT_MAX;
+	int best_node = node;
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
+
+	for_each_cpu(cpu, qmask) {
+		if (cpus_weight(nvmeq->cpu_mask) > count)
+			break;
+		if (!cpumask_test_and_set_cpu(cpu, &nvmeq->cpu_mask))
+			*per_cpu_ptr(nvmeq->dev->cpu_queues, cpu) = nvmeq;
+	}
+}
+
+/*
+ * If there are fewer queues than online cpus, this will try to optimally
+ * assign a queue to multiple cpus by attempting to group cpus that are closer
+ * together: thread siblings, core, socket, closest node, then whatever else is
+ * available.
+ */
+static void nvme_assign_queues(struct nvme_dev *dev) {
+	int qid, cpu, cpus_per_queue, remainder, queues_to_assign;
+	cpumask_t unassigned_cpus = *cpu_online_mask;
+
+	queues_to_assign = bitmap_weight(dev->qids, dev->nr_io_queues);
+	cpus_per_queue = queues_to_assign / num_online_cpus();
+	remainder = queues_to_assign - queues_to_assign % num_online_cpus();
+
+	cpu = cpumask_first(&unassigned_cpus);
+	for_each_set_bit(qid, dev->qids, dev->nr_io_queues) {
+		struct nvme_queue *nvmeq = dev->queues[qid];
+		cpumask_t qmask = *get_cpu_mask(cpu);
+
+		cpumask_clear(&nvmeq->cpu_mask);
+		nvme_set_queue_cpus(&qmask, nvmeq, cpus_per_queue);
+		if (cpus_weight(qmask) < cpus_per_queue) {
+			cpumask_or(&qmask, &qmask,
+						topology_thread_cpumask(cpu));
+			cpumask_and(&qmask, &qmask, &unassigned_cpus);
+			nvme_set_queue_cpus(&qmask, nvmeq, cpus_per_queue);
+		}
+		if (cpus_weight(qmask) < cpus_per_queue) {
+			cpumask_or(&qmask, &qmask,
+						topology_core_cpumask(cpu));
+			cpumask_and(&qmask, &qmask, &unassigned_cpus);
+			nvme_set_queue_cpus(&qmask, nvmeq, cpus_per_queue);
+		}
+		if (cpus_weight(qmask) < cpus_per_queue) {
+			cpumask_or(&qmask, &qmask,
+					cpumask_of_node(cpu_to_node(cpu)));
+			cpumask_and(&qmask, &qmask, &unassigned_cpus);
+			nvme_set_queue_cpus(&qmask, nvmeq, cpus_per_queue);
+		}
+		if (cpus_weight(qmask) < cpus_per_queue) {
+			cpumask_or(&qmask, &qmask, cpumask_of_node(
+				nvme_find_closest_node(cpu_to_node(cpu))));
+			cpumask_and(&qmask, &qmask, &unassigned_cpus);
+			nvme_set_queue_cpus(&qmask, nvmeq, cpus_per_queue);
+		}
+		if (cpus_weight(qmask) < cpus_per_queue) {
+			cpumask_or(&qmask, &qmask, &unassigned_cpus);
+			nvme_set_queue_cpus(&qmask, nvmeq, cpus_per_queue);
+		}
+
+		BUG_ON(cpus_weight(nvmeq->cpu_mask) != cpus_per_queue);
+		irq_set_affinity_hint(dev->entry[qid].vector, &nvmeq->cpu_mask);
+
+		if (remainder && !--remainder)
+			cpus_per_queue++;
+
+		cpumask_andnot(&unassigned_cpus, &unassigned_cpus,
+						&nvmeq->cpu_mask);
+		cpu = cpumask_next(cpu, &unassigned_cpus);
+	}
+}
+
+static int nvme_make_queue(struct nvme_dev *dev)
+{
+	int qid = find_first_zero_bit(dev->qids, dev->nr_io_queues);
+	if (qid >= dev->nr_io_queues)
+		return -EBUSY;
+
+	BUG_ON(dev->queues[qid]);
+	dev->queues[qid] = nvme_create_queue(dev, qid + 1, dev->q_depth, qid);
+	if (IS_ERR(dev->queues[qid]))
+		return PTR_ERR(dev->queues[qid]);
+	set_bit(qid, dev->qids);
+
+	return 0;
+}
+
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = dev->pci_dev;
-	int result, cpu, i, vecs, nr_io_queues, db_bar_size, q_depth;
+	int result, i, vecs, nr_io_queues, db_bar_size;
 
-	nr_io_queues = num_online_cpus();
+	nr_io_queues = num_possible_cpus();
 	result = set_queue_count(dev, nr_io_queues);
 	if (result < 0)
 		return result;
@@ -1683,14 +1802,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		nr_io_queues = result;
 
 	/* Deregister the admin queue's interrupt */
-	free_irq(dev->entry[0].vector, dev->queues[0]);
+	free_irq(dev->entry[0].vector, dev->admin_queue);
 
 	db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
 	if (db_bar_size > 8192) {
 		iounmap(dev->bar);
 		dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
 		dev->dbs = ((void __iomem *)dev->bar) + 4096;
-		dev->queues[0]->q_db = dev->dbs;
+		dev->admin_queue->q_db = dev->dbs;
 	}
 
 	vecs = nr_io_queues;
@@ -1728,39 +1847,49 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * number of interrupts.
 	 */
 	nr_io_queues = vecs;
+	dev->nr_io_queues = nr_io_queues;
+	dev->qids = kzalloc(BITS_TO_LONGS(dev->nr_io_queues) * sizeof(long),
+								GFP_KERNEL);
 
-	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
+	result = queue_request_irq(dev, dev->admin_queue, "nvme admin");
 	/* XXX: handle failure here */
 
-	cpu = cpumask_first(cpu_online_mask);
-	for (i = 0; i < nr_io_queues; i++) {
-		irq_set_affinity_hint(dev->entry[i].vector, get_cpu_mask(cpu));
-		cpu = cpumask_next(cpu, cpu_online_mask);
-	}
-
-	q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
+	dev->q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
 								NVME_Q_DEPTH);
-	for (i = 0; i < nr_io_queues; i++) {
-		dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
-		if (IS_ERR(dev->queues[i + 1]))
-			return PTR_ERR(dev->queues[i + 1]);
-		dev->queue_count++;
-	}
-
-	for (; i < num_possible_cpus(); i++) {
-		int target = i % rounddown_pow_of_two(dev->queue_count - 1);
-		dev->queues[i + 1] = dev->queues[target + 1];
+	for (i = 0; i < min_t(int, nr_io_queues, num_online_cpus()); i++) {
+		int ret = nvme_make_queue(dev);
+		if (ret)
+			return ret;
 	}
+	nvme_assign_queues(dev);
 
 	return 0;
 }
 
+static void nvme_unassign_queue(struct nvme_queue *nvmeq, int cpu)
+{
+	if (!nvmeq)
+		return;
+
+	cpumask_clear_cpu(cpu, &nvmeq->cpu_mask);
+	*per_cpu_ptr(nvmeq->dev->cpu_queues, cpu) = NULL;
+	if (!cpumask_weight(&nvmeq->cpu_mask))
+		nvme_free_queue(nvmeq);
+	else
+		irq_set_affinity_hint(nvmeq->dev->entry[nvmeq->qid].vector,
+							&nvmeq->cpu_mask);
+}
+
 static void nvme_free_queues(struct nvme_dev *dev)
 {
-	int i;
+	int cpu;
 
-	for (i = dev->queue_count - 1; i >= 0; i--)
-		nvme_free_queue(dev, i);
+	for_each_online_cpu(cpu) {
+		struct nvme_queue *nvmeq = *per_cpu_ptr(dev->cpu_queues, cpu);
+		nvme_unassign_queue(nvmeq, cpu);
+	}
+	BUG_ON(bitmap_weight(dev->qids, dev->nr_io_queues));
+	nvme_free_queue(dev->admin_queue);
 }
 
 /*
@@ -1838,9 +1967,9 @@ static int nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
-	spin_lock(&dev_list_lock);
+	mutex_lock(&dev_list_lock);
 	list_del(&dev->node);
-	spin_unlock(&dev_list_lock);
+	mutex_unlock(&dev_list_lock);
 
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
 		list_del(&ns->list);
@@ -1887,9 +2016,9 @@ static int nvme_set_instance(struct nvme_dev *dev)
 		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
 			return -ENODEV;
 
-		spin_lock(&dev_list_lock);
+		mutex_lock(&dev_list_lock);
 		error = ida_get_new(&nvme_instance_ida, &instance);
-		spin_unlock(&dev_list_lock);
+		mutex_unlock(&dev_list_lock);
 	} while (error == -EAGAIN);
 
 	if (error)
@@ -1901,9 +2030,9 @@ static int nvme_set_instance(struct nvme_dev *dev)
 
 static void nvme_release_instance(struct nvme_dev *dev)
 {
-	spin_lock(&dev_list_lock);
+	mutex_lock(&dev_list_lock);
 	ida_remove(&nvme_instance_ida, dev->instance);
-	spin_unlock(&dev_list_lock);
+	mutex_unlock(&dev_list_lock);
 }
 
 static void nvme_free_dev(struct kref *kref)
@@ -1919,8 +2048,10 @@ static void nvme_free_dev(struct kref *kref)
 	nvme_release_prp_pools(dev);
 	pci_disable_device(dev->pci_dev);
 	pci_release_regions(dev->pci_dev);
+	free_percpu(dev->cpu_queues);
 	kfree(dev->queues);
 	kfree(dev->entry);
+	kfree(dev->qids);
 	kfree(dev);
 }
 
@@ -1959,6 +2090,39 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
+static int __cpuinit nvme_cpu_notify(struct notifier_block *self,
+				    unsigned long action, void *hcpu)
+{
+	int cpu = (unsigned long) hcpu;
+	struct nvme_queue *nvmeq;
+	struct nvme_dev *dev;
+
+	mutex_lock(&dev_list_lock);
+	list_for_each_entry(dev, &dev_list, node) {
+		nvmeq = *per_cpu_ptr(dev->cpu_queues, cpu);
+
+		switch (action) {
+		case CPU_ONLINE:
+		case CPU_ONLINE_FROZEN:
+			if (nvmeq)
+				break;
+			nvme_make_queue(dev);
+			nvme_assign_queues(dev);
+			break;
+		case CPU_DEAD:
+		case CPU_DEAD_FROZEN:
+			nvme_unassign_queue(nvmeq, cpu);
+			nvme_assign_queues(dev);
+			break;
+		default:
+			break;
+		}
+	}
+	mutex_unlock(&dev_list_lock);
+
+	return NOTIFY_OK;
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int bars, result = -ENOMEM;
@@ -1975,6 +2139,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 								GFP_KERNEL);
 	if (!dev->queues)
 		goto free;
+	dev->cpu_queues = alloc_percpu(struct nvme_queue *);
+	if (!dev->cpu_queues)
+		goto free;
 
 	if (pci_enable_device_mem(pdev))
 		goto free;
@@ -2013,11 +2180,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	result = nvme_configure_admin_queue(dev);
 	if (result)
 		goto unmap;
-	dev->queue_count++;
 
-	spin_lock(&dev_list_lock);
+	mutex_lock(&dev_list_lock);
 	list_add(&dev->node, &dev_list);
-	spin_unlock(&dev_list_lock);
+	mutex_unlock(&dev_list_lock);
 
 	result = nvme_dev_add(dev);
 	if (result)
@@ -2038,9 +2204,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  remove:
 	nvme_dev_remove(dev);
  delete:
-	spin_lock(&dev_list_lock);
+	mutex_lock(&dev_list_lock);
 	list_del(&dev->node);
-	spin_unlock(&dev_list_lock);
+	mutex_unlock(&dev_list_lock);
 
 	nvme_free_queues(dev);
  unmap:
@@ -2056,8 +2222,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_disable_device(pdev);
 	pci_release_regions(pdev);
  free:
+	free_percpu(dev->cpu_queues);
 	kfree(dev->queues);
 	kfree(dev->entry);
+	kfree(dev->qids);
 	kfree(dev);
 	return result;
 }
@@ -2105,6 +2273,10 @@ static struct pci_driver nvme_driver = {
 	.err_handler	= &nvme_err_handler,
 };
 
+static struct notifier_block __cpuinitdata nvme_cpu_notifier = {
+	.notifier_call	= nvme_cpu_notify,
+};
+
 static int __init nvme_init(void)
 {
 	int result;
@@ -2122,6 +2294,8 @@ static int __init nvme_init(void)
 	result = pci_register_driver(&nvme_driver);
 	if (result)
 		goto unregister_blkdev;
+
+	register_hotcpu_notifier(&nvme_cpu_notifier);
 	return 0;
 
  unregister_blkdev:
@@ -2133,6 +2307,7 @@ static int __init nvme_init(void)
 
 static void __exit nvme_exit(void)
 {
+	unregister_hotcpu_notifier(&nvme_cpu_notifier);
 	pci_unregister_driver(&nvme_driver);
 	unregister_blkdev(nvme_major, "nvme");
 	kthread_stop(nvme_thread);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3403c8f..8d6d7a6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -71,7 +71,9 @@ enum {
  */
 struct nvme_dev {
 	struct list_head node;
+	struct nvme_queue *admin_queue;
 	struct nvme_queue **queues;
+	struct nvme_queue *__percpu* cpu_queues;
 	u32 __iomem *dbs;
 	struct pci_dev *pci_dev;
 	struct dma_pool *prp_page_pool;
@@ -79,6 +81,9 @@ struct nvme_dev {
 	int instance;
 	int queue_count;
 	int db_stride;
+	int nr_io_queues;
+	int q_depth;
+	unsigned long *qids;
 	u32 ctrl_config;
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
-- 
1.7.0.4
