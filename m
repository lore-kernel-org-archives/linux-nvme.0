From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Dec 2015 09:41:56 -0700
Subject: [PATCHv2 5/5] NVMe: Shutdown controller only for power-off
In-Reply-To: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
References: <1451580116-12252-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451580116-12252-6-git-send-email-keith.busch@intel.com>

We don't need to shutdown a controller for a reset. A controller in a
shutdown state may take longer to become ready than one that was simply
disabled. This patch has the driver shut down the controller only if it
is about to be powered off or being removed. When taking the controller
down for a reset reason, the controller will only be disabled instead.

Function names have been updated in this patch to reflect their changed
semantics.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d2eecd8..eb37ef6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -87,7 +87,7 @@ struct nvme_queue;
 static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev);
-static void nvme_dev_shutdown(struct nvme_dev *dev);
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -933,7 +933,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->dev,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_shutdown(dev);
+		nvme_dev_disable(dev, false);
 		req->errors = NVME_SC_CANCELLED;
 		return BLK_EH_HANDLED;
 	}
@@ -947,7 +947,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->dev,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_shutdown(dev);
+		nvme_dev_disable(dev, false);
 		queue_work(nvme_workq, &dev->reset_work);
 
 		/*
@@ -1066,21 +1066,20 @@ static void nvme_clear_queue(struct nvme_queue *nvmeq)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static void nvme_disable_queue(struct nvme_dev *dev, int qid)
+static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
-	struct nvme_queue *nvmeq = dev->queues[qid];
+	struct nvme_queue *nvmeq = dev->queues[0];
 
 	if (!nvmeq)
 		return;
 	if (nvme_suspend_queue(nvmeq))
 		return;
 
-	/* Don't tell the adapter to delete the admin queue.
-	 * Don't tell a removed adapter to delete IO queues. */
-	if (qid && readl(dev->bar + NVME_REG_CSTS) != -1) {
-		adapter_delete_sq(dev, qid);
-		adapter_delete_cq(dev, qid);
-	}
+	if (shutdown)
+		nvme_shutdown_ctrl(&dev->ctrl);
+	else
+		nvme_disable_ctrl(&dev->ctrl, lo_hi_readq(
+						dev->bar + NVME_REG_CAP));
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
@@ -1842,7 +1841,7 @@ static void nvme_start_queues(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_shutdown(struct nvme_dev *dev)
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	int i;
 	u32 csts = -1;
@@ -1861,8 +1860,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 		}
 	} else {
 		nvme_disable_io_queues(dev);
-		nvme_shutdown_ctrl(&dev->ctrl);
-		nvme_disable_queue(dev, 0);
+		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_dev_unmap(dev);
 
@@ -1921,7 +1919,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->bar)
-		nvme_dev_shutdown(dev);
+		nvme_dev_disable(dev, false);
 
 	set_bit(NVME_CTRL_RESETTING, &dev->flags);
 
@@ -1975,7 +1973,7 @@ static void nvme_reset_work(struct work_struct *work)
 	dev->ctrl.admin_q = NULL;
 	dev->queues[0]->tags = NULL;
  disable:
-	nvme_disable_queue(dev, 0);
+	nvme_disable_admin_queue(dev, false);
  unmap:
 	nvme_dev_unmap(dev);
  out:
@@ -2110,7 +2108,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
 	if (prepare)
-		nvme_dev_shutdown(dev);
+		nvme_dev_disable(dev, false);
 	else
 		queue_work(nvme_workq, &dev->reset_work);
 }
@@ -2118,7 +2116,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_shutdown(dev);
+	nvme_dev_disable(dev, true);
 }
 
 static void nvme_remove(struct pci_dev *pdev)
@@ -2134,7 +2132,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_uninit_ctrl(&dev->ctrl);
-	nvme_dev_shutdown(dev);
+	nvme_dev_disable(dev, true);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
 	nvme_release_cmb(dev);
@@ -2148,7 +2146,7 @@ static int nvme_suspend(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_dev_shutdown(ndev);
+	nvme_dev_disable(ndev, true);
 	return 0;
 }
 
@@ -2179,7 +2177,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
-		nvme_dev_shutdown(dev);
+		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		return PCI_ERS_RESULT_DISCONNECT;
-- 
2.6.2.307.g37023ba
