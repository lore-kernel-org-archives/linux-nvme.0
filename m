From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Jan 2013 18:20:41 -0700
Subject: [PATCH] NVMe: SQ/CQ NUMA locality
Message-ID: <1359422441-26433-1-git-send-email-keith.busch@intel.com>

Allocates the memory for the SQ/CQ pairs based on the NUMA node for the
CPU which the queue is associated with.

Signed-off-by: Keith Busch <keith.busch at intel.com>

This is related to an item off the "TODO" list that suggests experimenting
with NUMA locality. There is no dma alloc routine that takes a NUMA node id, so
the allocations are done a bit different. I am not sure if this is the correct
way to use dma_map/umap_single, but it seems to work fine. 

I tested this on an Intel SC2600C0 server with two E5-2600 Xeons (32 total
cpu threads) with all memory sockets fully populated and giving two NUMA
domains.  The only NVMe device I can test with is a pre-alpha level with an
FPGA, so it doesn't run as fast as it could, but I could still measure a
small difference using fio, though not a very significant difference.

With NUMA:

   READ: io=65534MB, aggrb=262669KB/s, minb=8203KB/s, maxb=13821KB/s, mint=152006msec, maxt=255482msec
  WRITE: io=65538MB, aggrb=262681KB/s, minb=8213KB/s, maxb=13792KB/s, mint=152006msec, maxt=255482msec

Without NUMA:

   READ: io=65535MB, aggrb=257995KB/s, minb=8014KB/s, maxb=13217KB/s, mint=159122msec, maxt=264339msec
  WRITE: io=65537MB, aggrb=258001KB/s, minb=8035KB/s, maxb=13198KB/s, mint=159122msec, maxt=264339msec

---
 drivers/block/nvme.c |   60 +++++++++++++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 993c014..af9bf2e 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -898,10 +898,12 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
 {
-	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
-	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
-					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
+	dma_unmap_single(nvmeq->q_dmadev, nvmeq->cq_dma_addr,
+				CQ_SIZE(nvmeq->q_depth), DMA_FROM_DEVICE);
+	free_pages_exact((void *)nvmeq->cqes, CQ_SIZE(nvmeq->q_depth));
+	dma_unmap_single(nvmeq->q_dmadev, nvmeq->sq_dma_addr,
+				SQ_SIZE(nvmeq->q_depth), DMA_TO_DEVICE);
+	free_pages_exact((void *)nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
 	kfree(nvmeq);
 }
 
@@ -931,25 +933,28 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
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
+							GFP_KERNEL, nid);
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
 
-	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr, GFP_KERNEL);
+	nvmeq->sq_cmds = alloc_pages_exact_nid(nid, SQ_SIZE(depth), GFP_KERNEL);
 	if (!nvmeq->sq_cmds)
 		goto free_cqdma;
+	nvmeq->sq_dma_addr = dma_map_single(dmadev, (void *)nvmeq->sq_cmds,
+					SQ_SIZE(depth), DMA_TO_DEVICE);
 
 	nvmeq->q_dmadev = dmadev;
 	nvmeq->dev = dev;
@@ -966,8 +971,8 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	return nvmeq;
 
  free_cqdma:
-	dma_free_coherent(dmadev, CQ_SIZE(nvmeq->q_depth), (void *)nvmeq->cqes,
-							nvmeq->cq_dma_addr);
+	dma_unmap_single(dmadev, nvmeq->cq_dma_addr, CQ_SIZE(depth), DMA_FROM_DEVICE);
+	free_pages_exact((void *)nvmeq->cqes, CQ_SIZE(depth));
  free_nvmeq:
 	kfree(nvmeq);
 	return NULL;
@@ -986,10 +991,10 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 }
 
 static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
-					int qid, int cq_size, int vector)
+					int qid, int cq_size, int vector, int nid)
 {
 	int result;
-	struct nvme_queue *nvmeq = nvme_alloc_queue(dev, qid, cq_size, vector);
+	struct nvme_queue *nvmeq = nvme_alloc_queue(dev, qid, cq_size, vector, nid);
 
 	if (!nvmeq)
 		return ERR_PTR(-ENOMEM);
@@ -1013,10 +1018,12 @@ static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
  release_cq:
 	adapter_delete_cq(dev, qid);
  free_nvmeq:
-	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
-	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
-					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
+	dma_unmap_single(nvmeq->q_dmadev, nvmeq->cq_dma_addr,
+				CQ_SIZE(nvmeq->q_depth), DMA_FROM_DEVICE);
+	free_pages_exact((void *)nvmeq->cqes, CQ_SIZE(nvmeq->q_depth));
+	dma_unmap_single(nvmeq->q_dmadev, nvmeq->sq_dma_addr,
+				SQ_SIZE(nvmeq->q_depth), DMA_TO_DEVICE);
+	free_pages_exact((void *)nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
 	kfree(nvmeq);
 	return ERR_PTR(result);
 }
@@ -1031,7 +1038,7 @@ static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
 
-	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
+	nvmeq = nvme_alloc_queue(dev, 0, 64, 0, -1);
 	if (!nvmeq)
 		return -ENOMEM;
 
@@ -1425,7 +1432,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 
 static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
 {
-	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
+	int result, cpu, nid, i, nr_io_queues, db_bar_size, q_depth;
 
 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -1465,21 +1472,20 @@ static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
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
 
+	/* XXX: use NUMA node for optimal queue wrapping */
 	for (; i < num_possible_cpus(); i++) {
 		int target = i % rounddown_pow_of_two(dev->queue_count - 1);
 		dev->queues[i + 1] = dev->queues[target + 1];
-- 
1.7.0.4
