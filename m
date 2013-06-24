From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Jun 2013 14:30:56 -0600
Subject: [PATCHv3 2/5] NVMe: Separate queue alloc/free from create/delete
In-Reply-To: <1372105859-27850-1-git-send-email-keith.busch@intel.com>
References: <1372105859-27850-1-git-send-email-keith.busch@intel.com>
Message-ID: <1372105859-27850-3-git-send-email-keith.busch@intel.com>

This separates nvme queue allocation from creation, and queue deletion
from freeing. This is so that we may in the future temporarily disable
queues and reuse the same memory when bringing them back online, like
coming back from suspend state.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  165 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 119 insertions(+), 46 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3751888..e16d962 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -81,6 +81,7 @@ struct nvme_queue {
 	u16 cq_head;
 	u8 cq_phase;
 	u8 cqe_seen;
+	bool q_suspended;
 	unsigned long cmdid_data[];
 };
 
@@ -784,8 +785,14 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
 	int result = -EBUSY;
 
+	if (!nvmeq) {
+		put_nvmeq(NULL);
+		bio_endio(bio, -EIO);
+		return;
+	}
+
 	spin_lock_irq(&nvmeq->q_lock);
-	if (bio_list_empty(&nvmeq->sq_cong))
+	if (!nvmeq->q_suspended && bio_list_empty(&nvmeq->sq_cong))
 		result = nvme_submit_bio_queue(nvmeq, ns, bio);
 	if (unlikely(result)) {
 		if (bio_list_empty(&nvmeq->sq_cong))
@@ -1021,6 +1028,13 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
 {
+	spin_lock_irq(&nvmeq->q_lock);
+	while (bio_list_peek(&nvmeq->sq_cong)) {
+		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
+		bio_endio(bio, -EIO);
+	}
+	spin_unlock_irq(&nvmeq->q_lock);
+
 	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
@@ -1028,17 +1042,28 @@ static void nvme_free_queue_mem(struct nvme_queue *nvmeq)
 	kfree(nvmeq);
 }
 
-static void nvme_free_queue(struct nvme_dev *dev, int qid)
+static void nvme_free_queues(struct nvme_dev *dev)
+{
+	int i;
+
+	for (i = dev->queue_count - 1; i >= 0; i--) {
+		nvme_free_queue_mem(dev->queues[i]);
+		dev->queue_count--;
+		dev->queues[i] = NULL;
+	}
+}
+
+static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
 	int vector = dev->entry[nvmeq->cq_vector].vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
-	nvme_cancel_ios(nvmeq, false);
-	while (bio_list_peek(&nvmeq->sq_cong)) {
-		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
-		bio_endio(bio, -EIO);
+	if (nvmeq->q_suspended) {
+		spin_unlock_irq(&nvmeq->q_lock);
+		return;
 	}
+	nvmeq->q_suspended = true;
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	irq_set_affinity_hint(vector, NULL);
@@ -1050,7 +1075,10 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 		adapter_delete_cq(dev, qid);
 	}
 
-	nvme_free_queue_mem(nvmeq);
+	spin_lock_irq(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	nvme_cancel_ios(nvmeq, false);
+	spin_unlock_irq(&nvmeq->q_lock);
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
@@ -1085,6 +1113,8 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;
+	nvmeq->q_suspended = true;
+	dev->queue_count++;
 
 	return nvmeq;
 
@@ -1108,40 +1138,50 @@ static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
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
+
+static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
+{
+	struct nvme_dev *dev = nvmeq->dev;
+	int result;
 
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
@@ -1196,9 +1236,13 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
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
+		dev->queues[0] = nvmeq;
+	}
 
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
@@ -1215,17 +1259,16 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 	result = nvme_enable_ctrl(dev, cap);
 	if (result)
-		goto free_q;
+		return result;
 
 	result = queue_request_irq(dev, nvmeq, "nvme admin");
 	if (result)
-		goto free_q;
+		return result;
 
-	dev->queues[0] = nvmeq;
-	return result;
+	spin_lock(&nvmeq->q_lock);
+	nvme_init_queue(nvmeq, 0);
+	spin_unlock(&nvmeq->q_lock);
 
- free_q:
-	nvme_free_queue_mem(nvmeq);
 	return result;
 }
 
@@ -1386,6 +1429,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	put_nvmeq(nvmeq);
 	if (length != (io.nblocks + 1) << ns->lba_shift)
 		status = -ENOMEM;
+	else if (!nvmeq || nvmeq->q_suspended)
+		status = -EBUSY;
 	else
 		status = nvme_submit_sync_cmd(nvmeq, &c, NULL, NVME_IO_TIMEOUT);
 
@@ -1536,9 +1581,12 @@ static int nvme_kthread(void *data)
 				if (!nvmeq)
 					continue;
 				spin_lock_irq(&nvmeq->q_lock);
+				if (nvmeq->q_suspended)
+					goto unlock;
 				nvme_process_cq(nvmeq);
 				nvme_cancel_ios(nvmeq, true);
 				nvme_resubmit_bios(nvmeq);
+ unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
 		}
@@ -1726,7 +1774,23 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	nr_io_queues = vecs;
 
 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
-	/* XXX: handle failure here */
+	if (result)
+		goto free_queues;
+
+	/* Free previously allocated queues that are no longer usable */
+	spin_lock(&dev_list_lock);
+	for (i = dev->queue_count - 1; i > nr_io_queues; i--) {
+		struct nvme_queue *nvmeq = dev->queues[i];
+
+		spin_lock(&nvmeq->q_lock);
+		nvme_cancel_ios(nvmeq, false);
+		spin_unlock(&nvmeq->q_lock);
+
+		nvme_free_queue_mem(nvmeq);
+		dev->queue_count--;
+		dev->queues[i] = NULL;
+	}
+	spin_unlock(&dev_list_lock);
 
 	cpu = cpumask_first(cpu_online_mask);
 	for (i = 0; i < nr_io_queues; i++) {
@@ -1736,11 +1800,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
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
@@ -1748,15 +1813,20 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
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
@@ -1889,6 +1959,10 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 static int nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;
+	int i;
+
+	for (i = dev->queue_count - 1; i >= 0; i--)
+		 nvme_disable_queue(dev, i);
 
 	spin_lock(&dev_list_lock);
 	list_del(&dev->node);
@@ -2039,7 +2113,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	result = nvme_configure_admin_queue(dev);
 	if (result)
 		goto unmap;
-	dev->queue_count++;
 
 	spin_lock(&dev_list_lock);
 	list_add(&dev->node, &dev_list);
-- 
1.7.0.4
