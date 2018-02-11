From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Sun, 11 Feb 2018 17:38:37 +0800
Subject: [PATCH 6/9] nvme-pci: drain the entered requests after ctrl is
 shutdown
In-Reply-To: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1518341920-1060-7-git-send-email-jianchao.w.wang@oracle.com>

Currently, we will unquiesce the queues after the controller is
shutdown to avoid residual requests to be stuck. In fact, we can
do it more cleanly, just wait freeze and drain them before
nvme_dev_disable return.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c5c1365..f3e0eae 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2187,10 +2187,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead) {
-		if (shutdown)
-			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
-	}
+	if (!dead && shutdown)
+		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead) {
@@ -2219,12 +2218,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
