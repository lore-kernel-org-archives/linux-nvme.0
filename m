From: hch@lst.de (Christoph Hellwig)
Date: Mon, 29 Feb 2016 15:59:44 +0100
Subject: [PATCH 1/4] nvme: use a work item to submit async event requests
In-Reply-To: <1456757987-7244-1-git-send-email-hch@lst.de>
References: <1456757987-7244-1-git-send-email-hch@lst.de>
Message-ID: <1456757987-7244-2-git-send-email-hch@lst.de>

Use a dedicated work item to submit async event requests instead of the
global kthread.  This simplifies the code and reduces the latencies to
resubmit a request once an even notification happened.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/pci.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fec7479..21b0be4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -100,6 +100,7 @@ struct nvme_dev {
 	struct work_struct reset_work;
 	struct work_struct scan_work;
 	struct work_struct remove_work;
+	struct work_struct async_work;
 	struct mutex shutdown_lock;
 	bool subsystem;
 	void __iomem *cmb;
@@ -281,8 +282,11 @@ static void nvme_complete_async_event(struct nvme_dev *dev,
 	u16 status = le16_to_cpu(cqe->status) >> 1;
 	u32 result = le32_to_cpu(cqe->result);
 
-	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
+	if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ) {
 		++dev->ctrl.event_limit;
+		queue_work(nvme_workq, &dev->async_work);
+	}
+
 	if (status != NVME_SC_SUCCESS)
 		return;
 
@@ -816,15 +820,22 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
 	return 0;
 }
 
-static void nvme_submit_async_event(struct nvme_dev *dev)
+static void nvme_async_event_work(struct work_struct *work)
 {
+	struct nvme_dev *dev = container_of(work, struct nvme_dev, async_work);
+	struct nvme_queue *nvmeq = dev->queues[0];
 	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
-	c.common.command_id = NVME_AQ_BLKMQ_DEPTH + --dev->ctrl.event_limit;
 
-	__nvme_submit_cmd(dev->queues[0], &c);
+	spin_lock_irq(&nvmeq->q_lock);
+	while (dev->ctrl.event_limit > 0) {
+		c.common.command_id = NVME_AQ_BLKMQ_DEPTH +
+			--dev->ctrl.event_limit;
+		__nvme_submit_cmd(nvmeq, &c);
+	}
+	spin_unlock_irq(&nvmeq->q_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1358,9 +1369,6 @@ static int nvme_kthread(void *data)
 					continue;
 				spin_lock_irq(&nvmeq->q_lock);
 				nvme_process_cq(nvmeq);
-
-				while (i == 0 && dev->ctrl.event_limit > 0)
-					nvme_submit_async_event(dev);
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
 		}
@@ -1929,6 +1937,7 @@ static void nvme_reset_work(struct work_struct *work)
 		goto free_tags;
 
 	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
+	queue_work(nvme_workq, &dev->async_work);
 
 	result = nvme_dev_list_add(dev);
 	if (result)
@@ -2062,6 +2071,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
+	INIT_WORK(&dev->async_work, nvme_async_event_work);
 	mutex_init(&dev->shutdown_lock);
 	init_completion(&dev->ioq_wait);
 
@@ -2115,6 +2125,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	spin_unlock(&dev_list_lock);
 
 	pci_set_drvdata(pdev, NULL);
+	flush_work(&dev->async_work);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
-- 
2.1.4
