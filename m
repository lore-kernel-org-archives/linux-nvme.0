From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Aug 2013 16:00:31 -0600
Subject: [PATCHv2 4/5] NVMe: Don't wait for delete queues to finish
In-Reply-To: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
References: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
Message-ID: <1376690432-9775-5-git-send-email-keith.busch@intel.com>

If a controller is unresponsive, the shutdown sequence was held
up waiting on the admin command to timeout when trying to delete IO
queues. The driver previously would wait on the timeout for each queue
created making the shutdown take a long time if the controller isn't
working. This patch will have the controller wait once, then skip
sending the delete queue commands if it ever failed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c07a507..cb64866 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1065,7 +1065,7 @@ static void nvme_free_queues(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_disable_queue(struct nvme_dev *dev, int qid)
+static int nvme_disable_queue(struct nvme_dev *dev, int qid, int del_q)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
 	int vector = dev->entry[nvmeq->cq_vector].vector;
@@ -1073,7 +1073,7 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	spin_lock_irq(&nvmeq->q_lock);
 	if (nvmeq->q_suspended) {
 		spin_unlock_irq(&nvmeq->q_lock);
-		return;
+		return del_q;
 	}
 	nvmeq->q_suspended = 1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1082,15 +1082,17 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	free_irq(vector, nvmeq);
 
 	/* Don't tell the adapter to delete the admin queue */
-	if (qid) {
-		adapter_delete_sq(dev, qid);
-		adapter_delete_cq(dev, qid);
+	if (qid && del_q) {
+		if (adapter_delete_sq(dev, qid) || adapter_delete_cq(dev, qid))
+			del_q = 0;
 	}
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
 	nvme_cancel_ios(nvmeq, false);
 	spin_unlock_irq(&nvmeq->q_lock);
+
+	return del_q;
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
@@ -1873,8 +1875,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	for (i = 1; i < dev->queue_count; i++) {
 		result = nvme_create_queue(dev->queues[i], i);
 		if (result) {
+			int del_q = 1;
 			for (--i; i > 0; i--)
-				nvme_disable_queue(dev, i);
+				del_q = nvme_disable_queue(dev, i, del_q);
 			goto free_queues;
 		}
 	}
@@ -2010,10 +2013,10 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
-	int i;
+	int i, del_q = 1;
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
-		nvme_disable_queue(dev, i);
+		del_q = nvme_disable_queue(dev, i, del_q);
 
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
-- 
1.7.10.4
