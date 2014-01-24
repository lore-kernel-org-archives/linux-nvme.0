From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jan 2014 16:50:49 -0700
Subject: [PATCH 2/7] NVMe: RCU access to nvme_queue
In-Reply-To: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
References: <1390607454-23273-1-git-send-email-keith.busch@intel.com>
Message-ID: <1390607454-23273-3-git-send-email-keith.busch@intel.com>

This adds rcu protected access to nvme_queue to fix a potential race
between a surprise removal freeing the queue and a thread with open
reference on a NVMe block device using that queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   53 ++++++++++++++++++++-------------------------
 include/linux/nvme.h      |    2 +-
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7163a2f..e27f8d7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -74,6 +74,7 @@ struct async_cmd_info {
  * commands and one for I/O commands).
  */
 struct nvme_queue {
+	struct rcu_head r_head;
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
 	spinlock_t q_lock;
@@ -263,12 +264,16 @@ static void *cancel_cmdid(struct nvme_queue *nvmeq, int cmdid,
 
 struct nvme_queue *get_nvmeq(struct nvme_dev *dev)
 {
-	return dev->queues[get_cpu() + 1];
+	int queue;
+	rcu_read_lock();
+	queue = get_cpu() + 1;
+	return rcu_dereference(dev->queues[queue]);
 }
 
 void put_nvmeq(struct nvme_queue *nvmeq)
 {
 	put_cpu();
+	rcu_read_unlock();
 }
 
 /**
@@ -818,9 +823,9 @@ static void nvme_make_request(struct request_queue *q, struct bio *bio)
 	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
 	int result = -EBUSY;
 
-	if (!nvmeq) {
+	if (unlikely(!nvmeq)) {
 		put_nvmeq(NULL);
-		bio_endio(bio, -EIO);
+		bio_endio(bio, -ENXIO);
 		return;
 	}
 
@@ -1135,8 +1140,10 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 	}
 }
 
-static void nvme_free_queue(struct nvme_queue *nvmeq)
+static void nvme_free_queue(struct rcu_head *r)
 {
+	struct nvme_queue *nvmeq = container_of(r, struct nvme_queue, r_head);
+
 	spin_lock_irq(&nvmeq->q_lock);
 	while (bio_list_peek(&nvmeq->sq_cong)) {
 		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
@@ -1155,10 +1162,13 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
 	int i;
 
+	for (i = num_possible_cpus(); i > dev->queue_count - 1; i--)
+		rcu_assign_pointer(dev->queues[i], NULL);
 	for (i = dev->queue_count - 1; i >= lowest; i--) {
-		nvme_free_queue(dev->queues[i]);
+		struct nvme_queue *nvmeq = dev->queues[i];
+		rcu_assign_pointer(dev->queues[i], NULL);
+		call_rcu(&nvmeq->r_head, nvme_free_queue);
 		dev->queue_count--;
-		dev->queues[i] = NULL;
 	}
 }
 
@@ -1778,8 +1788,11 @@ static int nvme_kthread(void *data)
 				queue_work(nvme_workq, &dev->reset_work);
 				continue;
 			}
+
+			rcu_read_lock();
 			for (i = 0; i < dev->queue_count; i++) {
-				struct nvme_queue *nvmeq = dev->queues[i];
+				struct nvme_queue *nvmeq =
+						rcu_dereference(dev->queues[i]);
 				if (!nvmeq)
 					continue;
 				spin_lock_irq(&nvmeq->q_lock);
@@ -1791,6 +1804,7 @@ static int nvme_kthread(void *data)
  unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
+			rcu_read_unlock();
 		}
 		spin_unlock(&dev_list_lock);
 		schedule_timeout(round_jiffies_relative(HZ));
@@ -1956,19 +1970,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	/* Free previously allocated queues that are no longer usable */
-	spin_lock(&dev_list_lock);
-	for (i = dev->queue_count - 1; i > nr_io_queues; i--) {
-		struct nvme_queue *nvmeq = dev->queues[i];
-
-		spin_lock_irq(&nvmeq->q_lock);
-		nvme_cancel_ios(nvmeq, false);
-		spin_unlock_irq(&nvmeq->q_lock);
-
-		nvme_free_queue(nvmeq);
-		dev->queue_count--;
-		dev->queues[i] = NULL;
-	}
-	spin_unlock(&dev_list_lock);
+	nvme_free_queues(dev, nr_io_queues + 1);
 
 	cpu = cpumask_first(cpu_online_mask);
 	for (i = 0; i < nr_io_queues; i++) {
@@ -2459,18 +2461,10 @@ static int nvme_remove_dead_ctrl(void *arg)
 
 static void nvme_remove_disks(struct work_struct *ws)
 {
-	int i;
 	struct nvme_dev *dev = container_of(ws, struct nvme_dev, reset_work);
 
 	nvme_dev_remove(dev);
-	spin_lock(&dev_list_lock);
-	for (i = dev->queue_count - 1; i > 0; i--) {
-		BUG_ON(!dev->queues[i] || !dev->queues[i]->q_suspended);
-		nvme_free_queue(dev->queues[i]);
-		dev->queue_count--;
-		dev->queues[i] = NULL;
-	}
-	spin_unlock(&dev_list_lock);
+	nvme_free_queues(dev, 1);
 }
 
 static int nvme_dev_resume(struct nvme_dev *dev)
@@ -2595,6 +2589,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
 	nvme_free_queues(dev, 0);
+	rcu_barrier();
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 69ae03f..98d367b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -73,7 +73,7 @@ enum {
  */
 struct nvme_dev {
 	struct list_head node;
-	struct nvme_queue **queues;
+	struct nvme_queue __rcu **queues;
 	u32 __iomem *dbs;
 	struct pci_dev *pci_dev;
 	struct dma_pool *prp_page_pool;
-- 
1.7.10.4
