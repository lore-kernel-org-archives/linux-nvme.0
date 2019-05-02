From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu,  2 May 2019 17:59:21 +0900
Subject: [PATCH 4/4] nvme-pci: trigger device coredump before resetting
 controller
In-Reply-To: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1556787561-5113-5-git-send-email-akinobu.mita@gmail.com>

This enables the nvme driver to trigger a device coredump before resetting
the controller caused by I/O timeout.

The device coredump helps diagnose and debug issues.

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/nvme/host/pci.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7f3077c..584c2aa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -87,7 +87,7 @@ MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool dump);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
 /*
@@ -1286,7 +1286,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
 	}
@@ -1313,7 +1313,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	default:
@@ -1329,7 +1329,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, true);
 		nvme_reset_ctrl(&dev->ctrl);
 
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
@@ -2396,7 +2396,9 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_coredump(struct device *dev);
+
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool dump)
 {
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -2421,6 +2423,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
+	if (dump)
+		nvme_coredump(dev->dev);
+
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
@@ -2488,7 +2493,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 	dev_warn(dev->ctrl.device, "Removing after probe failure status: %d\n", status);
 
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, false, false);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
@@ -2510,7 +2515,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, false);
 
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
@@ -2799,7 +2804,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, false, false);
 }
 
 static void nvme_reset_done(struct pci_dev *pdev)
@@ -2811,7 +2816,7 @@ static void nvme_reset_done(struct pci_dev *pdev)
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, true, false);
 }
 
 /*
@@ -2828,14 +2833,14 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, true, false);
 		nvme_dev_remove_admin(dev);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, true, false);
 	nvme_release_cmb(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
@@ -2852,7 +2857,7 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_dev_disable(ndev, true);
+	nvme_dev_disable(ndev, true, false);
 	return 0;
 }
 
@@ -3103,7 +3108,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, false, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
-- 
2.7.4
