From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 12 Feb 2018 20:57:02 +0800
Subject: [PATCH] nvme-pci: drain the entered requests after ctrl is shutdown
Message-ID: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>

Currently, we will unquiesce the queues after the controller is
shutdown to avoid residual requests to be stuck. In fact, we can
do it more cleanly, just wait freeze and drain the queue in
nvme_dev_disable and finally leave the queues quiesced.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4a7c420..6e5d2ca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2183,10 +2183,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead) {
-		if (shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
-	}
+	if (!dead && shutdown)
+		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
@@ -2211,12 +2209,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
 
-- 
2.7.4
