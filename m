From: keith.busch@intel.com (Keith Busch)
Date: Wed,  5 Oct 2016 16:32:45 -0400
Subject: [PATCH 1/2] nvme: don't schedule multiple resets
Message-ID: <1475699566-5284-1-git-send-email-keith.busch@intel.com>

The queue_work only fails if the work is pending, but not yet running. If
the work is running, the work item would get requeued, triggering a
double reset. If the first reset fails for any reason, the second
reset triggers:

	WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING)

Hitting that schedules controller deletion for a second time, which
potentially takes a reference on the device that is being deleted.
If the reset occurs at the same time as a hot removal event, this causes
a double-free.

This patch has the reset helper function check if the work is busy
prior to queueing, and changes all places that schedule resets to use
this function. Since most users don't want to sync with that work, the
"flush_work" is moved to the only caller that wants to sync.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 47a44e9..108d301 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -892,7 +892,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
-		queue_work(nvme_workq, &dev->reset_work);
+		nvme_reset(dev);
 
 		/*
 		 * Mark the request as handled, since the inline shutdown
@@ -1290,7 +1290,7 @@ static void nvme_watchdog_timer(unsigned long data)
 
 	/* Skip controllers under certain specific conditions. */
 	if (nvme_should_reset(dev, csts)) {
-		if (queue_work(nvme_workq, &dev->reset_work))
+		if (!nvme_reset(dev))
 			dev_warn(dev->dev,
 				"Failed status: 0x%x, reset controller.\n",
 				csts);
@@ -1812,11 +1812,10 @@ static int nvme_reset(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
 		return -ENODEV;
-
+	if (work_busy(&dev->reset_work))
+		return -ENODEV;
 	if (!queue_work(nvme_workq, &dev->reset_work))
 		return -EBUSY;
-
-	flush_work(&dev->reset_work);
 	return 0;
 }
 
@@ -1840,7 +1839,12 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 
 static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
 {
-	return nvme_reset(to_nvme_dev(ctrl));
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	int ret = nvme_reset(dev);
+
+	if (!ret)
+		flush_work(&dev->reset_work);
+	return ret;
 }
 
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
@@ -1934,7 +1938,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 	if (prepare)
 		nvme_dev_disable(dev, false);
 	else
-		queue_work(nvme_workq, &dev->reset_work);
+		nvme_reset(dev);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
@@ -2003,7 +2007,7 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	queue_work(nvme_workq, &ndev->reset_work);
+	nvme_reset(ndev);
 	return 0;
 }
 #endif
@@ -2042,7 +2046,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	queue_work(nvme_workq, &dev->reset_work);
+	nvme_reset(dev);
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
-- 
2.7.2
