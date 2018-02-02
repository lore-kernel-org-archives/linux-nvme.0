From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri,  2 Feb 2018 15:00:45 +0800
Subject: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown and
 reset case
In-Reply-To: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1517554849-7802-3-git-send-email-jianchao.w.wang@oracle.com>

Currently, request queue will be frozen and quiesced for both reset
and shutdown case. This will trigger ioq requests in RECONNECTING
state which should be avoided to prepare for following patch.
Just freeze request queue for shutdown case and drain all the resudual
entered requests after controller has been shutdown.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 00cffed..a7fa397 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2172,21 +2172,23 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
-			nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
 	}
 
-	/*
-	 * Give the controller a chance to complete all entered requests if
-	 * doing a safe shutdown.
-	 */
-	if (!dead) {
-		if (shutdown)
+	/* Just freeze the queue for shutdown case */
+	if (shutdown) {
+		if (dev->ctrl.state == NVME_CTRL_LIVE ||
+			dev->ctrl.state == NVME_CTRL_RESETTING)
+			nvme_start_freeze(&dev->ctrl);
+		/*
+		 * Give the controller a chance to complete all
+		 * entered requests if doing a safe shutdown.
+		 */
+		if (!dead)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
+
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead) {
@@ -2210,12 +2212,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
 
 	/*
-	 * The driver will not be starting up queues again if shutting down so
-	 * must flush all entered requests to their failed completion to avoid
-	 * deadlocking blk-mq hot-cpu notifier.
+	 * For shutdown case, controller will not be setup again soon. If any
+	 * residual requests here, the controller must have go wrong. Drain and
+	 * fail all the residual entered IO requests.
 	 */
-	if (shutdown)
+	if (shutdown) {
 		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
+		nvme_stop_queues(&dev->ctrl);
+	}
 	mutex_unlock(&dev->shutdown_lock);
 }
 
@@ -2349,12 +2354,11 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+		if (was_suspend)
+			nvme_unfreeze(&dev->ctrl);
 	}
 
 	/*
-- 
2.7.4
