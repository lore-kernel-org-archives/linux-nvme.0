From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:43 +0100
Subject: [PATCH 08/26] nvme: simplify resets
In-Reply-To: <1448995981-11982-1-git-send-email-hch@lst.de>
References: <1448995981-11982-1-git-send-email-hch@lst.de>
Message-ID: <1448995981-11982-9-git-send-email-hch@lst.de>

Don't delete the controller from dev_list before queuing a reset, instead
just check for it being reset in the polling kthread.  This allows to remove
the dev_list_lock in various places, and in addition we can simply rely on
checking the queue_work return value to see if we could reset a controller.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e683bd1..febcef5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -77,7 +77,6 @@ struct nvme_dev;
 struct nvme_queue;
 struct nvme_iod;
 
-static int __nvme_reset(struct nvme_dev *dev);
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_unmap_data(struct nvme_dev *dev, struct nvme_iod *iod);
@@ -1093,13 +1092,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * the admin queue.
 	 */
 	if (!nvmeq->qid || cmd_rq->aborted) {
-		spin_lock_irq(&dev_list_lock);
-		if (!__nvme_reset(dev)) {
+		if (queue_work(nvme_workq, &dev->reset_work)) {
 			dev_warn(dev->dev,
 				 "I/O %d QID %d timeout, reset controller\n",
 				 req->tag, nvmeq->qid);
 		}
-		spin_unlock_irq(&dev_list_lock);
 		return BLK_EH_RESET_TIMER;
 	}
 
@@ -1496,9 +1493,15 @@ static int nvme_kthread(void *data)
 			int i;
 			u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
+			/*
+			 * Skip controllers currently under reset.
+			 */
+			if (work_pending(&dev->reset_work) || work_busy(&dev->reset_work))
+				continue;
+
 			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
 							csts & NVME_CSTS_CFS) {
-				if (!__nvme_reset(dev)) {
+				if (queue_work(nvme_workq, &dev->reset_work)) {
 					dev_warn(dev->dev,
 						"Failed status: %x, reset controller\n",
 						readl(dev->bar + NVME_REG_CSTS));
@@ -2228,33 +2231,17 @@ static void nvme_reset_work(struct work_struct *ws)
 	schedule_work(&dev->probe_work);
 }
 
-static int __nvme_reset(struct nvme_dev *dev)
-{
-	if (work_pending(&dev->reset_work))
-		return -EBUSY;
-	list_del_init(&dev->node);
-	queue_work(nvme_workq, &dev->reset_work);
-	return 0;
-}
-
 static int nvme_reset(struct nvme_dev *dev)
 {
-	int ret;
-
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
 		return -ENODEV;
 
-	spin_lock(&dev_list_lock);
-	ret = __nvme_reset(dev);
-	spin_unlock(&dev_list_lock);
-
-	if (!ret) {
-		flush_work(&dev->reset_work);
-		flush_work(&dev->probe_work);
-		return 0;
-	}
+	if (!queue_work(nvme_workq, &dev->reset_work))
+		return -EBUSY;
 
-	return ret;
+	flush_work(&dev->reset_work);
+	flush_work(&dev->probe_work);
+	return 0;
 }
 
 static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
-- 
1.9.1
