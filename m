From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 31 Jan 2014 12:47:57 -0500
Subject: [PATCH 5/7] NVMe: Per-cpu IO queues
In-Reply-To: <1390607454-23273-6-git-send-email-keith.busch@intel.com>
References: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
 <1390607454-23273-6-git-send-email-keith.busch@intel.com>
Message-ID: <20140131174757.GB2285@linux.intel.com>

On Fri, Jan 24, 2014@04:50:52PM -0700, Keith Busch wrote:
> NVMe IO queues are associated with CPUs, and linux provices a handy
> per-cpu implementation. This gives us a convienient way to optimally
> assign queues to multiple cpus when the device supports fewer queues
> than the host has cpus. The previous implementation did not share these
> optimally and may have shared very poorly in some situations. This new
> way will share queues among cpus that are "close" together and should
> have the lowest penalty for lock contention.

I got to thinking about this one after sparse flagged a couple of
problems.  Why not do it this way?

Advantage that it only requires one percpu allocation.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e302f55..0afa8ee 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -268,16 +268,15 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 
 struct nvme_queue *get_nvmeq(struct nvme_dev *dev) __acquires(RCU)
 {
-	struct nvme_queue __rcu **nvmeqp;
+	unsigned short i = get_cpu_var(*dev->io_queue);
 	rcu_read_lock();
-	nvmeqp = get_cpu_ptr(dev->io_queues);
-	return rcu_dereference(*nvmeqp);
+	return rcu_dereference(dev->queues[i]);
 }
 
 void put_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
 {
-	put_cpu_ptr(nvmeq->dev->io_queues);
 	rcu_read_unlock();
+	put_cpu_var(nvmeq->dev->io_queue);
 }
 
 /**
@@ -1171,9 +1170,6 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 		struct nvme_queue *nvmeq = dev->queues[i];
 
 		for_each_cpu(cpu, &nvmeq->cpu_mask) {
-			rcu_assign_pointer(
-				*per_cpu_ptr(dev->io_queues, cpu),
-				NULL);
 			cpumask_clear_cpu(cpu, &nvmeq->cpu_mask);
 		}
 		rcu_assign_pointer(dev->queues[i], NULL);
@@ -1923,9 +1919,7 @@ static void nvme_set_queue_cpus(cpumask_t *qmask, struct nvme_queue *nvmeq,
 		if (cpus_weight(nvmeq->cpu_mask) >= count)
 			break;
 		if (!cpumask_test_and_set_cpu(cpu, &nvmeq->cpu_mask))
-			rcu_assign_pointer(
-				*per_cpu_ptr(nvmeq->dev->io_queues, cpu),
-				nvmeq);
+			*per_cpu_ptr(nvmeq->dev->io_queue, cpu) = nvmeq->qid;
 	}
 }
 
@@ -2040,8 +2034,7 @@ static void nvme_assign_io_queues(struct nvme_dev *dev)
 	cpumask_andnot(&unassigned_cpus, cpu_possible_mask, cpu_online_mask);
 	i = 0;
 	for_each_cpu(cpu, &unassigned_cpus)
-		rcu_assign_pointer(*per_cpu_ptr(dev->io_queues, cpu),
-					dev->queues[(i++ % queues) + 1]);
+		*per_cpu_ptr(dev->io_queue, cpu) = (i++ % queues) + 1;
 }
 
 static int set_queue_count(struct nvme_dev *dev, int count)
@@ -2532,7 +2525,7 @@ static void nvme_free_dev(struct kref *kref)
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
 
 	nvme_free_namespaces(dev);
-	free_percpu(dev->io_queues);
+	free_percpu(dev->io_queue);
 	kfree(dev->affinity_masks);
 	kfree(dev->queues);
 	kfree(dev->entry);
@@ -2683,8 +2676,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 				sizeof(*dev->affinity_masks), GFP_KERNEL);
 	if (!dev->queues)
 		goto free;
-	dev->io_queues = alloc_percpu(struct nvme_queue *);
-	if (!dev->io_queues)
+	dev->io_queue = alloc_percpu(unsigned short);
+	if (!dev->io_queue)
 		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
@@ -2734,7 +2727,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  release:
 	nvme_release_instance(dev);
  free:
-	free_percpu(dev->io_queues);
+	free_percpu(dev->io_queue);
 	kfree(dev->affinity_masks);
 	kfree(dev->queues);
 	kfree(dev->entry);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 89966c0..0c051e5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -74,7 +74,7 @@ enum {
 struct nvme_dev {
 	struct list_head node;
 	struct nvme_queue __rcu **queues;
-	struct nvme_queue __rcu * __percpu *io_queues;
+	unsigned short __percpu *io_queue;
 	u32 __iomem *dbs;
 	struct pci_dev *pci_dev;
 	struct dma_pool *prp_page_pool;
