From: keith.busch@intel.com (Keith Busch)
Date: Mon,  6 May 2013 17:03:32 -0600
Subject: [PATCH 2/5] NVMe: Separate queue alloc/free from create/delete
In-Reply-To: <1367881415-7978-1-git-send-email-keith.busch@intel.com>
References: <1367881415-7978-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367881415-7978-3-git-send-email-keith.busch@intel.com>

This separates nvme queue allocation from creation, and queue deletion
from freeing. This is so that we may in the future temporarily disable
queues and reuse the same memory when bringing them back online, like
coming back from suspend state.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  155 +++++++++++++++++++++++++++++++++------------
 1 files changed, 114 insertions(+), 41 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b18ddef..997025b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -80,6 +80,7 @@ struct nvme_queue {
 	u16 sq_tail;
 	u16 cq_head;
 	u16 cq_phase;
+	bool q_suspended;
 	unsigned long cmdid_data[];
 };
 
@@ -715,7 +716,7 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	int result = -EBUSY;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	if (bio_list_empty(&nvmeq->sq_cong))
+	if (!nvmeq->q_suspended && bio_list_empty(&nvmeq->sq_cong))
 		result = nvme_submit_bio_queue(nvmeq, ns, bio);
 	if (unlikely(result)) {
 		if (bio_list_empty(&nvmeq->sq_cong))
@@ -985,6 +986,14 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
 {
+	spin_lock_irq(&nvmeq->q_lock);
+	while (bio_list_peek(&nvmeq->sq_cong)) {
+		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
+		bio_endio(bio, -EIO);
+	}
+	spin_unlock_irq(&nvmeq->q_lock);
+
+	nvmeq->dev->queue_count--;
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
@@ -992,17 +1001,23 @@ static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
 	kfree(nvmeq);
 }
 
-static void nvme_free_queue(struct nvme_dev *dev, int qid)
+static void nvme_free_queues(struct nvme_dev *dev)
+{
+	int i;
+
+	for (i = dev->queue_count - 1; i >= 0; i--) {
+		nvme_free_queue_mem(dev->queues[i]);
+		dev->queues[i] = NULL;
+	}
+}
+
+static void nvme_disable_queue(struct nvme_dev *dev, u16 qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
 	int vector = dev->entry[nvmeq->cq_vector].vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	nvme_cancel_ios(nvmeq, false);
-	while (bio_list_peek(&nvmeq->sq_cong)) {
-		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
-		bio_endio(bio, -EIO);
-	}
+	nvmeq->q_suspended = true;
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	irq_set_affinity_hint(vector, NULL);
@@ -1014,7 +1029,10 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 		adapter_delete_cq(dev, qid);
 	}
 
-	nvme_free_queue_mem(nvmeq);
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	nvme_cancel_ios(nvmeq, false);
+	spin_unlock_irq(&nvmeq->q_lock);
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
@@ -1049,7 +1067,9 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
+	nvmeq->q_suspended = true;
 
+	dev->queue_count++;
 	return nvmeq;
 
  free_cqdma:
@@ -1072,40 +1092,49 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
 }
 
-static struct nvme_queue *nvme_create_queue(struct nvme_dev *dev, int qid,
-					    int cq_size, int vector)
+static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
-	int result;
-	struct nvme_queue *nvmeq = nvme_alloc_queue(dev, qid, cq_size, vector);
+	struct nvme_dev *dev = nvmeq->dev;
+	unsigned extra = DIV_ROUND_UP(nvmeq->q_depth, 8) + (nvmeq->q_depth *
+						sizeof(struct nvme_cmd_info));
+	nvmeq->sq_tail = 0;
+	nvmeq->cq_head = 0;
+	nvmeq->cq_phase = 1;
+	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
+	memset (nvmeq->cmdid_data, 0, extra);
+	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+	nvme_cancel_ios(nvmeq, false);
+	nvmeq->q_suspended = false;
+}
 
-	if (!nvmeq)
-		return ERR_PTR(-ENOMEM);
+static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
+{
+	int result;
+	struct nvme_dev *dev = nvmeq->dev;
 
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
-		goto free_nvmeq;
+		return result;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
 		goto release_cq;
 
 	result = queue_request_irq(dev, nvmeq, "nvme");
-	if (result < 0)
+	if (result)
 		goto release_sq;
 
-	return nvmeq;
+	spin_lock(&nvmeq->q_lock);
+	nvme_init_queue(nvmeq, qid);
+	spin_unlock(&nvmeq->q_lock);
+
+	return result;
 
  release_sq:
 	adapter_delete_sq(dev, qid);
  release_cq:
 	adapter_delete_cq(dev, qid);
- free_nvmeq:
-	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
-	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
-					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
-	kfree(nvmeq);
-	return ERR_PTR(result);
+	return result;
 }
 
 static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool enabled)
@@ -1160,9 +1189,12 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
-	if (!nvmeq)
-		return -ENOMEM;
+	nvmeq = dev->queues[0];
+	if (!nvmeq) {
+		nvmeq = nvme_alloc_queue(dev, 0, 64, 0);
+		if (!nvmeq)
+			return -ENOMEM;
+	}
 
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
@@ -1186,10 +1218,16 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 		goto free_q;
 
 	dev->queues[0] = nvmeq;
+
+	spin_lock(&nvmeq->q_lock);
+	nvme_init_queue(nvmeq, 0);
+	spin_unlock(&nvmeq->q_lock);
+
 	return result;
 
  free_q:
 	nvme_free_queue_mem(nvmeq);
+	dev->queues[0] = NULL;
 	return result;
 }
 
@@ -1349,6 +1387,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	put_nvmeq(nvmeq);
 	if (length != (io.nblocks + 1) << ns->lba_shift)
 		status = -ENOMEM;
+	else if (nvmeq->q_suspended)
+		status = -EBUSY;
 	else
 		status = nvme_submit_sync_cmd(nvmeq, &c, NULL, NVME_IO_TIMEOUT);
 
@@ -1495,10 +1535,13 @@ static int nvme_kthread(void *data)
 				if (!nvmeq)
 					continue;
 				spin_lock_irq(&nvmeq->q_lock);
+				if (nvmeq->q_suspended)
+					goto unlock;
 				if (nvme_process_cq(nvmeq))
 					printk("process_cq did something\n");
 				nvme_cancel_ios(nvmeq, true);
 				nvme_resubmit_bios(nvmeq);
+ unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
 		}
@@ -1664,7 +1707,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
-	/* XXX: handle failure here */
+	if (result)
+		goto free_queues;
 
 	cpu = cpumask_first(cpu_online_mask);
 	for (i = 0; i < nr_io_queues; i++) {
@@ -1672,13 +1716,28 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		cpu = cpumask_next(cpu, cpu_online_mask);
 	}
 
+	/* Free previously allocated queues that are no longer usable */
+	spin_lock(&dev_list_lock);
+	for (i = dev->queue_count - 1; i >= nr_io_queues; i--) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+
+		spin_lock(&nvmeq->q_lock);
+		nvme_cancel_ios(nvmeq, false);
+		spin_unlock(&nvmeq->q_lock);
+
+		nvme_free_queue_mem(nvmeq);
+		dev->queues[i] = NULL;
+	}
+	spin_unlock(&dev_list_lock);
+
 	q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
 								NVME_Q_DEPTH);
-	for (i = 0; i < nr_io_queues; i++) {
-		dev->queues[i + 1] = nvme_create_queue(dev, i + 1, q_depth, i);
-		if (IS_ERR(dev->queues[i + 1]))
-			return PTR_ERR(dev->queues[i + 1]);
-		dev->queue_count++;
+	for (i = dev->queue_count - 1; i < nr_io_queues; i++) {
+		dev->queues[i + 1] = nvme_alloc_queue(dev, i + 1, q_depth, i);
+		if (!dev->queues[i + 1]) {
+			result = -ENOMEM;
+			goto free_queues;
+		}
 	}
 
 	for (; i < num_possible_cpus(); i++) {
@@ -1686,15 +1745,20 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		dev->queues[i + 1] = dev->queues[target + 1];
 	}
 
-	return 0;
-}
+	for (i = 1; i < dev->queue_count; i++) {
+		result = nvme_create_queue(dev->queues[i], i);
+		if (result) {
+			for (--i; i > 0; i--)
+				nvme_disable_queue(dev, i);
+			goto free_queues;
+		}
+	}
 
-static void nvme_free_queues(struct nvme_dev *dev)
-{
-	int i;
+	return 0;
 
-	for (i = dev->queue_count - 1; i >= 0; i--)
-		nvme_free_queue(dev, i);
+ free_queues:
+	nvme_free_queues(dev);
+	return result;
 }
 
 /*
@@ -1808,10 +1872,20 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 	pci_release_regions(dev->pci_dev);
 }
 
+static void nvme_disable_queues(struct nvme_dev *dev)
+{
+	int i;
+
+	for (i = dev->queue_count - 1; i >= 0; i--)
+		 nvme_disable_queue(dev, i);
+}
+
 static int nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
 
+	nvme_disable_queues(dev);
+
 	spin_lock(&dev_list_lock);
 	list_del(&dev->node);
 	spin_unlock(&dev_list_lock);
@@ -1961,7 +2035,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	result = nvme_configure_admin_queue(dev);
 	if (result)
 		goto unmap;
-	dev->queue_count++;
 
 	spin_lock(&dev_list_lock);
 	list_add(&dev->node, &dev_list);
-- 
1.7.0.4
