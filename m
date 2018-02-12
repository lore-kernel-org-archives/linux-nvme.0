From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 12 Feb 2018 20:59:15 +0800
Subject: [PATCH 5/8] nvme-pci: suspend queues based on online_queues
Message-ID: <1518440355-801-1-git-send-email-jianchao.w.wang@oracle.com>

nvme cq irq is freed based on queue_count. When the sq/cq creation
fails, irq will not be setup. free_irq will warn 'Try to free
already-free irq'.

To fix it, we only increase online_queues when adminq/sq/cq are
created and associated irq is setup. Then suspend queues based
on online_queues.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0cba8d8..2106681 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1317,9 +1317,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
-
 	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
 
 	return 0;
@@ -1463,13 +1460,14 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
-		goto release_sq;
+		goto offline;
 
 	return result;
 
- release_sq:
+offline:
+	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
- release_cq:
+release_cq:
 	adapter_delete_cq(dev, qid);
 	return result;
 }
@@ -1609,6 +1607,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
+		dev->online_queues--;
 		return result;
 	}
 
@@ -1956,6 +1955,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	result = queue_request_irq(adminq);
 	if (result) {
 		adminq->cq_vector = -1;
+		dev->online_queues--;
 		return result;
 	}
 	return nvme_create_io_queues(dev);
@@ -2169,6 +2169,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	int i;
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int onlines;
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(pdev)) {
@@ -2177,8 +2178,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
 		    dev->ctrl.state == NVME_CTRL_RESETTING)
 			nvme_start_freeze(&dev->ctrl);
-		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
-			pdev->error_state  != pci_channel_io_normal);
+
+		dead = !!((csts & NVME_CSTS_CFS) ||
+				!(csts & NVME_CSTS_RDY) ||
+				(pdev->error_state  != pci_channel_io_normal) ||
+				(dev->online_queues == 0));
 	}
 
 	/*
@@ -2204,9 +2208,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
-	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
+
+	onlines = dev->online_queues;
+	for (i = onlines - 1; i >= 0; i--)
 		nvme_suspend_queue(&dev->queues[i]);
 
+	if (dev->ctrl.admin_q)
+		blk_mq_quiesce_queue(dev->ctrl.admin_q);
+
 	nvme_pci_disable(dev);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
@@ -2342,16 +2351,18 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	/*
-	 * Keep the controller around but remove all namespaces if we don't have
-	 * any working I/O queue.
-	 */
-	if (dev->online_queues < 2) {
+
+	/* In case of online_queues is zero, it has gone to out */
+	if (dev->online_queues == 1) {
+		/*
+		 * Keep the controller around but remove all namespaces if we
+		 * don't have any working I/O queue.
+		 */
 		dev_warn(dev->ctrl.device, "IO queues not created\n");
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
-	} else {
+	} else if (dev->online_queues > 1) {
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
-- 
2.7.4
