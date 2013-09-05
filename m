From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:15 -0600
Subject: [PATCH 9/9] NVMe: Don't wait for delete queues to complete
In-Reply-To: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
Message-ID: <1378413915-16667-10-git-send-email-keith.busch@intel.com>

Skip sending the delete queue commands if the controller is unresponsive
so the driver does not hold up a shutdown sequence. Previously it would
take 2 minutes per IO queue on a broken device.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 2c99e17..5ee9f61 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -908,17 +908,13 @@ int nvme_submit_admin_cmd(struct nvme_dev *dev, struct nvme_command *cmd,
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
 {
-	int status;
 	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
 	c.delete_queue.opcode = opcode;
 	c.delete_queue.qid = cpu_to_le16(id);
 
-	status = nvme_submit_admin_cmd(dev, &c, NULL);
-	if (status)
-		return -EIO;
-	return 0;
+	return nvme_submit_admin_cmd(dev, &c, NULL);
 }
 
 static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
@@ -1119,7 +1115,7 @@ static void nvme_free_queues(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_disable_queue(struct nvme_dev *dev, int qid)
+static int nvme_disable_queue(struct nvme_dev *dev, int qid, int del_q)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
 	int vector = dev->entry[nvmeq->cq_vector].vector;
@@ -1127,7 +1123,7 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	spin_lock_irq(&nvmeq->q_lock);
 	if (nvmeq->q_suspended) {
 		spin_unlock_irq(&nvmeq->q_lock);
-		return;
+		return del_q;
 	}
 	nvmeq->q_suspended = 1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1136,15 +1132,17 @@ static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 	free_irq(vector, nvmeq);
 
 	/* Don't tell the adapter to delete the admin queue */
-	if (qid) {
-		adapter_delete_sq(dev, qid);
-		adapter_delete_cq(dev, qid);
-	}
+	if (qid && del_q)
+		if (adapter_delete_sq(dev, qid) < 0 ||
+					adapter_delete_cq(dev, qid) < 0)
+			del_q = 0;
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
 	nvme_cancel_ios(nvmeq, false);
 	spin_unlock_irq(&nvmeq->q_lock);
+
+	return del_q;
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
@@ -1925,8 +1923,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	for (i = 1; i < dev->queue_count; i++) {
 		result = nvme_create_queue(dev->queues[i], i);
 		if (result) {
-			for (--i; i > 0; i--)
-				nvme_disable_queue(dev, i);
+			int del_q = 1;
+
+			for (--i; i >= 0; i--)
+				del_q = nvme_disable_queue(dev, i, del_q);
 			goto free_queues;
 		}
 	}
@@ -2074,10 +2074,10 @@ static void nvme_dev_unmap(struct nvme_dev *dev)
 
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
1.7.0.4
