From: keith.busch@intel.com (Keith Busch)
Date: Mon,  7 Jul 2014 09:14:42 -0600
Subject: [PATCH] NVMe: Call nvme_free_queue directly
Message-ID: <1404746082-4806-1-git-send-email-keith.busch@intel.com>

Rather than relying on call_rcu, this patch directly frees the
nvme_queue's memory after ensuring no readers exist. Some arch specific
dma_free_coherent implementations may not be called from a call_rcu's
soft interrupt context, hence the change.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reported-by: Matthew Minter <matthew_minter at xyratex.com>
---
 drivers/block/nvme-core.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..2c85e78 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -90,7 +90,7 @@ struct async_cmd_info {
  * commands and one for I/O commands).
  */
 struct nvme_queue {
-	struct rcu_head r_head;
+	struct llist_node node;
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
 	char irqname[24];	/* nvme4294967295-65535\0 */
@@ -1187,10 +1187,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 	}
 }
 
-static void nvme_free_queue(struct rcu_head *r)
+static void nvme_free_queue(struct nvme_queue *nvmeq)
 {
-	struct nvme_queue *nvmeq = container_of(r, struct nvme_queue, r_head);
-
 	spin_lock_irq(&nvmeq->q_lock);
 	while (bio_list_peek(&nvmeq->sq_cong)) {
 		struct bio *bio = bio_list_pop(&nvmeq->sq_cong);
@@ -1220,14 +1218,21 @@ static void nvme_free_queue(struct rcu_head *r)
 
 static void nvme_free_queues(struct nvme_dev *dev, int lowest)
 {
+	LLIST_HEAD(q_list);
+	struct nvme_queue *nvmeq, *next;
+	struct llist_node *entry;
 	int i;
 
 	for (i = dev->queue_count - 1; i >= lowest; i--) {
-		struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
+		nvmeq = raw_nvmeq(dev, i);
 		rcu_assign_pointer(dev->queues[i], NULL);
-		call_rcu(&nvmeq->r_head, nvme_free_queue);
+		llist_add(&nvmeq->node, &q_list);
 		dev->queue_count--;
 	}
+	synchronize_rcu();
+	entry = llist_del_all(&q_list);
+	llist_for_each_entry_safe(nvmeq, next, entry, node)
+		nvme_free_queue(nvmeq);
 }
 
 /**
@@ -2923,7 +2928,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
 	nvme_free_queues(dev, 0);
-	rcu_barrier();
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
-- 
1.7.10.4
