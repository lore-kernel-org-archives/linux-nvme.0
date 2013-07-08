From: keith.busch@intel.com (Keith Busch)
Date: Mon,  8 Jul 2013 13:35:59 -0600
Subject: [PATCHv2] NVMe: IO Queue NUMA locality
Message-ID: <1373312159-2255-1-git-send-email-keith.busch@intel.com>

Allocates queue memory local to the cpu for memory read by the cpu and
local to the device for memory read by the device.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
I've gotten better at testing this, pinning processes to specific cores
and seeing what happens. I find that no matter how you allocate memory,
running IO from a cpu on the same numa node as the device provides no
measurable change.

There is measurable difference when running IO on a cpu on another
domain; however, my particular device hits its peak performance on
either domain at higher queue depths and block sizes, so I'm only able
to see a difference at lower io depths. The best gains topped out at 2%
improvement with this patch vs the existing code.

No test performed worse.

I understand this method of allocating and mapping memory may not work
for CPUs without cache-coherency, but I'm not sure if there is another
way to allocate coherent memory for a specific NUMA node.

 drivers/block/nvme-core.c |   42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 711b51c..9cedfa0 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1022,8 +1022,10 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
 {
-	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
+	dma_unmap_single(nvmeq->q_dmadev, nvmeq->cq_dma_addr,
+				CQ_SIZE(nvmeq->q_depth), DMA_FROM_DEVICE);
+	free_pages_exact((void *)nvmeq->cqes, CQ_SIZE(nvmeq->q_depth));
+
 	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
 					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
 	kfree(nvmeq);
@@ -1055,20 +1057,22 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
-							int depth, int vector)
+						int depth, int vector, int nid)
 {
 	struct device *dmadev = &dev->pci_dev->dev;
 	unsigned extra = DIV_ROUND_UP(depth, 8) + (depth *
 						sizeof(struct nvme_cmd_info));
-	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq) + extra, GFP_KERNEL);
+	struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq) + extra,
+						GFP_KERNEL, nid);
 	if (!nvmeq)
 		return NULL;
 
-	nvmeq->cqes = dma_alloc_coherent(dmadev, CQ_SIZE(depth),
-					&nvmeq->cq_dma_addr, GFP_KERNEL);
+	nvmeq->cqes = alloc_pages_exact_nid(nid, CQ_SIZE(depth), GFP_KERNEL);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(depth));
+	nvmeq->cq_dma_addr = dma_map_single(dmadev, (void *)nvmeq->cqes,
+					CQ_SIZE(depth), DMA_FROM_DEVICE);
 
 	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
 					&nvmeq->sq_dma_addr, GFP_KERNEL);
@@ -1090,8 +1094,9 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	return nvmeq;
 
  free_cqdma:
-	dma_free_coherent(dmadev, CQ_SIZE(depth), (void *)nvmeq->cqes,
-							nvmeq->cq_dma_addr);
+	dma_unmap_single(nvmeq->q_dmadev, nvmeq->cq_dma_addr,
+				CQ_SIZE(nvmeq->q_depth), DMA_FROM_DEVICE);
+	free_pages_exact((void *)nvmeq->cqes, CQ_SIZE(nvmeq->q_depth));
  free_nvmeq:
 	kfree(nvmeq);
 	return NULL;
@@ -1110,10 +1115,11 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 }
 
 static struct nvme_queue *nvme_create_queue(struct nvme_dev *dev, int qid,
-					    int cq_size, int vector)
+					    int cq_size, int vector, int nid)
 {
 	int result;
-	struct nvme_queue *nvmeq = nvme_alloc_queue(dev, qid, cq_size, vector);
+	struct nvme_queue *nvmeq = nvme_alloc_queue(dev, qid, cq_size, vector,
+									nid);
 
 	if (!nvmeq)
 		return ERR_PTR(-ENOMEM);
@@ -1200,7 +1206,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
+	nvmeq = nvme_alloc_queue(dev, 0, 64, 0, -1);
 	if (!nvmeq)
 		return -ENOMEM;
 
@@ -1671,7 +1677,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = dev->pci_dev;
-	int result, cpu, i, vecs, nr_io_queues, db_bar_size, q_depth;
+	int result, cpu, nid, i, vecs, nr_io_queues, db_bar_size, q_depth;
 
 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -1730,19 +1736,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
 	/* XXX: handle failure here */
 
-	cpu = cpumask_first(cpu_online_mask);
-	for (i = 0; i < nr_io_queues; i++) {
-		irq_set_affinity_hint(dev->entry[i].vector, get_cpu_mask(cpu));
-		cpu = cpumask_next(cpu, cpu_online_mask);
-	}
-
 	q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
 								NVME_Q_DEPTH);
+	cpu = cpumask_first(cpu_online_mask);
 	for (i = 0; i < nr_io_queues; i++) {
-		dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
+		irq_set_affinity_hint(dev->entry[i].vector, get_cpu_mask(cpu));
+		nid = cpu_to_node(cpu);
+		dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i, nid);
 		if (IS_ERR(dev->queues[i + 1]))
 			return PTR_ERR(dev->queues[i + 1]);
 		dev->queue_count++;
+		cpu = cpumask_next(cpu, cpu_online_mask);
 	}
 
 	for (; i < num_possible_cpus(); i++) {
-- 
1.7.10.4
