From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri,  2 Feb 2018 15:00:49 +0800
Subject: [PATCH 6/6] nvme-pci: suspend queues based on online_queues
In-Reply-To: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1517554849-7802-7-git-send-email-jianchao.w.wang@oracle.com>

nvme cq irq is freed based on queue_count. When the sq/cq creation
fails, irq will not be setup. free_irq will warn 'Try to free
already-free irq'.

To fix it, we only increase online_queues when adminq/sq/cq are
created and associated irq is setup. Then suspend queues based
on online_queues.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a838713c..e37f209 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1349,9 +1349,6 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
-
 	pci_free_irq(to_pci_dev(nvmeq->dev->dev), vector, nvmeq);
 
 	return 0;
@@ -1495,13 +1492,15 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
-		goto release_sq;
+		goto offline;
 
 	return result;
 
- release_sq:
+offline:
+	dev->online_queues--;
+release_sq:
 	adapter_delete_sq(dev, qid);
- release_cq:
+release_cq:
 	adapter_delete_cq(dev, qid);
 	return result;
 }
@@ -1641,6 +1640,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
+		dev->online_queues--;
 		return result;
 	}
 
@@ -1988,6 +1988,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	result = queue_request_irq(adminq);
 	if (result) {
 		adminq->cq_vector = -1;
+		dev->online_queues--;
 		return result;
 	}
 	return nvme_create_io_queues(dev);
@@ -2257,13 +2258,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	int i;
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int onlines;
 
 	mutex_lock(&dev->shutdown_lock);
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
-			pdev->error_state  != pci_channel_io_normal);
+		dead = !!((csts & NVME_CSTS_CFS) ||
+				!(csts & NVME_CSTS_RDY) ||
+				(pdev->error_state  != pci_channel_io_normal) ||
+				(dev->online_queues == 0));
 	}
 
 	/* Just freeze the queue for shutdown case */
@@ -2297,9 +2301,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_pci_cancel_rq, &dev->ctrl);
@@ -2444,12 +2453,12 @@ static void nvme_reset_work(struct work_struct *work)
 	 * Keep the controller around but remove all namespaces if we don't have
 	 * any working I/O queue.
 	 */
-	if (dev->online_queues < 2) {
+	if (dev->online_queues == 1) {
 		dev_warn(dev->ctrl.device, "IO queues not created\n");
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
-	} else {
+	} else if (dev->online_queues > 1) {
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
-- 
2.7.4
